//
//  FinishedRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 5/25/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "FinishedRaceViewController.h"
#import "RaceViewController.h"
#import "RaceAppDelegate.h"

@interface FinishedRaceViewController ()

@end

@implementation FinishedRaceViewController

@synthesize time;
@synthesize speed;
@synthesize tt;
@synthesize ss;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTime:(double)timee speed:(double)speeed
{
    self = [super init];
    if (self) {
        // Custom initialization
        tt = [NSNumber numberWithDouble:timee];
        ss = [NSNumber numberWithDouble:speeed];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.speed.text = [NSString stringWithFormat:@"%.1f",[ss doubleValue]];
    float t = [tt doubleValue];
    float t1 = floor(t / 3600);
    t = round(t - 3600*floor(t / 3600));
    float t2 = floor(t / 60);
    t = round(t - 60*floor(t / 60));
    self.time.text = [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", t1, t2, t];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clicked:(id)sender {
   // NSLog(@"button");
    UIStoryboard *storyBoard;
    UIViewController *storyboardViewController;
    storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    storyboardViewController = [storyBoard instantiateViewControllerWithIdentifier:@"login"];
    //  RaceViewController *raceView = [[RaceViewController alloc] init];
    [((RaceAppDelegate *)[[UIApplication sharedApplication] delegate]).nvcontrol pushViewController:storyboardViewController animated:YES];
}


@end
