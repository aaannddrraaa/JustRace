//
//  FinishedRaceViewController.h
//  JustRace
//
//  Created by Laborator iOS on 5/25/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishedRaceViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *time;
@property (nonatomic, strong) IBOutlet UILabel *speed;
@property (nonatomic, strong) NSNumber *tt;
@property (nonatomic, strong) NSNumber *ss;

- (id)initWithTime:(double)timee speed:(double)speeed;
- (IBAction)clicked:(id)sender;
@end
