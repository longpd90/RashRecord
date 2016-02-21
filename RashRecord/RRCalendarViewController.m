//
//  RRCalendarViewController.m
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//


#import "RRCalendarViewController.h"

@interface RRCalendarViewController ()

@end

@implementation RRCalendarViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (!isTakeCamera)
    {
        [self loadDataRecord:YES];
    }
    
    if (self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.viewData.userInteractionEnabled = YES;
    }
    else
    {
        self.viewCalendarDetail.viewData.userInteractionEnabled = NO;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViewTitleCalendar];
    [self initCalendar];
    self.view.backgroundColor = [UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:244.0f/255 alpha:1];
    //Add GestureRecognizer View Calendar
    [self.viewCalendar setUserInteractionEnabled:YES];
    UISwipeGestureRecognizer *swipRightCalendar =  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeGesture)];
    swipRightCalendar.direction = UISwipeGestureRecognizerDirectionRight;
    [self.viewCalendar addGestureRecognizer:swipRightCalendar];
    
    UISwipeGestureRecognizer *swipLeftCalendar =  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeGesture)];
    swipLeftCalendar.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.viewCalendar addGestureRecognizer:swipLeftCalendar];
    
    //view Calendar Detail
    self.viewCalendarDetail = [[RRRecordDetailView alloc] init];
    self.viewCalendarDetail.delegate = self;
    typeImage = 0;
    self.viewCalendarDetail.frame = CGRectMake(0, 84 + self.monthContainerView.frame.size.height, self.viewCalendarDetail.frame.size.width, self.viewCalendarDetail.frame.size.height);
    [self.viewCalendarDetail.btnCalendarDetail addTarget:self action:@selector(btnDetailCalendarClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.viewCalendarDetail];
    //image right hand
    [self.viewCalendarDetail.rightHandImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *rightHandTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgRightHandClicked)];
    [rightHandTap setNumberOfTapsRequired:1];
    self.rightHandString = @"";
    [self.viewCalendarDetail.rightHandImageView addGestureRecognizer:rightHandTap];
    
    //image left hand
    [self.viewCalendarDetail.leftHandImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *leftHandTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgLeftHandClicked)];
    [leftHandTap setNumberOfTapsRequired:1];
    self.leftHandString = @"";
    [self.viewCalendarDetail.leftHandImageView addGestureRecognizer:leftHandTap];
    
    //image right foot
    [self.viewCalendarDetail.rightLegImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *rightLegTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgRightLegClicked)];
    [rightLegTap setNumberOfTapsRequired:1];
    self.rightLegString = @"";
    [self.viewCalendarDetail.rightLegImageView addGestureRecognizer:rightLegTap];
    
    //image right hand
    [self.viewCalendarDetail.leftLegImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *leftLegTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgLeftLegClicked)];
    [leftLegTap setNumberOfTapsRequired:1];
    self.leftLegString = @"";
    [self.viewCalendarDetail.leftLegImageView addGestureRecognizer:leftLegTap];
    
    
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:[NSDate date]];
    self.selectedRange = [[RRCalendarRange alloc] initWithStartDay:dateComponents endDay:dateComponents];
    self.dateSelected = dateComponents.date;
    
    [RRConstantMonthActive sharedGlobalData].MONTHACTIVE = self.visibleMonth.month;
    //[self loadDataRecord:YES];
    self.photoBrowserView.delegate = self;
    
    isTakeCamera = NO;
    
    
}
- (void)initViewTitleCalendar
{
    self.viewTitleCalendar.backgroundColor = [UIColor colorWithRed:88.0f/255 green:88.0f/255 blue:88.0f/255 alpha:1.0f];
    self.viewDayCalendar.backgroundColor = [UIColor colorWithRed:190.0f/255 green:190.0f/255 blue:190.0f/255 alpha:1.0f];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE";
    NSMutableDictionary *dayNames = [[NSMutableDictionary alloc] init];
    
    for (NSInteger index = 0; index < 7; index++)
    {
        //NSInteger weekday = dateComponents.weekday - [dateComponents.calendar firstWeekday];
        NSInteger weekday = dateComponents.weekday - 2;
        if (weekday < 0) weekday += 7;
        [dayNames setObject:[formatter stringFromDate:dateComponents.date] forKey:@(weekday)];
        dateComponents.day = dateComponents.day + 1;
        dateComponents = [dateComponents.calendar components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:dateComponents.date];
    }
    
    // Set the day name label texts to localised day names
    for (UILabel *label in self.dayLabels)
    {
        label.text = [[dayNames objectForKey:@(label.tag)] uppercaseString];
        if (label.tag == 5)
        {
            label.backgroundColor = [UIColor colorWithRed:55.0f/255 green:95.0f/255 blue:146.0f/255 alpha:1.0f];
        }
        else if (label.tag == 6)
        {
            label.backgroundColor = [UIColor colorWithRed:148.0f/255 green:55.0f/255 blue:53.0f/255 alpha:1.0f];
        }
        else label.backgroundColor = [UIColor whiteColor];
    }
    
}
- (void)initCalendar
{
    dayViewHeight = 50;
    dayViewWidth = 45;
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger date = NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *component = [calender components:date fromDate:[NSDate date]];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    NSString *info = [NSString stringWithFormat:@"01 %.2ld %.4ld", (long)[component month], (long)[component year]];
    [dateFormater setDateFormat:@"dd MM yyyy"];
    _visibleMonth = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:[dateFormater dateFromString:info]];
    [self.viewCalendar addSubview:self.viewMonthCalendar];
    
    // Month views are contained in a content view inside a container view - like a scroll view, but not a scroll view so we can have proper control over animations
    CGRect frame = self.viewCalendar.bounds;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(self.viewMonthCalendar.frame);
    frame.size.height -= frame.origin.y;
    self.monthContainerView = [[UIView alloc] initWithFrame:frame];
    self.monthContainerView.clipsToBounds = YES;
    [self.viewCalendar addSubview:self.monthContainerView];
    
    
    self.monthContainerViewContentView = [[UIView alloc] initWithFrame:self.monthContainerView.bounds];
    [self.monthContainerView addSubview:self.monthContainerViewContentView];
    
    self.monthViews = [[NSMutableDictionary alloc] init];
    
    [self updateMonthLabelMonth:_visibleMonth];
    [self positionViewsForMonth:_visibleMonth fromMonth:_visibleMonth animated:NO];
}
#pragma mark - Properties

+ (Class)monthViewClass {
    return [RRCalendarMonthView class];
}

+ (Class)dayViewClass {
    
    return [RRCalendarDayView class];
}
- (NSDateComponents *)visibleMonth
{
    return [_visibleMonth copy];
}
- (void)setSelectedRange:(RRCalendarRange *)selectedRange
{
    _selectedRange = selectedRange;
    
    for (RRCalendarMonthView *monthView in self.monthViews.allValues)
    {
        [monthView updateDaySelectionStatesForRange:self.selectedRange];
    }
}

- (void)setVisibleMonth:(NSDateComponents *)visibleMonth
{
    [self setVisibleMonth:visibleMonth animated:NO];
}

- (void)setVisibleMonth:(NSDateComponents *)visibleMonth animated:(BOOL)animated
{
    NSDateComponents *fromMonth = [_visibleMonth copy];
    _visibleMonth = [visibleMonth.date dslCalendarView_monthWithCalendar:self.visibleMonth.calendar];
    
    [self updateMonthLabelMonth:_visibleMonth];
    [self positionViewsForMonth:_visibleMonth fromMonth:fromMonth animated:animated];
}

- (void)previousMonth: (id)sender
{
    self.selectedRange = self.selectedRange;
    NSDateComponents *newMonth = self.visibleMonth;
    newMonth.month--;
    
    [self setVisibleMonth:newMonth animated:YES];
    [RRConstantMonthActive sharedGlobalData].MONTHACTIVE = self.visibleMonth.month;

}
- (IBAction)btnPreviousMonthClicked:(id)sender
{
    [self previousMonth:nil];
}
- (void)nextMonth:(id)sender
{
    self.selectedRange = self.selectedRange;
    NSDateComponents *newMonth = self.visibleMonth;
    newMonth.month++;
    
    [self setVisibleMonth:newMonth animated:YES];
    [RRConstantMonthActive sharedGlobalData].MONTHACTIVE = self.visibleMonth.month;
}
- (IBAction)btnNextMonthClicked:(id)sender
{
    [self nextMonth:nil];
}

#pragma mark -

- (void)updateMonthLabelMonth:(NSDateComponents*)month
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年M月";
    
    NSDate *date = [month.calendar dateFromComponents:month];
    self.lblTitleCalendar.text = [formatter stringFromDate:date];
}

- (NSString*)monthViewKeyForMonth:(NSDateComponents*)month
{
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:month.date];
    return [NSString stringWithFormat:@"%ld,%ld", (long)month.year, (long)month.month];
}

- (RRCalendarMonthView *)cachedOrCreatedMonthViewForMonth:(NSDateComponents*)month
{
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:month.date];
    
    NSString *monthViewKey = [self monthViewKeyForMonth:month];
    RRCalendarMonthView *monthView = [self.monthViews objectForKey:monthViewKey];
    if (monthView == nil)
    {
        monthView = [[[[self class] monthViewClass] alloc] initWithMonth:month width:self.viewMonthCalendar.bounds.size.width dayViewClass:[[self class] dayViewClass] dayViewHeight:dayViewHeight];
        [self.monthViews setObject:monthView forKey:monthViewKey];
        [self.monthContainerViewContentView addSubview:monthView];
    }
    
    return monthView;
}



- (void)positionViewsForMonth:(NSDateComponents*)month fromMonth:(NSDateComponents*)fromMonth animated:(BOOL)animated
{
    fromMonth = [fromMonth copy];
    month = [month copy];
    
    CGFloat nextVerticalPosition = 0;
    CGFloat startingVerticalPostion = 0;
    CGFloat restingVerticalPosition = 0;
    CGFloat restingHeight = 0;
    
    NSComparisonResult monthComparisonResult = [month.date compare:fromMonth.date];
    NSTimeInterval animationDuration = (monthComparisonResult == NSOrderedSame || !animated) ? 0.0 : 0.5;
    
    activeMonthViews = [[NSMutableArray alloc] init];
    
    // Create and position the month views for the target month and those around it
    for (NSInteger monthOffset = -2; monthOffset <= 2; monthOffset += 1)
    {
        NSDateComponents *offsetMonth = [month copy];
        offsetMonth.month = offsetMonth.month + monthOffset;
        offsetMonth = [offsetMonth.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:offsetMonth.date];
        
        // Check if this month should overlap the previous month
        if (![self monthStartsOnFirstDayOfWeek:offsetMonth])
        {
            nextVerticalPosition -= dayViewHeight;
        }
        
        // Create and position the month view
        RRCalendarMonthView *monthView = [self cachedOrCreatedMonthViewForMonth:offsetMonth];
        [activeMonthViews addObject:monthView];
        [monthView.superview bringSubviewToFront:monthView];
        
        CGRect frame = monthView.frame;
        frame.origin.y = nextVerticalPosition;
        nextVerticalPosition += frame.size.height;
        monthView.frame = frame;
        
        // Check if this view is where we should animate to or from
        if (monthOffset == 0) {
            // This is the target month so we can use it to determine where to scroll to
            restingVerticalPosition = monthView.frame.origin.y;
            restingHeight += monthView.bounds.size.height;
        }
        else if (monthOffset == 1 && monthComparisonResult == NSOrderedAscending)
        {
            // This is the month we're scrolling back from
            startingVerticalPostion = monthView.frame.origin.y;
            
            if ([self monthStartsOnFirstDayOfWeek:offsetMonth])
            {
                startingVerticalPostion -= dayViewHeight;
            }
        }
        else if (monthOffset == -1 && monthComparisonResult == NSOrderedDescending)
        {
            // This is the month we're scrolling forward from
            startingVerticalPostion = monthView.frame.origin.y;
            
            if ([self monthStartsOnFirstDayOfWeek:offsetMonth])
            {
                startingVerticalPostion -= dayViewHeight;
            }
        }
        
        // Check if the active or following month start on the first day of the week
        /*
         if (monthOffset == 0 && [self monthStartsOnFirstDayOfWeek:offsetMonth])
         {
         // If the active month starts on a monday, add a day view height to the resting height and move the resting position up so the user can drag into that previous month
         restingVerticalPosition -= dayViewHeight;
         restingHeight += dayViewHeight;
         }
         else if (monthOffset == 1 && [self monthStartsOnFirstDayOfWeek:offsetMonth])
         {
         // If the month after the target month starts on a monday, add a day view height to the resting height so the user can drag into that month
         restingHeight += dayViewHeight;
         }*/
    }
    
    // Size the month container to fit all the month views
    CGRect frame = self.monthContainerViewContentView.frame;
    frame.size.height = CGRectGetMaxY([[activeMonthViews lastObject] frame]);
    self.monthContainerViewContentView.frame = frame;
    
    // Remove any old month views we don't need anymore
    NSArray *monthViewKeyes = self.monthViews.allKeys;
    for (NSString *key in monthViewKeyes) {
        UIView *monthView = [self.monthViews objectForKey:key];
        if (![activeMonthViews containsObject:monthView]) {
            [monthView removeFromSuperview];
            [self.monthViews removeObjectForKey:key];
        }
    }
    
    // Position the content view to show where we're animating from
    if (monthComparisonResult != NSOrderedSame)
    {
        CGRect frame = self.monthContainerViewContentView.frame;
        frame.origin.y = -startingVerticalPostion;
        self.monthContainerViewContentView.frame = frame;
    }
    
    self.viewCalendar.userInteractionEnabled = NO;
    //Now day
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger date = NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *component = [calender components:date fromDate:[NSDate date]];
    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        for (NSInteger index = 0; index < activeMonthViews.count; index++)
        {
            RRCalendarMonthView *monthView = [activeMonthViews objectAtIndex:index];
            
            for (RRCalendarDayView *dayView in monthView.dayViews)
            {
                // Use a transition so it fades between states nicely
                [UIView transitionWithView:dayView duration:animationDuration options:UIViewAnimationOptionTransitionNone animations:^{
                    if (dayView.day.day == [component day] && dayView.day.month == [component month] && dayView.day.year == [component year])
                    {
                        dayView.isNowday = YES;
                    }
                    if (dayView.day.year < [component year])
                    {
                        dayView.isPreviousday = YES;
                    } else if (dayView.day.year == [component year])
                    {
                        if (dayView.day.month < [component month])
                            dayView.isPreviousday = YES;
                        else if (dayView.day.month == [component month])
                        {
                            if (dayView.day.day < [component day])
                            {
                                dayView.isPreviousday = YES;
                            }
                            
                        }
                    }
                    dayView.inCurrentMonth = (index == 2);
                } completion:NULL];
            }
            
        }
        
        // Animate the content view to show the target month
        CGRect frame = self.monthContainerViewContentView.frame;
        frame.origin.y = -restingVerticalPosition;
        self.monthContainerViewContentView.frame = frame;
        
        // Resize the container view to show the height of the target month
        frame = self.monthContainerView.frame;
        frame.size.height = restingHeight;
        self.monthContainerView.frame = frame;
        
        // Resize the our frame to show the height of the target month
        frame = self.viewCalendar.frame;
        frame.size.height = CGRectGetMaxY(self.monthContainerView.frame);
        self.viewCalendar.frame = frame;
        
    } completion:^(BOOL finished)
     {
         self.viewCalendar.userInteractionEnabled = YES;
         
     }];
    self.viewCalendarDetail.frame = CGRectMake(0, 84 + self.monthContainerView.frame.size.height, self.viewCalendarDetail.frame.size.width, self.viewCalendarDetail.frame.size.height);
    
}

- (BOOL)monthStartsOnFirstDayOfWeek:(NSDateComponents*)month
{
    // Make sure we have the components we need to do the calculation
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:month.date];
    //return (month.weekday - month.calendar.firstWeekday == 0);
    return (month.weekday - 2 == 0);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)even
{
    UITouch *touch = [touches anyObject];
    
    // Check if the touch is within the month container
    if ([touch.view isDescendantOfView:self.viewCalendar])
    {
        touchedView = [self dayViewForTouches:touches];
        if (touchedView == nil)
        {
            self.draggingStartDay = nil;
            self.dayStart = nil;
            return;
        }
        self.draggingStartDay = touchedView.day;
        self.draggingFixedDay = touchedView.day;
        self.draggedOffStartDay = NO;
        self.dayStart = touchedView;
        
    }
    else if ([touch.view isDescendantOfView:self.viewCalendarDetail])
    {
        
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isDescendantOfView:self.viewCalendar])
    {
        if (self.draggingStartDay == nil) {
            return;
        }
        if (self.dayStart == nil) {
            return;
        }
        touchedView = [self dayViewForTouches:touches];
        if (touchedView == nil)
        {
            self.draggingStartDay = nil;
            self.dayStart = nil;
            return;
        }
        if (!self.draggedOffStartDay)
        {
            if (![self.draggingStartDay isEqual:touchedView.day])
            {
                self.draggedOffStartDay = YES;
            }
        }
    }
    else if ([touch.view isDescendantOfView:self.viewCalendarDetail])
    {
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //if (CGRectContainsPoint(self.viewCalendar.frame, [touch locationInView:self.view]))
    if ([touch.view isDescendantOfView:self.viewCalendar])
    {
        if (self.draggingStartDay == nil)
        {
            return;
        }
        if (self.dayStart == nil)
        {
            return;
        }
        touchedView = [self dayViewForTouches:touches];
        if (touchedView == nil)
        {
            self.draggingStartDay = nil;
            self.dayStart = nil;
            return;
        }
        if (!self.draggedOffStartDay && [self.draggingStartDay isEqual:touchedView.day])
        {
            self.selectedRange = [[RRCalendarRange alloc] initWithStartDay:touchedView.day endDay:touchedView.day];
            NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
            NSString *info = [NSString stringWithFormat:@"%.2ld %.2ld %.4ld", (long)touchedView.day.day, (long)touchedView.day.month, (long)touchedView.day.year];
            
            [dateFormater setDateFormat:@"dd MM yyyy"];
            self.dateSelected = [dateFormater dateFromString:info];
            //dateExamination = nil;
            self.rightHandString = @"";
            self.leftHandString = @"";
            self.rightLegString = @"";
            self.leftLegString = @"";
            NSTimeInterval timeInterVal = [touchedView.dayAsDate.dayEnd timeIntervalSinceDate:[NSDate date]];
            NSInteger time = timeInterVal;

            if (time > 0)
            {
                [self loadDataRecord:YES];
            }
            else [self loadDataRecord:NO];
        }
        
        if (touchedView.day.year != _visibleMonth.year || touchedView.day.month != _visibleMonth.month)
        {
            
            BOOL animateToAdjacentMonth = YES;
            if (animateToAdjacentMonth)
            {
                if ([touchedView.dayAsDate compare:_visibleMonth.date] == NSOrderedAscending)
                {
                    [self previousMonth:self.selectedRange];
                }
                else {
                    [self nextMonth:self.selectedRange];
                }
            }
        }
    }
    if ([touch.view isDescendantOfView:self.viewCalendarDetail])
    {
        //[self btnDetailCalendarClicked];
        
    }
}

- (RRCalendarDayView *)dayViewForTouches:(NSSet*)touches
{
    if (touches.count != 1)
    {
        return nil;
    }
    
    UITouch *touch = [touches anyObject];
    
    // Check if the touch is within the month container
    if (!CGRectContainsPoint(self.monthContainerView.frame, [touch locationInView:self.monthContainerView.superview])) {
        return nil;
    }
    
    // Work out which day view was touched. We can't just use hit test on a root view because the month views can overlap
    for (RRCalendarMonthView *monthView in self.monthViews.allValues)
    {
        UIView *view = [monthView hitTest:[touch locationInView:monthView] withEvent:nil];
        if (view == nil) {
            continue;
        }
        
        while (view != monthView) {
            if ([view isKindOfClass:[RRCalendarDayView class]]) {
                return (RRCalendarDayView *)view;
            }
            
            view = view.superview;
        }
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Detail Calendar
- (void)btnDetailCalendarClicked
{
    if (self.selectedRange)
    {
        NSLog(@"%@", kRRTimingNotificationKey);
        [self.viewCalendarDetail.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.viewCalendarDetail.btnCalendarDetail.selected = !self.viewCalendarDetail.btnCalendarDetail.selected;
        if (self.viewCalendarDetail.btnCalendarDetail.selected)
        {
            self.viewCalendarDetail.frame = CGRectMake(0, 84 + self.monthContainerView.frame.size.height, self.viewCalendarDetail.frame.size.width, self.viewCalendarDetail.frame.size.height);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.viewCalendarDetail.frame = CGRectMake(0, self.monthContainerView.frame.origin.y + 45, self.viewCalendarDetail.frame.size.width, self.viewCalendarDetail.frame.size.height);
            self.viewCalendarDetail.backgroundColor = [UIColor clearColor];
            [UIView commitAnimations];
            self.viewCalendar.userInteractionEnabled = NO;
            self.btnNextMonth.enabled = NO;
            self.btnPreviousMonth.enabled = NO;
            self.lblTitleCalendar.enabled = NO;
            self.viewCalendarDetail.viewData.userInteractionEnabled = YES;
            
        }
        else
        {
            [self insertRecord];
            [self.view endEditing:YES];
            self.viewCalendarDetail.frame = CGRectMake(0, self.viewCalendarDetail.frame.origin.y, self.viewCalendarDetail.frame.size.width, self.viewCalendarDetail.frame.size.height);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.viewCalendarDetail.frame = CGRectMake(0, 84 + self.monthContainerView.frame.size.height, self.viewCalendarDetail.frame.size.width, self.viewCalendarDetail.frame.size.height);
            self.viewCalendarDetail.backgroundColor = [UIColor whiteColor];
            [UIView commitAnimations];
            self.viewCalendar.userInteractionEnabled = YES;
            self.btnNextMonth.enabled = YES;
            self.btnPreviousMonth.enabled = YES;
            self.lblTitleCalendar.enabled = YES;
            self.viewCalendarDetail.viewData.userInteractionEnabled = NO;
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"予告", "Message") message:NSLocalizedString(@"任意の日付を選択してください。", "Please select a day") delegate:self cancelButtonTitle:NSLocalizedString(@"桶", "Oke") otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
#pragma mark - Click UIImageview Calendar Detail
- (void)imgRightHandClicked
{
    typeImage = 1;
    if (!self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.btnCalendarDetail.selected = NO;
        [self btnDetailCalendarClicked];
    }
    if ([self.rightHandString isEqualToString:@""])
    {
        
        [self takePhoto];
    }
    else
    {
        self.photoBrowserView.deleteButton.hidden = NO;
        [self.photoBrowserView showPhotoBrowserWithImageURL:self.rightHandString];
    }
    
}
- (void)imgLeftHandClicked
{
    typeImage = 2;
    if (!self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.btnCalendarDetail.selected = NO;
        [self btnDetailCalendarClicked];
    }
    
    if ([self.leftHandString isEqualToString:@""])
    {
        [self takePhoto];
    }
    else
    {
        self.photoBrowserView.deleteButton.hidden = NO;
        [self.photoBrowserView showPhotoBrowserWithImageURL:self.leftHandString];
    }
    
    
}
- (void)imgRightLegClicked
{
    typeImage = 3;
    if (!self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.btnCalendarDetail.selected = NO;
        [self btnDetailCalendarClicked];
    }
    
    
    if ([self.rightLegString isEqualToString:@""])
    {
        [self takePhoto];
    }
    else
    {
        self.photoBrowserView.deleteButton.hidden = NO;
        [self.photoBrowserView showPhotoBrowserWithImageURL:self.rightLegString];
    }
    
    
}
- (void)imgLeftLegClicked
{
    typeImage = 4;
    if (!self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.btnCalendarDetail.selected = NO;
        [self btnDetailCalendarClicked];
    }
    
    if ([self.leftLegString isEqualToString:@""])
    {
        [self takePhoto];
    }
    else
    {
        self.photoBrowserView.deleteButton.hidden = NO;
        [self.photoBrowserView showPhotoBrowserWithImageURL:self.leftLegString];
    }
}
-(void)handleLeftSwipeGesture
{
    [self nextMonth:nil];
}
-(void)handleRightSwipeGesture
{
    [self previousMonth:nil];
}
#pragma mark - Take Photo

- (void)takePhoto
{
    imageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"キャンセル", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"カメラで撮影", @"Take Picture"), NSLocalizedString(@"アルバムから選択", @"Choose from Library"),  nil];
    [imageActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}
#pragma mark - Method in ActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //click button in image action Sheet
    if (actionSheet == imageActionSheet)
    {
        switch (buttonIndex)
        {
                
            case 0:
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:NO completion:nil];
                break;
            }
            case 1:
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:NO completion:nil];
            }
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage*    originalImage;
    UIImage *img;
    originalImage = info[UIImagePickerControllerEditedImage];
    CGImageRef cgimage1 = originalImage.CGImage;
    size_t width1  = CGImageGetWidth(cgimage1);
    size_t height1 = CGImageGetHeight(cgimage1);
    printf(" +++++width library first  %ld  library first %ld++++++",width1,height1);
    // Create image width and height is equal
    UIImage *imagePost;
    
    if(height1<640||width1<632)
    {
        UIImage * MaskImage = [UIImage imageNamed:@"00title.png"];
        CGSize finalSize = CGSizeMake(640,640);
        UIGraphicsBeginImageContext(finalSize);
        
        [MaskImage drawInRect:CGRectMake(0,0,640,640)];
        
        int xPosition;
        int yPosition ;
        int t_width = (int)width1;
        int t_height = (int)height1;
        
        // x Position
        if(width1<640)
        {
            xPosition = (int)((640-(t_width))/2);
            //============================
            printf(" t_width %d ",xPosition);
        }
        else
            xPosition = 0;
        
        // y Position
        if(height1<640)
        {
            yPosition = (int)(640-t_height)/2;
        }
        else
            yPosition = 0 ;
        
        [originalImage drawInRect:CGRectMake(xPosition,yPosition,width1,height1)];
        
        imagePost = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Create the image from a png file
        // Get size of current image
        CGRect rect;
        CGSize size = [imagePost size];
        // Create rectangle that represents a cropped image
        // from the middle of the existing image
        
        rect = CGRectMake(4,4,
                          (size.width - 8), (size.height - 8));
        // Create bitmap image from original image data,
        // using rectangle to specify desired crop area
        CGImageRef imageRef = CGImageCreateWithImageInRect([imagePost CGImage], rect);
        img = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    else
    {
        // Create the image from a png file
        // Get size of current image
        CGSize size = [originalImage size];
        // Create rectangle that represents a cropped image
        // from the middle of the existing image
        CGRect rect = CGRectMake(2,2,
                                 (size.width - 4), (size.height - 4));
        // Create bitmap image from original image data,
        // using rectangle to specify desired crop area
        CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], rect);
        img = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // Request to save the image to camera roll
    [library writeImageToSavedPhotosAlbum:[img CGImage] orientation:(ALAssetOrientation)[img imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error) {
            NSLog(@"error");
        } else {
            NSLog(@"url %@", assetURL);
            [library assetForURL:assetURL resultBlock:^(ALAsset *asset)
             {
                 UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
                 isTakeCamera = YES;
                 switch (typeImage)
                 {
                     case 1:
                         self.rightHandString = [assetURL absoluteString];
                         self.viewCalendarDetail.rightHandImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                         self.viewCalendarDetail.lblRightHand.hidden = YES;
                         break;
                     case 2:
                         self.leftHandString = [assetURL absoluteString];
                         self.viewCalendarDetail.leftHandImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                         self.viewCalendarDetail.lblLeftHand.hidden = YES;
                         break;
                     case 3:
                         self.rightLegString = [assetURL absoluteString];
                         self.viewCalendarDetail.rightLegImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                         self.viewCalendarDetail.lblRightLeg.hidden = YES;
                         break;
                     case 4:
                         self.leftLegString = [assetURL absoluteString];
                         self.viewCalendarDetail.leftLegImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                         self.viewCalendarDetail.lblLeftLeg.hidden = YES;
                         break;
                     default:
                         break;
                 }
                 
                 
             }
                    failureBlock:^(NSError *error)
             {
                 // error handling
                 NSLog(@"failure-----");
             }];
            
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    isTakeCamera = YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Database
- (void)insertRecord
{
    //Date examination
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"HH:mm"];
    if ([self.viewCalendarDetail.txtExaminationTime.text isEqualToString:@""])
    {
        dateExamination = nil;
    }
    else dateExamination = [dateFormater dateFromString:self.viewCalendarDetail.txtExaminationTime.text];
    
    NSMutableDictionary *dataRecord = [[NSMutableDictionary alloc] init];
    [dataRecord setValue:self.dateSelected forKey:kRRRashRecordDate];
    [dataRecord setValue:self.rightHandString forKey:kRRRashRecordPtRightHand];
    [dataRecord setValue:self.leftHandString forKey:kRRRashRecordPtLeftHand];
    [dataRecord setValue:self.rightLegString forKey:kRRRashRecordPtRightLeg];
    [dataRecord setValue:self.leftLegString forKey:kRRRashRecordPtLeftLeg];
    [dataRecord setValue:self.viewCalendarDetail.txtDiseaseName.text forKey:kRRRashRecordTile];
    [dataRecord setValue:[NSString stringWithFormat:@"%d", self.viewCalendarDetail.numAM] forKey:kRRRashRecordNumAmPin];
    [dataRecord setValue:[NSString stringWithFormat:@"%d", self.viewCalendarDetail.numPM] forKey:kRRRashRecordNumPmPin];
    
    [dataRecord setValue:dateExamination forKey:kRRRashRecordHosTime];
    [dataRecord setValue:self.viewCalendarDetail.txtExaminationPlace.text forKey:kRRRashRecordHosAddress];
    [dataRecord setValue:self.viewCalendarDetail.textViewNote.text forKey:kRRRashRecordDes];
    NSMutableArray *result = [[RRDatabaseHelper shareMyInstance] getRecordObjectsFromDate:self.dateSelected.dayBegin toDate:self.dateSelected.dayEnd withTableName:kRRRashRecordTableName];
    if ([result count] == 0)
    {
        [[RRDatabaseHelper shareMyInstance] insertObjectToDataBase:kRRRashRecordTableName withDictionnary:dataRecord];
    }
    else
    {
        RashRecord *updateRashRecord = [result objectAtIndex:0];
        updateRashRecord.date = self.dateSelected;
        updateRashRecord.des = self.viewCalendarDetail.textViewNote.text;
        updateRashRecord.pt_right_leg = self.rightHandString;
        updateRashRecord.pt_left_leg = self.leftHandString;
        updateRashRecord.pt_right_hand = self.rightLegString;
        updateRashRecord.pt_left_hand = self.leftLegString;
        updateRashRecord.num_pm_pin = [NSString stringWithFormat:@"%d", self.viewCalendarDetail.numAM];
        updateRashRecord.num_am_pin = [NSString stringWithFormat:@"%d", self.viewCalendarDetail.numPM];
        updateRashRecord.title = self.viewCalendarDetail.txtDiseaseName.text;
        updateRashRecord.hos_address = self.viewCalendarDetail.txtExaminationPlace.text;
        updateRashRecord.hos_time = dateExamination;
        [[RRDatabaseHelper shareMyInstance] updateObjectToDatabase:updateRashRecord withDictionnary:dataRecord];
    }
    /*
    if (touchedView != nil)
    {
        [touchedView drawRect:CGRectMake(touchedView.frame.origin.x, touchedView.frame.origin.y, touchedView.frame.size.width, touchedView.frame.size.height)];
    }
    else
    {*/
    RRCalendarMonthView *monthView = [activeMonthViews objectAtIndex:2];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:self.dateSelected];
        
    for (RRCalendarDayView *dayView in monthView.dayViews)
        {
            if (dayView.day.day == dateComponents.day && dayView.day.month == dateComponents.month && dayView.day.year == dateComponents.year)
            {
                [dayView drawRect:CGRectMake(dayView.frame.origin.x, dayView.frame.origin.y, dayView.frame.size.width, dayView.frame.size.height)];
            }
        }
    //}
    
}

#pragma mark - Delegate RRRecord Detail
- (void)textFieldBeginEditting
{
    if (!self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.btnCalendarDetail.selected = NO;
        [self btnDetailCalendarClicked];
    }
    
}
- (void)textFieldShouldBeginEditting
{
    [self.datePickerView setDate:[NSDate date]];
    [self showDatePicker];
}
- (void)clickIconMedicine
{
    [self.view endEditing:YES];
    if (!self.viewCalendarDetail.btnCalendarDetail.selected)
    {
        self.viewCalendarDetail.btnCalendarDetail.selected = NO;
        [self btnDetailCalendarClicked];
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

- (void)loadDataRecord: (BOOL)isNewRecord
{
        NSMutableArray *recordArray = [[RRDatabaseHelper   shareMyInstance] getRecordObjectsFromDate:self.dateSelected.dayBegin toDate:self.dateSelected.dayEnd withTableName:kRRRashRecordTableName];
        
        if ([recordArray count] > 0)
        {
            RashRecord *record = [recordArray objectAtIndex:0];
            if (record != nil)
            {
                //UIImage
                //Right hand
                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                if (![record.pt_right_hand isEqualToString:@""] || ![record.pt_left_hand isEqualToString:@""] || ![record.pt_right_leg isEqualToString:@""] || ![record.pt_left_leg isEqualToString:@""])
                {
                    if (![record.pt_right_hand isEqualToString:@""])
                    {
                        self.rightHandString = record.pt_right_hand;
                        [library assetForURL:[NSURL URLWithString:record.pt_right_hand] resultBlock:^(ALAsset *asset)
                         {
                             UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
                             self.viewCalendarDetail.rightHandImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                             self.viewCalendarDetail.lblRightHand.hidden = YES;
                             
                         }
                                failureBlock:^(NSError *error)
                         {
                             // error handling
                             NSLog(@"failure-----");
                         }];
                    }
                    else
                    {
                        self.viewCalendarDetail.rightHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                        self.viewCalendarDetail.lblRightHand.hidden = NO;
                    }
                    //left hand
                    if (![record.pt_left_hand isEqualToString:@""])
                    {
                        self.leftHandString = record.pt_left_hand;
                        [library assetForURL:[NSURL URLWithString:record.pt_left_hand] resultBlock:^(ALAsset *asset)
                         {
                             UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
                             self.viewCalendarDetail.leftHandImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                             self.viewCalendarDetail.lblLeftHand.hidden = YES;
                             
                         }
                                failureBlock:^(NSError *error)
                         {
                             // error handling
                             NSLog(@"failure-----");
                         }];
                        
                    }
                    else
                    {
                        self.viewCalendarDetail.leftHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                        self.viewCalendarDetail.lblLeftHand.hidden = NO;
                    }
                    
                    //Right Leg
                    if (![record.pt_right_leg isEqualToString:@""])
                    {
                        self.rightLegString = record.pt_right_leg;
                        [library assetForURL:[NSURL URLWithString:record.pt_right_leg] resultBlock:^(ALAsset *asset)
                         {
                             UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
                             self.viewCalendarDetail.rightLegImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                             self.viewCalendarDetail.lblRightLeg.hidden = YES;
                             
                         }
                                failureBlock:^(NSError *error)
                         {
                             // error handling
                             NSLog(@"failure-----");
                         }];
                        
                    }
                    else
                    {
                        self.viewCalendarDetail.rightLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                        self.viewCalendarDetail.lblRightLeg.hidden = NO;
                    }
                    
                    //Left leg
                    if (![record.pt_left_leg isEqualToString:@""])
                    {
                        self.leftLegString = record.pt_left_leg;
                        [library assetForURL:[NSURL URLWithString:record.pt_left_leg] resultBlock:^(ALAsset *asset)
                         {
                             UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
                             self.viewCalendarDetail.leftLegImageView.image = [self imageWithImage:copyOfOriginalImage scaledToSize:CGSizeMake(64, 64)];
                             self.viewCalendarDetail.lblLeftLeg.hidden = YES;
                             
                         }
                                failureBlock:^(NSError *error)
                         {
                             // error handling
                             NSLog(@"failure-----");
                         }];
                        
                    }
                    else
                    {
                        self.viewCalendarDetail.leftLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                        self.viewCalendarDetail.lblLeftLeg.hidden = NO;
                    }
                    
                    
                }
                else
                {
                    self.viewCalendarDetail.rightHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                    self.viewCalendarDetail.leftHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                    self.viewCalendarDetail.rightLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                    self.viewCalendarDetail.leftLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
                    self.viewCalendarDetail.lblRightHand.hidden = NO;
                    self.viewCalendarDetail.lblLeftHand.hidden = NO;
                    self.viewCalendarDetail.lblRightLeg.hidden = NO;
                    self.viewCalendarDetail.lblLeftLeg.hidden = NO;
                }
                //Note
                if (![record.des isEqualToString:@""])
                {
                    self.viewCalendarDetail.textViewNote.text = record.des;
                }
                else
                {
                    self.viewCalendarDetail.textViewNote.text = @"";
                }
                
                //Examination
                if (record.hos_time != nil)
                {
                    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
                    NSString *info;
                    
                    [dateFormater setDateFormat:@"HH:mm"];
                    info = [dateFormater stringFromDate:record.hos_time];
                    self.viewCalendarDetail.txtExaminationTime.text = info;
                }
                else
                {
                    self.viewCalendarDetail.txtExaminationTime.text = @"";
                }
                
                //Medicine
                self.viewCalendarDetail.numAM = [record.num_am_pin intValue] ;
                [self.viewCalendarDetail loadButtonMedicineMorning];
                self.viewCalendarDetail.numPM = [record.num_pm_pin intValue];
                [self.viewCalendarDetail loadButtonMedicineNight];
                
                //Place Examination
                self.viewCalendarDetail.txtExaminationPlace.text = record.hos_address;
                
                //Disable name
                self.viewCalendarDetail.txtDiseaseName.text = record.title;
                
            }
            
        }
        else
        {
            if (isNewRecord)
            {
                [self resetRecord:YES];
            }
            else [self resetRecord:NO];
        }
    
}
#pragma getter Photo Browser
- (RRPhotoBrowserView *)photoBrowserView
{
	if (!_photoBrowserView) {
		_photoBrowserView = [UIView loadFromNibNamed:@"RRPhotoBrowserView"];
	}
	return _photoBrowserView;
}
- (void)deleteButton
{
    
    switch (typeImage)
    {
        case 1:
            self.rightHandString = @"";
            self.viewCalendarDetail.rightHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
            self.viewCalendarDetail.lblRightHand.hidden = NO;
            break;
        case 2:
            self.leftHandString = @"";
            self.viewCalendarDetail.leftHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
            self.viewCalendarDetail.lblLeftHand.hidden = NO;
            break;
        case 3:
            self.rightLegString = @"";
            self.viewCalendarDetail.rightLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
            self.viewCalendarDetail.lblRightLeg.hidden = NO;
            break;
        case 4:
            self.leftLegString = @"";
            self.viewCalendarDetail.leftLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
            self.viewCalendarDetail.lblLeftLeg.hidden = NO;
            break;
    }
    
}
- (void)resetRecord: (BOOL)isNewRecord
{
    self.viewCalendarDetail.rightHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
    self.viewCalendarDetail.leftHandImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
    self.viewCalendarDetail.rightLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
    self.viewCalendarDetail.leftLegImageView.image = [UIImage imageNamed:@"icon_calendar_no_image.png"];
    self.viewCalendarDetail.lblRightHand.hidden = NO;
    self.viewCalendarDetail.lblLeftHand.hidden = NO;
    self.viewCalendarDetail.lblRightLeg.hidden = NO;
    self.viewCalendarDetail.lblLeftLeg.hidden = NO;
    self.viewCalendarDetail.txtDiseaseName.text = @"";
    self.viewCalendarDetail.textViewNote.text = @"";
    self.viewCalendarDetail.txtExaminationTime.text = @"";
    if (isNewRecord)
    {
        NSLog(@"%d", kRRDosageNoteIndex);
        switch (kRRDosageNoteIndex)
        {
            case 0:
                self.viewCalendarDetail.numAM = 0;
                self.viewCalendarDetail.numPM = 0;
                break;
            case 1:
                self.viewCalendarDetail.numAM = 1;
                self.viewCalendarDetail.numPM = 0;
                break;
            case 2:
                self.viewCalendarDetail.numAM = 0;
                self.viewCalendarDetail.numPM = 1;
                break;
            case 3:
                self.viewCalendarDetail.numAM = 1;
                self.viewCalendarDetail.numPM = 1;
                break;
            case 4:
                self.viewCalendarDetail.numAM = 2;
                self.viewCalendarDetail.numPM = 0;
                break;
            case 5:
                self.viewCalendarDetail.numAM = 0;
                self.viewCalendarDetail.numPM = 2;
                break;
            case 6:
                self.viewCalendarDetail.numAM = 2;
                self.viewCalendarDetail.numPM = 1;
                break;
            case 7:
                self.viewCalendarDetail.numAM = 1;
                self.viewCalendarDetail.numPM = 2;
                break;
            case 8:
                self.viewCalendarDetail.numAM = 2;
                self.viewCalendarDetail.numPM = 2;
                break;
                
        }
    }
    else
    {
        self.viewCalendarDetail.numAM = 0;
        self.viewCalendarDetail.numPM = 0;
    }
    [self.viewCalendarDetail loadButtonMedicineMorning];
    [self.viewCalendarDetail loadButtonMedicineNight];
    self.viewCalendarDetail.txtExaminationPlace.text = @"";
    
}
#pragma mark - Date Picker
- (RRDatePicker *)datePickerView
{
    if (_datePickerView) {
        _datePickerView = nil;
    }
    _datePickerView = [[RRDatePicker alloc] init];
    _datePickerView.y = self.view.height;
    [self.view addSubview:_datePickerView];
    [self.view bringSubviewToFront:_datePickerView];
    _datePickerView.delegate = self;
    return _datePickerView;
    
}

- (void)showDatePicker
{
    _datePickerShowing = YES;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _datePickerView.y = 0;
                         [self.view bringSubviewToFront:_datePickerView];
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)hideDatePicker
{
    _datePickerShowing = NO;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _datePickerView.y =  self.view.height;
                     }
                     completion:^(BOOL finished){
                     }];
}
#pragma mark - date picker delegate

- (void)clickDoneBtnWithDate:(NSDate *)date
{
    [self hideDatePicker];
    [self.viewCalendarDetail.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    NSString *info;
    
    [dateFormater setDateFormat:@"HH:mm"];
    info = [dateFormater stringFromDate:date];
    self.viewCalendarDetail.txtExaminationTime.text = info;
    
}

- (void)didTouchesScreen
{
    [self hideDatePicker];
    [self.viewCalendarDetail.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.viewCalendarDetail.txtExaminationTime.text = @"";

}
@end