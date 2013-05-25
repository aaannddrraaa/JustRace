//
//  ResultsViewController.h
//  JustRace
//
//  Created by Laborator iOS on 5/25/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UITableViewController<
UITableViewDataSource, UITableViewDelegate>{
    NSDictionary *race;
    NSArray *resultsList;
}
@property(nonatomic, strong) NSDictionary *race;

@end
