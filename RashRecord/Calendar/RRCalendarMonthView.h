//
//  RRCalendarMonthView.h
//  RashRecord
//
//  Created by HMTS on 4/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRCalendarDayView.h"
#import "RRCalendarRange.h"
#import "NSDate+DSLCalendarView.h"
@class RRCalendarDayView;
@interface RRCalendarMonthView : UIView
@property (nonatomic, copy, readonly) NSDateComponents *month;
@property (nonatomic, strong, readonly) NSSet *dayViews;
@property (nonatomic, strong) NSMutableDictionary *dayViewsDictionary;

// Designated initialiser
- (id)initWithMonth:(NSDateComponents*)month width:(CGFloat)width dayViewClass:(Class)dayViewClass dayViewHeight:(CGFloat)dayViewHeight;
- (void)updateDaySelectionStatesForRange:(RRCalendarRange *)range;
- (RRCalendarDayView*)dayViewForDay:(NSDateComponents*)day;
@end
