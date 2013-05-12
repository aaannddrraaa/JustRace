//
//  InRaceViewController.h
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InRaceViewController : UIViewController
@property (nonatomic, strong) NSString *raceName;
- (id)initWithRace:(NSString *)raceName;
@end
