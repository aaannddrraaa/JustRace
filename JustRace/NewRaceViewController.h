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
    NSDate *raceTime;
    UIActionSheet *dateSheet;
    IBOutlet UITextField *dateTextField;
    IBOutlet UITextField *raceTimeTextField;
    IBOutlet UITextField *startPointTextField;
    IBOutlet UITextField *endPointTextField;
    IBOutlet UITextField *lengthTextField;
    //IBOutlet UITextView *mottoTextView;
    IBOutlet UITextField *raceNameTextField;
}
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) IBOutlet UITextField *raceTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *startPointTextField;
@property (strong, nonatomic) IBOutlet UITextField *endPointTextField;
@property (strong, nonatomic) IBOutlet UITextField *lengthTextField;
@property (strong, nonatomic) IBOutlet UITextView *motto;
@property (strong, nonatomic) IBOutlet UITextField *raceNameTextField;
@property (strong, nonatomic) NSDate *raceDate;
@property (strong, nonatomic) NSDate *raceTime;

-(void) setRaceDate;
-(void) setRaceTime;
-(void) dismissDateSet;
-(void) cancelDateSet;
-(IBAction)createRace:(id)sender;
@end
