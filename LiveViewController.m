//
//  LiveViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "LiveViewController.h"
#import "InRaceViewController.h"
#import "RaceAppDelegate.h"
#import <Parse/Parse.h>

@interface LiveViewController ()

@end

@implementation LiveViewController

int timeLeft = 300;
NSTimer *timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRace:(NSString *)raceName
{
    self = [super init];
    if (self) {
        self.raceName = raceName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Race Countdown";
    self.raceNameLabel.text = self.raceName;
    self.raceNameLabel.textAlignment = NSTextAlignmentCenter;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Race"];
    [query whereKey:@"raceName" equalTo:self.raceName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error && [data count] > 0){
            NSDate *raceDate = [[data objectAtIndex:0] objectForKey:@"raceDate"];
            NSDate *raceTime = [[data objectAtIndex:0] objectForKey:@"raceTime"];
            NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
            
            // Break the date up into components
            NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:raceDate];
            NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:raceTime];
            
            // Set up the fire time
            NSDateComponents *dateComps = [[NSDateComponents alloc] init];
            [dateComps setDay:[dateComponents day]];
            [dateComps setMonth:[dateComponents month]];
            [dateComps setYear:[dateComponents year]];
            [dateComps setHour:[timeComponents hour]];
            // Notification will fire in one minute
            [dateComps setMinute:[timeComponents minute]];
            [dateComps setSecond:[timeComponents second]];
            NSDate *itemDate = [calendar dateFromComponents:dateComps];
            NSTimeInterval interval = [itemDate timeIntervalSinceNow];
            timeLeft = (int) interval;
            
        } else{
            timeLeft = 300;
            NSLog(@"eroare = %@",error);
        }
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)tick:(id)sender
{
    if(timeLeft>0)
    {
        timeLeft--;
        //timeLeft = timeLeft - 100;
        self.secondsLeft.text = [NSString stringWithFormat:@"%02d", timeLeft % 60];
        self.minutesLeft.text = [NSString stringWithFormat:@"%02d", timeLeft / 60];
    }
    else
    {
        [timer invalidate];
        InRaceViewController *raceView = [[InRaceViewController alloc] initWithRace:self.raceName];
        [((RaceAppDelegate *)[[UIApplication sharedApplication] delegate]).nvcontrol pushViewController:raceView animated:YES];
    }
    
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
