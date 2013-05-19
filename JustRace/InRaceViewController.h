//
//  InRaceViewController.h
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface InRaceViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, strong) NSString *raceName;
@property (nonatomic, weak) IBOutlet UILabel *minutes;
@property (nonatomic, weak) IBOutlet UILabel *seconds;
@property (nonatomic, weak) IBOutlet UILabel *hours;
@property (nonatomic, weak) IBOutlet UILabel *distance;
@property (nonatomic, weak) IBOutlet UILabel *speed;
- (id)initWithRace:(NSString *)raceName;
@end
