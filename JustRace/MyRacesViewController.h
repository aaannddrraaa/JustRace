//
//  MyRacesViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRacesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSDictionary *race;
@end
