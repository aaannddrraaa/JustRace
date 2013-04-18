//
//  NewRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/8/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "NewRaceViewController.h"

@interface NewRaceViewController ()

@end

@implementation NewRaceViewController
@synthesize raceDate;
@synthesize raceTime;
@synthesize raceTimeTextField;
@synthesize dateTextField;
@synthesize startPointTextField;
@synthesize endPointTextField;
@synthesize lengthTextField;
@synthesize motto;
@synthesize raceNameTextField;

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
    }
    if ([textField isEqual:raceTimeTextField]){
        [self setRaceTime];
    }
    return NO;
    
}

-(IBAction)createRace:(id)sender{
    
}
@end
