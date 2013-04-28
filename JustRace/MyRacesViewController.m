//
//  MyRacesViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "MyRacesViewController.h"
#import "MapViewController.h"

@interface MyRacesViewController ()

@end

@implementation MyRacesViewController

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
    
    /*NSLog(@"%@",[race objectForKey:@"username"]);
     PFQuery *query = [PFQuery queryWithClassName:@"User"];
     [query whereKey:@"username" equalTo:[race objectForKey:@"username"]];
     
     [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
     if (!error){
     NSLog(@"%@",data);
     self.organizerLabel.text = [[data objectAtIndex:0] objectForKey:@"name"];
     } else{
     NSLog(@"eroare = %@",error);
     }
     }];
     */
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)activeRaceOpenMap:(id)sender {
    MapViewController *map = [[MapViewController alloc] initWithReturnController:self racePath:[race objectForKey:@"racePath"] editable:NO];
    [self.navigationController pushViewController:map animated:YES];
}

@end
