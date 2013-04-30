//
//  ParticipantCell.m
//  JustRace
//
//  Created by Laborator iOS on 4/29/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "ParticipantCell.h"

@implementation ParticipantCell

@synthesize nameLabel;
@synthesize userPhoto;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
