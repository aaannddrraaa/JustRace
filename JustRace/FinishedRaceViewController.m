//
//  FinishedRaceViewController.m
//  JustRace
//
//  Created by Laborator iOS on 5/25/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "FinishedRaceViewController.h"

@interface FinishedRaceViewController ()

@end

@implementation FinishedRaceViewController

@synthesize time;
@synthesize speed;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ok:(id)sender
{
    
}

@end
