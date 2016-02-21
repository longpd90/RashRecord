//
//  RRCalendarRange.h
//  RashRecord
//
//  Created by HMTS on 4/23/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRCalendarRange : NSObject
@property (nonatomic, copy) NSDateComponents *startDay;
@property (nonatomic, copy) NSDateComponents *endDay;

// Designated initialiser
- (id)initWithStartDay:(NSDateComponents*)start endDay:(NSDateComponents*)end;

- (BOOL)containsDay:(NSDateComponents*)day;
- (BOOL)containsDate:(NSDate*)date;
@end
