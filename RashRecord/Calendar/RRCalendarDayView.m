//
//  RRCalendarDayView.m
//  RashRecord
//
//  Created by HMTS on 4/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import "RRCalendarDayView.h"

@implementation RRCalendarDayView
{
    __strong NSCalendar *_calendar;
    __strong NSDate *_dayAsDate;
    __strong NSDateComponents *_day;
    __strong NSString *_labelText;
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.backgroundColor = [UIColor whiteColor];
        /*
        //Add icon
        [self.imageDose removeFromSuperview];
        [self.imageMemo removeFromSuperview];
        [self.imageHospital removeFromSuperview];
        [self.imagePhoto removeFromSuperview];
        
        self.imageMemo = [[UIImageView alloc] initWithFrame:CGRectMake(6, 20, 13, 13)];
        self.imageMemo.image = [UIImage imageNamed:@"icon_memo.png"];
        self.imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(25, 19, 16, 16)];
        self.imagePhoto.image = [UIImage imageNamed:@"icon_photo.png"];
        self.imageDose = [[UIImageView alloc] initWithFrame:CGRectMake(25, 36, 16, 12)];
        self.imageDose.image = [UIImage imageNamed:@"icon_dose.png"];
        self.imageHospital = [[UIImageView alloc] initWithFrame:CGRectMake(6, 36, 12, 12)];
        self.imageHospital.image = [UIImage imageNamed:@"icon_hospital.png"];
        [self addSubview:self.imagePhoto];
        [self addSubview:self.imageMemo];
        [self addSubview:self.imageHospital];
        [self addSubview:self.imageDose];
        self.imagePhoto.hidden = YES;
        self.imageDose.hidden = YES;
        self.imageHospital.hidden = YES;
        self.imageMemo.hidden = YES;
       */
        _positionInWeek = RRCalendarDayViewMidWeek;
    }
    
    return self;
}


#pragma mark Properties

- (void)setSelectionState:(RRCalendarDayViewSelectionState)selectionState {
    _selectionState = selectionState;
    [self setNeedsDisplay];
}

- (void)setDay:(NSDateComponents *)day {
    _calendar = [day calendar];
    _dayAsDate = [day date];
    _day = nil;
    _labelText = [NSString stringWithFormat:@"%ld", (long)day.day];
}

- (NSDateComponents*)day
{
    if (_day == nil) {
        _day = [_dayAsDate dslCalendarView_dayWithCalendar:_calendar];
    }
    
    return _day;
}

- (NSDate*)dayAsDate {
    return _dayAsDate;
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    [self setNeedsDisplay];
}


#pragma mark UIView methods

- (void)drawRect:(CGRect)rect
{
    if ([self isMemberOfClass:[RRCalendarDayView class]])
    {
        // If this isn't a subclass of DSLCalendarDayView, use the default drawing
        [self drawBackground];
        [self drawBorders];
        [self drawDayNumber];
    }
}


#pragma mark Drawing

- (void)drawBackground {
    if (self.selectionState == RRCalendarDayViewNotSelected) {
        if (self.isInCurrentMonth)
        {
            [[UIColor whiteColor] setFill];
            if (self.isPreviousday)
            {
                [[UIColor colorWithRed:217.0f/255 green:217.0f/255 blue:217.0f/255 alpha:1.0f] setFill];
            }

        }
        else {
            [[UIColor colorWithRed:166.0f/255 green:166.0f/255 blue:166.0f/255 alpha:1.0f] setFill];
        }
        if (self.isNowday)
        {
            [[UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1] setFill];
        }
        UIRectFill(self.bounds);
        
    }
    else
    {
        
        switch (self.selectionState)
        {
            case RRCalendarDayViewNotSelected:
                break;
                
            case RRCalendarDayViewWholeSelection:
                [[[UIImage imageNamed:@"icon_select_day_calendar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] drawInRect:self.bounds];
                break;
        }
    }
    
}

- (void)drawBorders {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:255.0/255.0 alpha:1.0].CGColor);
    CGContextMoveToPoint(context, 0.5, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, 0.5, 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    if (self.isInCurrentMonth) {
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:205.0/255.0 alpha:1.0].CGColor);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:185.0/255.0 alpha:1.0].CGColor);
    }
    CGContextMoveToPoint(context, self.bounds.size.width - 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, 0.0, self.bounds.size.height - 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawDayNumber {
    if (self.selectionState == RRCalendarDayViewNotSelected)
    {
        [[UIColor colorWithWhite:66.0/255.0 alpha:1.0] set];
    }
    else {
        [[UIColor whiteColor] set];
    }
    
    CGSize textSize = [_labelText sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
    CGRect textRect = CGRectMake(3, 5, textSize.width, textSize.height);
    [_labelText drawInRect:textRect withFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
    
    if (((self.day.month >= [RRConstantMonthActive sharedGlobalData].MONTHACTIVE - 1)&&(self.day.month <= [RRConstantMonthActive sharedGlobalData].MONTHACTIVE + 1)) || self.selectionState)
    {
        NSMutableArray *recordArray = [[RRDatabaseHelper   shareMyInstance] getRecordObjectsFromDate:self.dayAsDate.dayBegin toDate:self.dayAsDate.dayEnd withTableName:kRRRashRecordTableName];
        if ([recordArray count] > 0)
        {
            RashRecord *record = [recordArray objectAtIndex:0];
            if (record != nil)
            {
                //UIImage
                if (![record.pt_right_hand isEqualToString:@""] || ![record.pt_left_hand isEqualToString:@""] || ![record.pt_right_leg isEqualToString:@""] || ![record.pt_left_leg isEqualToString:@""])
                {
                    [self.imagePhoto removeFromSuperview];
                    self.imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(25, 19, 16, 16)];
                    self.imagePhoto.image = [UIImage imageNamed:@"icon_photo.png"];
                    [self addSubview:self.imagePhoto];
                    self.imagePhoto.hidden = NO;
                }
                else self.imagePhoto.hidden = YES;
                
                //Note
                if (![record.des isEqualToString:@""] || ![record.title isEqualToString:@""])
                {
                    [self.imageMemo removeFromSuperview];
                    self.imageMemo = [[UIImageView alloc] initWithFrame:CGRectMake(6, 20, 13, 13)];
                    self.imageMemo.image = [UIImage imageNamed:@"icon_memo.png"];
                    [self addSubview:self.imageMemo];
                    self.imageMemo.hidden = NO;
                }
                else self.imageMemo.hidden = YES;
                //Examination
                if (record.hos_time != nil || ![record.hos_address isEqualToString:@""])
                {
                    [self.imageHospital removeFromSuperview];
                    self.imageHospital = [[UIImageView alloc] initWithFrame:CGRectMake(6, 36, 12, 12)];
                    self.imageHospital.image = [UIImage imageNamed:@"icon_hospital.png"];
                    [self addSubview:self.imageHospital];
                    self.imageHospital.hidden = NO;
                }
                else self.imageHospital.hidden = YES;
                
                //Medicine
                if ([record.num_am_pin isEqualToString:@"0"] && [record.num_pm_pin isEqualToString:@"0"])
                {
                    self.imageDose.hidden = YES;
                }
                else
                {
                    [self.imageDose removeFromSuperview];
                    self.imageDose = [[UIImageView alloc] initWithFrame:CGRectMake(25, 36, 16, 12)];
                    self.imageDose.image = [UIImage imageNamed:@"icon_dose.png"];
                    [self addSubview:self.imageDose];
                    self.imageDose.hidden = NO;
                }
                
            }
            
        }
        
    }
    else
    {
        self.imagePhoto.hidden = YES;
        self.imageDose.hidden = YES;
        self.imageHospital.hidden = YES;
        self.imageMemo.hidden = YES;
    }
}
//Ve lai anh theo dung kich thuoc
-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
