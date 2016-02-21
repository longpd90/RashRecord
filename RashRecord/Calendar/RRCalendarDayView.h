//
//  RRCalendarDayView.h
//  RashRecord
//
//  Created by HMTS on 4/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+DSLCalendarView.h"
#import "RRDatabaseHelper.h"
#import "RashRecord.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RRConstantMonthActive.h"
#import "NSDate+Extra.h"
enum {
    RRCalendarDayViewNotSelected = 0,
    RRCalendarDayViewWholeSelection,
} typedef RRCalendarDayViewSelectionState;

enum {
    RRCalendarDayViewStartOfWeek = 0,
    RRCalendarDayViewMidWeek,
    RRCalendarDayViewEndOfWeek,
} typedef RRCalendarDayViewPositionInWeek;
@interface RRCalendarDayView : UIView

@property (nonatomic, copy) NSDateComponents *day;
@property (nonatomic, assign) RRCalendarDayViewPositionInWeek positionInWeek;
@property (nonatomic, assign) RRCalendarDayViewSelectionState selectionState;
@property (nonatomic, strong) UIImageView *imageHospital;
@property (nonatomic, strong) UIImageView *imageDose;
@property (nonatomic, strong) UIImageView *imageMemo;
@property (nonatomic, strong) UIImageView *imagePhoto;
@property (nonatomic, assign, getter = isInCurrentMonth) BOOL inCurrentMonth;
@property (nonatomic) BOOL isNowday;
@property (nonatomic) BOOL isPreviousday;

@property (nonatomic, strong, readonly) NSDate *dayAsDate;


@end
