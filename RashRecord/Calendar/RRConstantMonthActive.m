//
//  RRConstantMonthActive.m
//  RashRecord
//
//  Created by HMTS on 5/9/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRConstantMonthActive.h"

@implementation RRConstantMonthActive
@synthesize MONTHACTIVE;
static RRConstantMonthActive *sharedGlobalData = nil;

+ (RRConstantMonthActive *)sharedGlobalData
{
    if (sharedGlobalData == nil)
    {
        sharedGlobalData = [[super allocWithZone:NULL] init];
        // initialize your variables here
        sharedGlobalData.MONTHACTIVE = 1;
        
    }
    return sharedGlobalData;
}

@end
