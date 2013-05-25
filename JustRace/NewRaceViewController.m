//
//  NewRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "NewRaceViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>


@interface NewRaceViewController ()

@end

@implementation NewRaceViewController
@synthesize raceDate;
@synthesize raceTime;
@synthesize raceTimeTextField;
@synthesize dateTextField;
@synthesize lengthTextField;
@synthesize motto;
@synthesize raceNameTextField;
@synthesize racePath;
@synthesize savedMapLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRaceDate{
    dateSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [dateSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame= CGRectMake(0,44,0,0);
    UIDatePicker *raceDatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [raceDatePicker setDatePickerMode:UIDatePickerModeDate];
    
    [dateSheet addSubview:raceDatePicker];
    
    UIToolbar *controlToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, dateSheet.bounds.size.width, 44)];
    
    [controlToolBar setBarStyle:UIBarStyleBlack];
    [controlToolBar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(dismissDateSet)];
    
    UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDateSet)];
    
    [controlToolBar setItems:[NSArray arrayWithObjects:spacer, cancelButton, setButton, nil] animated:NO];
    
    [dateSheet addSubview:controlToolBar];
    
    [dateSheet showInView:self.view];
    
    [dateSheet setBounds:CGRectMake(0, 0,320, 485)];
    
}

-(void) setRaceTime{
    dateSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [dateSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame= CGRectMake(0,44,0,0);
    UIDatePicker *raceTimePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [raceTimePicker setDatePickerMode:UIDatePickerModeTime];
    
    [dateSheet addSubview:raceTimePicker];
    
    UIToolbar *controlToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, dateSheet.bounds.size.width, 44)];
    
    [controlToolBar setBarStyle:UIBarStyleBlack];
    [controlToolBar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(dismissDateSet)];
    
    UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDateSet)];
    
    [controlToolBar setItems:[NSArray arrayWithObjects:spacer, cancelButton, setButton, nil] animated:NO];
    
    [dateSheet addSubview:controlToolBar];
    
    [dateSheet showInView:self.view];
    
    [dateSheet setBounds:CGRectMake(0, 0,320, 485)];

}

-(void)cancelDateSet{
    
    [dateSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)dismissDateSet{
    
    NSArray *listOfViews = [dateSheet subviews];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    for(UIView *subView in listOfViews){
        if ([subView isKindOfClass:[UIDatePicker class]]){
            if ([(UIDatePicker *) subView datePickerMode] == UIDatePickerModeDate){
                self.raceDate = [(UIDatePicker *) subView date];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                [dateTextField setText:[dateFormatter stringFromDate:self.raceDate]];
                
            }
            if ([(UIDatePicker *) subView datePickerMode] == UIDatePickerModeTime){
                self.raceTime = [(UIDatePicker *) subView date ];
                [dateFormatter setDateFormat:@"hh:mm"];
                [raceTimeTextField setText:[dateFormatter stringFromDate:self.raceTime]];
            }
        }
    }
    
    [dateSheet dismissWithClickedButtonIndex:0 animated:YES];

}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:dateTextField]){
        [self setRaceDate];
        return NO;

    }
    if ([textField isEqual:raceTimeTextField]){
        [self setRaceTime];
        return NO;
    }
    
    return YES;
}

- (IBAction)newRaceOpenMap:(id)sender {
    MapViewController *map = [[MapViewController alloc] initWithReturnController:self racePath:nil editable:YES];
    [self.navigationController pushViewController:map animated:YES];
}

-(IBAction)createRace:(id)sender{
    PFObject *race = [PFObject objectWithClassName:@"Race"];
    [race setObject:raceNameTextField.text forKey:@"raceName"];
    [race setObject:self.raceDate forKey:@"raceDate"];
    [race setObject:self.raceTime forKey:@"raceTime"];
    [race setObject:[[PFUser currentUser] username]  forKey:@"username"];
    [race setObject:self.racePath forKey:@"racePath"];
    [race saveInBackground];
    
    PFObject *pt = [PFObject objectWithClassName:@"Participation"];
    [pt setObject:raceNameTextField.text forKey:@"raceName"];
    [pt setObject:[[PFUser currentUser] username] forKey:@"username"];
    [pt setObject:[[PFUser currentUser] objectForKey: @"name"] forKey:@"name"];
    [pt saveInBackground];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:raceDate];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:raceTime];
    
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
	// Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    //cu 5 minute inainte
    itemDate = [itemDate addTimeInterval:-(60*5)];
    
    notification.fireDate = itemDate;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    notification.alertBody = [NSString stringWithFormat:@"Race %@ is about to start!",self.raceNameTextField.text];
    notification.alertAction = @"START";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:raceNameTextField.text forKey:@"raceName"];
    notification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [raceNameTextField resignFirstResponder];
    return YES;
}

-(void)sendPathData:(NSString*)data
{
    self.racePath = data;
    //NSLog(@"%@",data);
   // self.savedMapLabel.text = @"Race path saved!";
}

@end
