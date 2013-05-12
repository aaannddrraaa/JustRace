//
//  LiveViewController.h
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel *raceNameLabel;
@property (nonatomic, strong) NSString *raceName;
@property (nonatomic, weak) IBOutlet UILabel *minutesLeft;
@property (nonatomic, weak) IBOutlet UILabel *secondsLeft;


- (id)initWithRace:(NSString *)raceName;
@end
