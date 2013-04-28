//
//  MapViewController.m
//  JustRace
//
//  Created by Andra Mititelu on 4/20/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "MapViewController.h"
#import "NewRaceViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()
@property (nonatomic, strong) id returnObject;
@property (nonatomic, strong) GMSMarker *marker;
@property (nonatomic) BOOL editable;
@end

@implementation MapViewController

@synthesize returnObject;
@synthesize mapView;
@synthesize racePath;
@synthesize editable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithReturnController:(id)controller racePath:(NSString *)encodedPath editable:(BOOL)edit
{
    self = [self init];
    if (self)
    {
        self.returnObject = controller;
        if(encodedPath != nil)
            self.racePath = [[GMSPath pathFromEncodedPath:encodedPath] mutableCopy];
        self.editable = edit;
        NSLog(@"init %@",encodedPath);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Implement here to check if already KVO is implemented.
    
    [self.mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context: nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        [self.mapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:self.mapView.myLocation.coordinate.latitude longitude:self.mapView.myLocation.coordinate.longitude zoom:14]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.8683
                                                           longitude:151.2086
                                                                zoom:14];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [self.mapView setFrame:CGRectMake(0, 0, 320, 350)];
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    if(self.racePath)
        [self drawPath:self.racePath];
    [self.view addSubview:self.mapView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(5, 360, self.view.frame.size.width - 10, 50);
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"silver-button-normal.png"] forState:UIControlStateNormal];
    if (self.editable)
    {
       [button setTitle:@"All set!" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendPath:) forControlEvents:UIControlEventTouchDown];
    }
    else
    {
        [button setTitle:@"OK!" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
    }
    
    [self.view addSubview:button];
}

-(void)drawPath:(GMSMutablePath*)path
{
    NSLog(@"%d",[path count]);
    GMSMarker *startMarker = [[GMSMarker alloc] init];
    startMarker.position = [path coordinateAtIndex:0];
    startMarker.title = @"START";
    startMarker.snippet = @"This is the starting point of the race";
    startMarker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    startMarker.map = self.mapView;
    
    GMSMarker *endMarker = [[GMSMarker alloc] init];
    endMarker.position = [path coordinateAtIndex:([path count]-1)];
    endMarker.title = @"FINISH";
    endMarker.snippet = @"Here is the finishing line!!!";
    endMarker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    endMarker.map = self.mapView;
    
    if(self.editable)
    {
        //Draw other markers too
    }
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = self.mapView;
    polyline.strokeWidth = 3.0;
    polyline.strokeColor = [UIColor darkGrayColor];
    polyline.geodesic = NO;
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if(self.editable)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = coordinate;
        marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        if(!self.racePath)
        {
            self.racePath = [[GMSMutablePath alloc] init];
            marker.title = @"START";
        }
        [self.racePath addCoordinate:coordinate];
        marker.map = self.mapView;
        [self drawPath:self.racePath];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendPath:(id)sender
{
    [(NewRaceViewController*)self.returnObject sendPathData:[self.racePath encodedPath]];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
