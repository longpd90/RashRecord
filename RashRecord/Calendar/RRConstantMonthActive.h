//
//  RRConstantMonthActive.h
//  RashRecord
//
//  Created by HMTS on 5/9/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRConstantMonthActive : NSObject
//share Month Active
@property (nonatomic) int MONTHACTIVE;
+ (RRConstantMonthActive *)sharedGlobalData;
@end
