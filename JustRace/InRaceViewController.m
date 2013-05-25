//
//  InRaceViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "InRaceViewController.h"
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
           
        } else {
            NSLog(@"eroare = %@",error);
        }
    }];
    
    start = [NSDate date];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
    // [locationManager setDistanceFilter:5.0];
    
    // Do any additional setup after loading the view from its nib.
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
     
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation{
    
        if ([newLocation distanceFromLocation:finishLine] <= 5.0) {
            [timer invalidate];
            [manager stopUpdatingLocation];
            [self finishRace];
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
    
    FinishedRaceViewController *raceView = [[FinishedRaceViewController alloc] init];
    raceView.speed.text = [NSString stringWithFormat:@"%.1f",totalDistance/time];
    float t1 = floor(time / 3600);
    time = round(time - 3600*floor(time / 3600));
    float t2 = floor(time / 60);
    time = round(time - 60*floor(time / 60));
    raceView.time.text = [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", t1, t2, time];
    
    UINavigationController *nvcontrol = [[UINavigationController alloc] initWithRootViewController:raceView];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:nvcontrol.view];
    [[[[UIApplication sharedApplication] delegate] window]
     makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
