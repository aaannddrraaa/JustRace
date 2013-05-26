//
//  RaceAppDelegate.m
//  JustRace
//
//  Created by Andra Mititelu on 3/30/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "RaceAppDelegate.h"
#import <Parse/Parse.h>
#import "LiveViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <GoogleMaps/GoogleMaps.h>

@implementation RaceAppDelegate
@synthesize nvcontrol;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"89IKtEo8MJrWF3oy5nfAdgSpcWgjr31KiimQ0Q48"
                  clientKey:@"ZtFSnMfnfyGLU0KznbUCoIlLeZhOgQbrf4PBUNdl"];
    [PFFacebookUtils initializeFacebook];
    [GMSServices provideAPIKey:@"AIzaSyCTtphm7zpgaealiUN1S5alkBdAYv98FDs"];
    
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"launched with notification");
        LiveViewController *live = [[LiveViewController alloc] initWithRace:[localNotif.userInfo objectForKey:@"raceName"]];
        nvcontrol = [[UINavigationController alloc] initWithRootViewController:live];
        
        [self.window addSubview:nvcontrol.view];
        [self.window makeKeyAndVisible];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    self.lastNotification = notification;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Get ready!"
                                                        message:@"A new race is about to start."
                                                       delegate:self cancelButtonTitle:@"Give up"
                                              otherButtonTitles:nil];
    [alertView addButtonWithTitle:@"To race"];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *raceName = [self.lastNotification.userInfo objectForKey:@"raceName"];
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Give up"])
    {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        PFQuery *query = [PFQuery queryWithClassName:@"Participation"];
        [query whereKey:@"raceName" equalTo:raceName];
        [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
            if (!error){
                PFObject *part = [data objectAtIndex:0];
                [part deleteInBackground];
            } else{
                NSLog(@"eroare = %@",error);
            }
        }];
        
    }
    else
    {
        LiveViewController *live = [[LiveViewController alloc] initWithRace:raceName];
        nvcontrol = [[UINavigationController alloc] initWithRootViewController:live];
        [self.window addSubview:nvcontrol.view];
        [self.window makeKeyAndVisible];
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}

@end
