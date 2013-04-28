//
//  OrganisedRaceViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface OrganisedRaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonC;
@property (nonatomic, strong) NSDictionary *race;
@end
