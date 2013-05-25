//
//  AttendedRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "AttendedRaceViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface AttendedRaceViewController ()

@end

@implementation AttendedRaceViewController

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

    //NSLog(@"%@",[race objectForKey:@"username"]);
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:[race objectForKey:@"username"]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            NSLog(@"%@",data);
            self.organizerLabel.text = [[data objectAtIndex:0] objectForKey:@"name"];
        } else{
            NSLog(@"eroare = %@",error);
        }
    }];
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)attendedRaceOpenMap:(id)sender {
    MapViewController *map = [[MapViewController alloc] initWithReturnController:self racePath:[race objectForKey:@"racePath"] editable:NO];
    [self.navigationController pushViewController:map animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setRace:race];
}

@end
