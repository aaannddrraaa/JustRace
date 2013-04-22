//
//  GlobalVariables.m
//  JustRace
//
//  Created by Laborator iOS on 4/22/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables
@synthesize userID;

+ (GlobalVariables *)sharedInstance{
    static GlobalVariables *myInstance = nil;
    
    if (nil == myInstance){
        myInstance = [[[self class] alloc] init];
    }
    
    return  myInstance;
}

@end
