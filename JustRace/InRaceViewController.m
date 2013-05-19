//
//  InRaceViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "InRaceViewController.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>

@interface InRaceViewController ()

@end

@implementation InRaceViewController

NSTimer *timer;
NSDate *start;
NSMutableArray *speeds;
CLLocationDistance totalDistance = 0;

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
    
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
    [locationManager setDistanceFilter:10.0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Race"];
    [query whereKey:@"raceName" equalTo:self.raceName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            PFObject *race = [data objectAtIndex:0];
            GMSMutablePath *path = [[GMSPath pathFromEncodedPath:[race objectForKey:@"racePath"]] mutableCopy];
            CLLocationCoordinate2D finishLine = [path coordinateAtIndex:([path count]-1)];
            CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:finishLine radius:5.0 identifier:@"finish"];
            [locationManager startMonitoringForRegion:region];
           
        } else {
            NSLog(@"eroare = %@",error);
        }
    }];
    
    start = [NSDate date];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [timer invalidate];
    [manager stopMonitoringForRegion:region];
    [manager stopUpdatingLocation];
    [self finishRace];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation{
    if(newLocation.speed != -1.0)
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
    // do something with totalDistance
    // do something with NSArray of speed recordings
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
