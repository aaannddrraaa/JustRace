//
//  InRaceViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 5/12/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "InRaceViewController.h"

@interface InRaceViewController ()

@end

@implementation InRaceViewController

@synthesize raceName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRace:(NSString *)raceName
{
    self = [super init];
    if (self) {
        self.raceName = raceName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.raceName;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
