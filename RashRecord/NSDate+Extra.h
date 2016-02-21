//
//  NSDate+Extra.h
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kOneMinute (60)
#define kOneHour (3600)
#define kOneDay (3600 * 24)
#define kOneWeek (3600 * 24 * 7)
#define kOneMonth (3600 * 24 * 30)
#define kOneYear (3600 * 24 * 355)

@interface NSDate (Extra)

- (NSString *) intervalInStringSinceDate:(NSDate *)date;
- (NSString *) shortIntervalInStringSinceDate:(NSDate *)date;
- (NSString *) stringValueFormattedBy:(NSString *)formatString;
- (NSComparisonResult) compareMonth:(NSDate *)date;
- (NSComparisonResult) compareDay:(NSDate *)date;
- (NSDate *) dateByAddingMonth:(NSInteger) month;
- (NSDate *) monthBegin;
- (NSDate *) dayBegin;
- (NSDate *) monthEnd;
- (NSDate *) dayEnd;
- (int) numberOfWeeksInMonth;
- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;
+ (NSDate *)tomorrow;
- (NSInteger)weekDay;

@end

@interface NSDateComponents (Extra)

- (NSDate *) dateWithCurrentCalendar;

@end
