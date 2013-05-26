//
//  InRaceViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "InRaceViewController.h"
#import "RaceAppDelegate.h"
#import "FinishedRaceViewController.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#include <stdlib.h>

@interface InRaceViewController ()

@end

@implementation InRaceViewController

NSTimer *timer;
NSDate *start;
NSMutableArray *speeds;
CLLocationDistance totalDistance = 0;
CLLocation *finishLine;
CLLocationManager *locationManager;
int finished=0;

@synthesize raceName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRace:(NSString *)raceNamee
{
    self = [super init];
    if (self) {
        self.raceName = raceNamee;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.raceName;
    speeds = [[NSMutableArray alloc] init];
    self.speed.text = @"0.0";
    self.distance.text = @"0";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Race"];
    [query whereKey:@"raceName" equalTo:self.raceName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            PFObject *race = [data objectAtIndex:0];
            GMSMutablePath *path = [[GMSPath pathFromEncodedPath:[race objectForKey:@"racePath"]] mutableCopy];
            CLLocationCoordinate2D coord = [path coordinateAtIndex:([path count]-1)];
            finishLine = [[CLLocation alloc] initWithLatitude:coord.latitude  longitude:coord.longitude];
            
            locationManager=[[CLLocationManager alloc]init];
            locationManager.delegate=self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter = 1.0;
            [locationManager startUpdatingLocation];
            
            start = [NSDate date];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        } else {
            NSLog(@"eroare = %@",error);
        }
    }];
    
   
    
    // Do any additional setup after loading the view from its nib.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation{
    double d = [newLocation distanceFromLocation:finishLine];
    if(d<0) d=d*(-1);
    if (d <= 5.0) {
        finished = 1;
    }
    else
    {
        [speeds addObject:[NSNumber numberWithDouble:newLocation.speed]];
        double dist = [newLocation getDistanceFrom:oldLocation];
        totalDistance += dist;
        self.distance.text = [NSString stringWithFormat:@"%.0f",dist];
        self.speed.text = [NSString stringWithFormat:@"%.1f",newLocation.speed];
    }
    
}

-(IBAction)tick:(id)sender
{
    if (finished == 1) {
        [timer invalidate];
        [locationManager stopUpdatingLocation];
        [self finishRace];
        return;
    }
    
    NSTimeInterval time = [start timeIntervalSinceNow];
    time = time * (-1);
    
    self.hours.text = [NSString stringWithFormat:@"%02.0f", floor(time / 3600)];
    time = round(time - 3600*floor(time / 3600));
    self.minutes.text = [NSString stringWithFormat:@"%02.0f", floor(time / 60)];
    time = round(time - 60*floor(time / 60));
    self.seconds.text = [NSString stringWithFormat:@"%02.0f", time];
}

-(void)finishRace
{
    int r = arc4random() % 10;
    totalDistance = 1000 * r;
    
    NSTimeInterval time = [start timeIntervalSinceNow];
    time = time * (-1);
    if(time<=100) time = 100;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Participation"];
    [query whereKey:@"raceName" equalTo:self.raceName];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            PFObject *part = [data objectAtIndex:0];
            [part setObject:[NSNumber numberWithDouble:totalDistance] forKey:@"distance"];
            [part setObject:[NSNumber numberWithDouble:time] forKey:@"time"];
            [part setObject:[NSNumber numberWithDouble:totalDistance/time] forKey:@"speed"];
            [part saveInBackground];
        } else {
            NSLog(@"eroare = %@",error);
        }
    }];
    
    FinishedRaceViewController *raceView = [[FinishedRaceViewController alloc] initWithTime:time speed:totalDistance/time];
    
    [((RaceAppDelegate *)[[UIApplication sharedApplication] delegate]).nvcontrol pushViewController:raceView animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)giveUp:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Participation"];
    [query whereKey:@"raceName" equalTo:self.raceName];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            PFObject *part = [data objectAtIndex:0];
            [part deleteInBackground];
        } else{
            NSLog(@"eroare = %@",error);
        }
    }];
    UIStoryboard *storyBoard;
    UIViewController *storyboardViewController;
    storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    storyboardViewController = [storyBoard instantiateViewControllerWithIdentifier:@"login"];
    //  RaceViewController *raceView = [[RaceViewController alloc] init];
    [((RaceAppDelegate *)[[UIApplication sharedApplication] delegate]).nvcontrol pushViewController:storyboardViewController animated:YES];
}

@end
