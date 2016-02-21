//
//  RRCalendarMonthView.m
//  RashRecord
//
//  Created by HMTS on 4/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import "RRCalendarMonthView.h"

@implementation RRCalendarMonthView
{
    CGFloat _dayViewHeight;
    __strong Class _dayViewClass;
}
#pragma mark - Initialisation

// Designated initialiser
- (id)initWithMonth:(NSDateComponents*)month width:(CGFloat)width dayViewClass:(Class)dayViewClass dayViewHeight:(CGFloat)dayViewHeight {
    self = [super initWithFrame:CGRectMake(0, 0, width, dayViewHeight)];
    if (self != nil) {
        // Initialise properties
        _month = [month copy];
        _dayViewHeight = dayViewHeight;
        _dayViewsDictionary = [[NSMutableDictionary alloc] init];
        _dayViewClass = dayViewClass;
        
        [self createDayViews];
    }
    
    return self;
}

- (void)createDayViews {
    NSInteger const numberOfDaysPerWeek = 7;
    
    NSDateComponents *day = [[NSDateComponents alloc] init];
    day.calendar = self.month.calendar;
    day.day = 1;
    day.month = self.month.month;
    day.year = self.month.year;
    
    NSDate *firstDate = [day.calendar dateFromComponents:day];
    day = [firstDate dslCalendarView_dayWithCalendar:self.month.calendar];
    
    NSInteger numberOfDaysInMonth = [day.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[day date]].length;
    
    //NSInteger startColumn = day.weekday - day.calendar.firstWeekday;
    NSInteger startColumn = day.weekday - 2;
    if (startColumn < 0) {
        startColumn += numberOfDaysPerWeek;
    }
    
    NSArray *columnWidths = [self calculateColumnWidthsForColumnCount:numberOfDaysPerWeek];
    CGPoint nextDayViewOrigin = CGPointZero;
    for (NSInteger column = 0; column < startColumn; column++) {
        nextDayViewOrigin.x += [[columnWidths objectAtIndex:column] floatValue];
    }
    
    do {
        for (NSInteger column = startColumn; column < numberOfDaysPerWeek; column++) {
            if (day.month == self.month.month) {
                CGRect dayFrame = CGRectZero;
                dayFrame.origin = nextDayViewOrigin;
                dayFrame.size.width = [[columnWidths objectAtIndex:column] floatValue];
                dayFrame.size.height = _dayViewHeight;
                
                RRCalendarDayView *dayView = [[_dayViewClass alloc] initWithFrame:dayFrame];
                dayView.day = day;
                switch (column) {
                    case 0:
                        dayView.positionInWeek = RRCalendarDayViewStartOfWeek;
                        break;
                        
                    case numberOfDaysPerWeek - 1:
                        dayView.positionInWeek = RRCalendarDayViewEndOfWeek;
                        break;
                        
                    default:
                        dayView.positionInWeek = RRCalendarDayViewMidWeek;
                        break;
                }
                
                [self.dayViewsDictionary setObject:dayView forKey:[self dayViewKeyForDay:day]];
                [self addSubview:dayView];
            }
            
            day.day = day.day + 1;
            
            nextDayViewOrigin.x += [[columnWidths objectAtIndex:column] floatValue];
        }
        
        nextDayViewOrigin.x = 0;
        nextDayViewOrigin.y += _dayViewHeight;
        startColumn = 0;
    } while (day.day <= numberOfDaysInMonth);
    
    CGRect fullFrame = CGRectZero;
    fullFrame.size.height = nextDayViewOrigin.y;
    for (NSNumber *width in columnWidths) {
        fullFrame.size.width += width.floatValue;
    }
    self.frame = fullFrame;
}
- (void)updateDaySelectionStatesForRange:(RRCalendarRange *)range
{
    for (RRCalendarDayView *dayView in self.dayViews)
    {
        if ([range containsDate:dayView.dayAsDate])
        {
            BOOL isStartOfRange = [range.startDay isEqual:dayView.day];
            BOOL isEndOfRange = [range.endDay isEqual:dayView.day];
            
            if (isStartOfRange && isEndOfRange) {
                dayView.selectionState = RRCalendarDayViewWholeSelection;
            }
        }
        else
        {
            dayView.selectionState = RRCalendarDayViewNotSelected;
        }
    }
}
- (NSArray*)calculateColumnWidthsForColumnCount:(NSInteger)columnCount
{
    static NSCache *widthsCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        widthsCache = [[NSCache alloc] init];
    });
    
    NSMutableArray *columnWidths = [widthsCache objectForKey:@(columnCount)];
    if (columnWidths == nil)
    {
        CGFloat width = floorf(self.bounds.size.width / (CGFloat)columnCount);
        
        columnWidths = [[NSMutableArray alloc] initWithCapacity:columnCount];
        for (NSInteger column = 0; column < columnCount; column++)
        {
            [columnWidths addObject:@(width)];
        }
        
        CGFloat remainder = self.bounds.size.width - (width * columnCount);
        CGFloat padding = 1;
        if (remainder > columnCount)
        {
            padding = ceilf(remainder / (CGFloat)columnCount);
        }
        
        for (NSInteger column = 0; column < columnCount; column++)
        {
            [columnWidths replaceObjectAtIndex:column withObject:@(width + padding)];
            
            remainder -= padding;
            if (remainder < 1)
            {
                break;
            }
        }
        
        [widthsCache setObject:columnWidths forKey:@(columnCount)];
    }
    
    return columnWidths;
}


#pragma mark - Properties

- (NSSet*)dayViews {
    return [NSSet setWithArray:self.dayViewsDictionary.allValues];
}

- (NSString*)dayViewKeyForDay:(NSDateComponents*)day {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    });
    
    return [formatter stringFromDate:[day date]];
}

- (RRCalendarDayView*)dayViewForDay:(NSDateComponents*)day
{
    return [self.dayViewsDictionary objectForKey:[self dayViewKeyForDay:day]];
}
@end
