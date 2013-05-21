//
//  SpeedViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeedViewController : UIViewController{
    NSArray *parts;
}
@property (strong, nonatomic) IBOutlet UILabel *bestSpeed;
@property (strong, nonatomic) IBOutlet UILabel *averageSpeed;

@end
