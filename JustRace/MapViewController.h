//
//  MapViewController.h
//  JustRace
//
//  Created by Andra Mititelu on 4/20/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMutablePath *racePath;
-(id)initWithReturnController:(id)controller racePath:(NSString *)encodedPath editable:(BOOL)editable;
@end
