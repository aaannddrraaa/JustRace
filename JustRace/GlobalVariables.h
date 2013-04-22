//
//  GlobalVariables.h
//  JustRace
//
//  Created by Laborator iOS on 4/22/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject{
    NSString *userID;
}
@property NSString *userID;

+(GlobalVariables *)sharedInstance;

@end
