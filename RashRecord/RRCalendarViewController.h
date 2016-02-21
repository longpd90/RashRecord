//
//  RRCalendarViewController.h
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRViewController.h"
#import "NSDate+DSLCalendarView.h"
#import "RRCalendarDayView.h"
#import "RRCalendarMonthView.h"
#import "RRCalendarRange.h"
#import "RRRecordDetailView.h"
#import "RRPhotoBrowserView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RRConstantMonthActive.h"
#import "RRDatePicker.h"


@interface RRCalendarViewController : RRViewController<RRRecordDetailDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RRPhotoBrowserViewDelegate, UIActionSheetDelegate, RRDatePickerrDelegate>
{
    CGFloat dayViewHeight;
    CGFloat dayViewWidth;
    NSDateComponents *_visibleMonth;
    int typeImage;
    NSDate *dateExamination;
    RRCalendarDayView *touchedView;
    NSMutableArray *activeMonthViews;
    UIActionSheet *imageActionSheet;
    BOOL isTakeCamera;
}
@property (weak, nonatomic) IBOutlet UIButton *btnPreviousMonth;
@property (weak, nonatomic) IBOutlet UIButton *btnNextMonth;

@property (weak, nonatomic) IBOutlet UIView *viewCalendar;
@property (weak, nonatomic) IBOutlet UIView *viewTitleCalendar;
@property (weak, nonatomic) IBOutlet UIView *viewDayCalendar;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleCalendar;
@property (weak, nonatomic) IBOutlet UIView *viewMonthCalendar;
@property (nonatomic, strong) RRCalendarRange *selectedRange;
@property (nonatomic, strong) RRCalendarDayView *dayStart;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dayLabels;

@property (nonatomic, copy) NSDateComponents *visibleMonth;
@property (nonatomic, assign) BOOL showDayCalloutView;
@property (nonatomic, copy) NSDateComponents *draggingFixedDay;
@property (nonatomic, copy) NSDateComponents *draggingStartDay;
@property (nonatomic, assign) BOOL draggedOffStartDay;
@property (nonatomic, strong) NSDate *dateSelected;

@property (nonatomic, strong) NSMutableDictionary *monthViews;
@property (nonatomic, strong) UIView *monthContainerView;
@property (nonatomic, strong) UIView *monthContainerViewContentView;
@property (nonatomic, strong) UIScrollView *scrollMonthView;

+ (Class)monthViewClass;
+ (Class)dayViewClass;
- (IBAction)btnPreviousMonthClicked:(id)sender;
- (IBAction)btnNextMonthClicked:(id)sender;
- (void)setVisibleMonth:(NSDateComponents *)visibleMonth animated:(BOOL)animated;



//Calendar Details
@property (nonatomic, strong) RRRecordDetailView *viewCalendarDetail;


@property (strong, nonatomic)  NSString *rightHandString;
@property (strong, nonatomic)  NSString *leftHandString;
@property (strong, nonatomic)  NSString *leftLegString;
@property (strong, nonatomic)  NSString *rightLegString;




//Detail Photo
@property (nonatomic, strong) RRPhotoBrowserView *photoBrowserView;

//Date Picker
@property (strong, nonatomic) RRDatePicker *datePickerView;
@property (assign, nonatomic) BOOL datePickerShowing;
@end

