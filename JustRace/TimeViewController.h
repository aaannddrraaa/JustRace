//
//  TimeViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TimeViewController : UIViewController{
    NSArray *parts;
}
@property (strong, nonatomic) IBOutlet UILabel *bestTime;
@property (strong, nonatomic) IBOutlet UILabel *averageTime;

@end
