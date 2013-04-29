//
//  ParticipantsListViewController.h
//  JustRace
//
//  Created by Laborator iOS on 4/29/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParticipantsListViewController : UITableViewController<
UITableViewDataSource, UITableViewDelegate>{
    NSDictionary *race;
    NSArray *participantsList;
}
@property(nonatomic, strong) NSDictionary *race;

@end
