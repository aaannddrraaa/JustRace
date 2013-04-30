//
//  OrganisedRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "OrganisedRaceViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface OrganisedRaceViewController ()

@end

@implementation OrganisedRaceViewController

@synthesize race;

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
    
    self.nameLabel.text = [race objectForKey:@"raceName"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MM yyyy"];
    self.dateLabel.text = [formatter stringFromDate:[race objectForKey:@"raceDate"]];
    
    [formatter setDateFormat:@"hh:mm"];
    self.timeLabel.text = [formatter stringFromDate:[race objectForKey:@"raceTime"]];
    
    if([(NSDate *)[race objectForKey:@"raceDate"] earlierDate:[NSDate date]])
    {
        [self.buttonC setTitle:@"Participants" forState:UIControlStateNormal];
    }
    else
    {
        [self.buttonC setTitle:@"Results" forState:UIControlStateNormal];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)organizedRaceOpenMap:(id)sender {
    MapViewController *map = [[MapViewController alloc] initWithReturnController:self racePath:[race objectForKey:@"racePath"] editable:NO];
    [self.navigationController pushViewController:map animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setRace:race];
}

@end
