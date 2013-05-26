//
//  LoggedInViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 3/30/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "LoggedInViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface LoggedInViewController ()

@end

@implementation LoggedInViewController

@synthesize nameLabel;
@synthesize myImage;


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
    
    FBRequest *request = [FBRequest requestForMe];
    
    // Send request to Facebook
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error)
        {
            // result is a dictionary
            NSDictionary *userData = (NSDictionary *)result;
            NSString *facebookID = userData[@"id"];
            
            NSDictionary *userProfile = @{
            @"facebookId": facebookID,
            @"name": userData[@"name"],
            @"location": userData[@"location"][@"name"]
            };
            
            if(![[PFUser currentUser] objectForKey:@"name"])
            {
                [[PFUser currentUser] setObject:userData[@"name"] forKey:@"name"];
                [[PFUser currentUser] setObject:userData[@"id"] forKey:@"facebookID"];
                [[PFUser currentUser] saveInBackground];
            }
            
            self.nameLabel.text =[self.nameLabel.text stringByAppendingString:userProfile[@"name"]];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
           
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
            NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
            UIImage *img = [[UIImage alloc] initWithData:data];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, 200, 200)];
            //imgView.image = img;
            [self.view addSubview:imgView];
        }
        else if ([error.userInfo[FBErrorParsedJSONResponseKey][@"body"][@"error"][@"type"] isEqualToString:@"OAuthException"])
        {
                NSLog(@"The facebook session was invalidated");
                [self logoutButtonTouchHandler:nil];
        }
        else
        {
            NSLog(@"Some other error: %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutButtonTouchHandler:(id)sender  {
    [PFUser logOut]; 
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)callLogOut:(id)sender {
    [self logoutButtonTouchHandler:nil];
}

@end
