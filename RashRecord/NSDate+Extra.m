//
//  NSDate+Extra.m
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Extra.h"

@implementation NSDate (Extra)

+ (NSDate *)tomorrow
{
	return [[[NSDate date] dateByAddingTimeInterval:kOneDay] dayBegin];
}


- (NSString *)intervalInStringSinceDate:(NSDate *)date
{
	int interval = round([date timeIntervalSinceDate:self]);
	interval = ABS(interval);
	
	if (interval < 0) {
		return @"";
	} else if (interval < kOneMinute) {
		return [NSString stringWithFormat:NSLocalizedString(@"just now", nil), interval];
	} else if (interval < kOneHour) {
		return [NSString stringWithFormat:NSLocalizedString(@"%d minutes ago", nil), interval / kOneMinute];
	} else if (interval < kOneDay) {
		return [NSString stringWithFormat:NSLocalizedString(@"%d hours ago", nil), interval / kOneHour];
	} else if (interval < kOneWeek) {
		return [NSString stringWithFormat:NSLocalizedString(@"%d days ago", nil), interval / kOneDay];
	} else if (interval < kOneMonth) {
		return [NSString stringWithFormat:NSLocalizedString(@"%d weeks ago", nil), interval / kOneWeek];
	} else if (interval < kOneYear) {
		return [NSString stringWithFormat:NSLocalizedString(@"%d month ago", nil), interval / kOneMonth];
	} else {
		return [NSString stringWithFormat:NSLocalizedString(@"%d years ago", nil), interval / kOneYear];
	} 
}

- (NSString *)shortIntervalInStringSinceDate:(NSDate *)date
{
	int interval = round([date timeIntervalSinceDate:self]);
	interval = ABS(interval);
	
	if (interval < 0) {
		return @"";
	} else if (interval < kOneMinute) {
		return [NSString stringWithFormat:NSLocalizedString(@"now", nil), interval];
	} else if (interval < kOneHour) {
		return [NSString stringWithFormat:NSLocalizedString(@"%dm ago", nil), interval / kOneMinute];
	} else if (interval < kOneDay) {
		return [NSString stringWithFormat:NSLocalizedString(@"%dh ago", nil), interval / kOneHour];
	} else if (interval < kOneWeek) {
		return [NSString stringWithFormat:NSLocalizedString(@"%dd ago", nil), interval / kOneDay];
	} else if (interval < kOneMonth) {
		return [NSString stringWithFormat:NSLocalizedString(@"%dw ago", nil), interval / kOneWeek];
	} else if (interval < kOneYear) {
		return [NSString stringWithFormat:NSLocalizedString(@"%dm ago", nil), interval / kOneMonth];
	} else {
		return [NSString stringWithFormat:NSLocalizedString(@"%dy ago", nil), interval / kOneYear];
	}
}

- (NSString *)stringValueFormattedBy:(NSString *)formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *string = [dateFormatter stringFromDate:self];
    return string;
}

- (NSComparisonResult)compareMonth:(NSDate *)date
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *currentDateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit 
														  fromDate:self];
	NSDateComponents *compareDateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit 
														  fromDate:date];
	
	return [[calendar dateFromComponents:currentDateComponents] compare:
			[calendar dateFromComponents:compareDateComponents]];
}

- (NSInteger)weekDay
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:self];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday;
}

- (NSComparisonResult)compareDay:(NSDate *)date
{	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *currentDateComponents = [calendar components:
											   NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
														  fromDate:self];
	NSDateComponents *compareDateComponents = [calendar components:
											   NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit 
														  fromDate:date];
	
	return [[calendar dateFromComponents:currentDateComponents] compare:
			[calendar dateFromComponents:compareDateComponents]];
}

- (NSDate *)dateByAddingMonth:(NSInteger)month
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
	dateComponents.month += month;
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)monthBegin
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)dayBegin
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)monthEnd
{
	return [[self dateByAddingMonth:1] dateByAddingTimeInterval:-1];
}

- (NSDate *)dayEnd
{
	return [[self dayBegin] dateByAddingTimeInterval:3600 * 24];
}

- (int)numberOfWeeksInMonth
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *componentsMonthBegin = [calendar components:NSDayCalendarUnit | NSWeekdayCalendarUnit 
														 fromDate:self.monthBegin];
	
	NSUInteger numberOfDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
	if (numberOfDaysInMonth == 30) {
		if (componentsMonthBegin.weekday == 7) {
			return 6;
		}
	} else if (numberOfDaysInMonth == 31) {
		if (componentsMonthBegin.weekday >= 6) {
			return 6;
		}
	}
	return 5;
}

- (BOOL)isEarlierThanDate:(NSDate *)date
{
	return (self.timeIntervalSince1970 < date.timeIntervalSince1970);
}

- (BOOL)isLaterThanDate:(NSDate *)date
{
	return (self.timeIntervalSince1970 > date.timeIntervalSince1970);
}

@end

@implementation NSDateComponents (Extra)

- (NSDate *)dateWithCurrentCalendar
{
	return [[NSCalendar currentCalendar] dateFromComponents:self];
}

@end
