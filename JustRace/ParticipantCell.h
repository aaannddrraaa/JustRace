//
//  ParticipantCell.h
//  JustRace
//
//  Created by Laborator iOS on 4/29/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParticipantCell : UITableViewCell{
    UILabel *nameLabel;
    UIImageView *userPhoto;
    
}
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userPhoto;

@end
