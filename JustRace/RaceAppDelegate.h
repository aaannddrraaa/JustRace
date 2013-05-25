//
//  RaceAppDelegate.h
//  JustRace
//
//  Created by Andra Mititelu on 3/30/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UINavigationController *nvcontrol;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UILocalNotification *lastNotification;
@end
