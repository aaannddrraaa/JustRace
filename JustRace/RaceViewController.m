//
//  RaceViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 3/30/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "RaceViewController.h"
#import "LoggedInViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface RaceViewController ()

@end

@implementation RaceViewController

- (void)viewDidLoad
{
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        [self performSegueWithIdentifier:@"toLoggedIn" sender:nil];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
      //  [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self performSegueWithIdentifier:@"toLoggedIn" sender:nil];
           // [self.navigationController pushViewController:[[LoggedInViewController alloc] init] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:@"toLoggedIn" sender:nil];
//            [self.navigationController pushViewController:[[LoggedInViewController alloc] init] animated:YES];
        }
    }];
}

@end
