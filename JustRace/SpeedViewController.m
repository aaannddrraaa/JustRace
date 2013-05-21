//
//  SpeedViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "SpeedViewController.h"
#import <Parse/Parse.h>

@interface SpeedViewController ()

@end

@implementation SpeedViewController

@synthesize bestSpeed;
@synthesize averageSpeed;

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
   
    __block double best = 0;
    __block double speed;
    __block double speedSum = 0;
    __block NSEnumerator * enumerator;
    __block id element;

    PFQuery *query = [PFQuery queryWithClassName:@"Participation"];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            parts = data;
            enumerator = [parts objectEnumerator];
            if ([parts count] > 0){
                while (element = [enumerator nextObject]) {
                    speed = [[(PFObject*)element objectForKey:@"speed"] doubleValue];
                    speedSum += speed;
                    if (speed > best)
                    {
                        best = speed;
                    }
                }
                averageSpeed.text = [NSString stringWithFormat:@"%f", speedSum / [parts count]];
                bestSpeed.text = [NSString stringWithFormat:@"%f", best];
                
            }
        } else {
            NSLog(@"eroare = %@",error);
        }
    }];

       
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
