//
//  NewRaceViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRaceViewController : UIViewController <UITextFieldDelegate>{

    NSDate *raceDate;
    UIActionSheet *dateSheet;
    
}
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) NSDate *raceDate;

-(void) setRaceDate;
-(void) dismissDateSet;
-(void) cancelDateSet;
@end
