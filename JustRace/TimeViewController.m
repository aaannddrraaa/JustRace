//
//  TimeViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "TimeViewController.h"
#import <Parse/Parse.h>


@interface TimeViewController ()

@end

@implementation TimeViewController

@synthesize averageTime;
@synthesize bestTime;

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
    
    __block double best = 1000000;
    __block double time;
    __block double timeSum = 0;
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
                    time = [[(PFObject*)element objectForKey:@"time"] doubleValue];
                    timeSum += time;
                    if (time < best)
                    {
                        best = time;
                    }
                }
                averageTime.text = [NSString stringWithFormat:@"%f", timeSum / [parts count]];
                bestTime.text = [NSString stringWithFormat:@"%f", best];
                
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
