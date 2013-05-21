//
//  DistanceViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistanceViewController : UIViewController{
    NSArray *parts;
}
@property (strong, nonatomic) IBOutlet UILabel *bestDistance;
@property (strong, nonatomic) IBOutlet UILabel *averageDistance;

@end
