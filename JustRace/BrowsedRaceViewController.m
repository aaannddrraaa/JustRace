//
//  BrowsedRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "BrowsedRaceViewController.h"
#import "MapViewController.h"

@interface BrowsedRaceViewController ()

@end

@implementation BrowsedRaceViewController

@synthesize racePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.racePath = [[GMSMutablePath alloc] init];
    [self.racePath addLatitude:44.4167 longitude:26.1000];
    [self.racePath addLatitude:44.5277 longitude:26.2010];
    [self.racePath addLatitude:44.4387 longitude:26.1020];
    [self.racePath addLatitude:44.4497 longitude:26.1030];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)browsedRaceOpenMap:(id)sender {
    MapViewController *map = [[MapViewController alloc] initWithReturnController:self racePath:self.racePath editable:NO];
    [self.navigationController pushViewController:map animated:YES];
}

@end
