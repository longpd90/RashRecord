//
//  RRRemindViewController.m
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRDosageViewController.h"

@interface RRDosageViewController ()

@property (strong, nonatomic) NSMutableArray *rashRecords;
@property (strong, nonatomic) NSMutableArray *dayLabels;
@property (strong, nonatomic) NSMutableArray *weekDayLabels;
@property (strong, nonatomic) NSMutableArray *imageDays;
@property (strong, nonatomic) NSMutableArray *dosageImageViews;

@property (strong, nonatomic) NSMutableArray *dosageFirstImageViews;
@property (strong, nonatomic) NSMutableArray *dosageSecondImageViews;
@property (strong, nonatomic) NSMutableArray *dosageThirdImageViews;
@property (strong, nonatomic) NSMutableArray *dosageFourthImageViews;
@property (strong, nonatomic) NSMutableArray *dosageFifthImageViews;
@property (strong, nonatomic) NSMutableArray *dosageSixthImageViews;
@property (strong, nonatomic) NSMutableArray *dosageSeventhImageViews;
@property (strong, nonatomic) NSDate *dateStart;
@property (strong, nonatomic) NSDate *dateEnd;

@end

@implementation RRDosageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDate];
    
    self.leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureHandler)];
	self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.dosageView addGestureRecognizer:self.leftSwipeGesture];
    
	self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureHandler)];
	self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
	[self.dosageView addGestureRecognizer:self.rightSwipeGesture];
    
    _dayLabels = [[NSMutableArray alloc]initWithObjects:_firstDay,_secondDay,_third,_fourthDay,_fifthDay,_sixthDay,_seventhDay, nil];
    _weekDayLabels = [[NSMutableArray alloc]initWithObjects:_firstWeekday,_secondWeekday,_thirdWeekday,_fourthWeekday,_fifthWeekday,_sixthWeekday,_seventhWeekday, nil];
    _imageDays = [[NSMutableArray alloc]initWithObjects:_firstImage,_secondImage,_thirdImage,_fourthImage,_fifthImage,_sixthImage,_seventhImage, nil];
    
    _dosageFirstImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1FirstDay,_medicine2FirstDay,_medicine3FirstDay,_medicine4FirstDay, nil];
    _dosageSecondImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1secondDay,_medicine2secondDay,_medicine3secondDay,_medicine4secondDay, nil];
    _dosageThirdImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1thirdDay,_medicine2thirdDay,_medicine3thirdDay,_medicine4thirdDay, nil];
    _dosageFourthImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1fourthDay,_medicine2fourthDay,_medicine3fourthDay,_medicine4fourthDay, nil];
    _dosageFifthImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1fifthDay,_medicine2fifthDay,_medicine3fifthDay,_medicine4fifthDay, nil];
    _dosageSixthImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1sixthDay,_medicine2sixthDay,_medicine3sixthDay,_medicine4sixthDay, nil];
    _dosageSeventhImageViews = [[NSMutableArray alloc]initWithObjects:_medicine1seventhDay,_medicine2seventhDay,_medicine3seventhDay,_medicine4seventhDay, nil];

    _dosageImageViews = [[NSMutableArray alloc]initWithObjects:_dosageFirstImageViews,_dosageSecondImageViews,_dosageThirdImageViews,_dosageFourthImageViews,_dosageFifthImageViews,_dosageSixthImageViews,_dosageSeventhImageViews,nil];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getRecordThisTime];
    [self setDosageContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private

- (void)initDate
{
    NSDate *today = [NSDate date];
    int weekDay = [today weekDay];
    if (weekDay == 1) {
        self.dateStart = [[NSDate dateWithTimeInterval:-6 * kRRNumberSecondsInDay sinceDate:today] dayBegin];
        
    } else {
        self.dateStart = [[NSDate dateWithTimeInterval:(2 - weekDay) * kRRNumberSecondsInDay sinceDate:today] dayBegin];
    }
    self.dateEnd = [NSDate dateWithTimeInterval:7 * kRRNumberSecondsInDay sinceDate:_dateStart];
    
}

- (BOOL)imageURL:(RashRecord *)rashRecord
{
    if (rashRecord.pt_left_hand.length > 0 ||
        rashRecord.pt_right_hand.length > 0 ||
        rashRecord.pt_left_leg.length > 0 ||
        rashRecord.pt_right_leg.length > 0)
    {
        return YES;
    } else {
        return NO;
    }
}

- (void)setDosageContentView
{
    for (int i = 0; i < _dayLabels.count; i ++) {
        UILabel *dayLabel = [_dayLabels objectAtIndex:i];
        UILabel *weekDayLabel = [_weekDayLabels objectAtIndex:i];

        NSDate *date = [NSDate dateWithTimeInterval:i * kRRNumberSecondsInDay sinceDate:self.dateStart];
        int dayValue = [[date stringValueFormattedBy:@"dd"] intValue];
        int monthValue = [[date stringValueFormattedBy:@"MM"] intValue];
        dayLabel.text = [NSString stringWithFormat:@"%d/%d",monthValue,dayValue];
        
        NSDate *today = [NSDate date];
       NSComparisonResult compareResult = [today compareDay:date];
        if (compareResult == NSOrderedSame) {
            [dayLabel setBackgroundColor:[UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1]];
            [weekDayLabel setBackgroundColor:[UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1]];

        } else {
            [dayLabel setBackgroundColor:[UIColor clearColor]];
            [weekDayLabel setBackgroundColor:[UIColor clearColor]];
        }

    }
    
    int monthValue = [[_dateStart stringValueFormattedBy:@"MM"] intValue];

    _nameOfMonthLabel.text = [NSString stringWithFormat:@"%d月の服薬量",monthValue];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    NSArray *allRecords = [[RRDatabaseHelper shareMyInstance] getAllRecordObjectsFromDatabase:kRRRashRecordTableName];
    NSString *allRecordsString = [numberFormatter stringFromNumber:[NSNumber numberWithInt: [self dosageInArray:allRecords] * 200]];
    _allDosage.text =[NSString stringWithFormat:@"%@mg",allRecordsString];
    
    NSArray *thisWeekRecords = [[RRDatabaseHelper shareMyInstance] getRecordObjectsFromDate:self.dateStart toDate:self.dateEnd withTableName:kRRRashRecordTableName];
    NSString *thisWeekRecordsString = [numberFormatter stringFromNumber:[NSNumber numberWithInt: [self dosageInArray:thisWeekRecords] * 200]];
    _dosageThisTime.text = [NSString stringWithFormat:@"%@mg",thisWeekRecordsString];

    NSDate *monthStart = [self.dateStart monthBegin];
    NSDate *monthEnd = [self.dateStart monthEnd];
    NSArray *thisMonthRecords = [[RRDatabaseHelper shareMyInstance] getRecordObjectsFromDate:monthStart toDate:monthEnd withTableName:kRRRashRecordTableName];
    NSString *thisMonthRecordsString = [numberFormatter stringFromNumber:[NSNumber numberWithInt: [self dosageInArray:thisMonthRecords] * 200]];
    _dosageThisMonth.text = [NSString stringWithFormat:@"%@mg",thisMonthRecordsString];
}

- (NSInteger)dosageInArray:(NSArray *)records
{
    int dosage = 0;
    for (int i = 0; i < records.count; i ++) {
        RashRecord *rashRecord = [records objectAtIndex:i];
        dosage = dosage + ([rashRecord.num_am_pin intValue] + [rashRecord.num_pm_pin intValue]);
    }
    
    return dosage;
}

# pragma mark - action

#pragma mark - Gesture Recognizer

- (void)swipeLeftGestureHandler
{
    self.dateStart = self.dateEnd;
    self.dateEnd = [NSDate dateWithTimeInterval: 7 * kRRNumberSecondsInDay sinceDate:self.dateStart];
    [self getRecordThisTime];
    [self setDosageContentView];
}

- (void)swipeRightGestureHandler
{
    self.dateEnd = _dateStart;
    self.dateStart = [NSDate dateWithTimeInterval: -7 * kRRNumberSecondsInDay sinceDate:self.dateEnd];
    [self getRecordThisTime];
    [self setDosageContentView];
}

- (IBAction)showRecordPhotos:(UIButton *)sender {
    NSDate *dayBegin = [NSDate dateWithTimeInterval:sender.tag * kRRNumberSecondsInDay sinceDate:_dateStart.dayBegin];
    NSDate *dayEnd = [NSDate dateWithTimeInterval:kRRNumberSecondsInDay sinceDate:dayBegin];
    NSArray *rashRecords = [[RRDatabaseHelper shareMyInstance] getRecordObjectsFromDate:dayBegin toDate:dayEnd withTableName:kRRRashRecordTableName];
    if (rashRecords.count > 0) {
        RashRecord *rashRecord = [rashRecords objectAtIndex:0];
        [self.photoBrowserView showRecordPhotos:rashRecord];
    }
}

- (void)getRecordThisTime
{
    for (int i = 0; i < 7; i ++) {
        NSDate *dayBegin = [NSDate dateWithTimeInterval:i * kRRNumberSecondsInDay sinceDate:_dateStart.dayBegin];
        NSDate *dayEnd = [NSDate dateWithTimeInterval:i*kRRNumberSecondsInDay sinceDate:_dateStart.dayEnd];
        NSArray *rashRecords = [[RRDatabaseHelper shareMyInstance] getRecordObjectsFromDate:dayBegin toDate:dayEnd withTableName:kRRRashRecordTableName];
        if (rashRecords.count > 0) {
            RashRecord *rashRecord = [rashRecords objectAtIndex:0];
            [self setRecord:rashRecord AtIndex:i];
        } else {
            [self resetRecordAtIndex:i];
        }
    }
}

- (void)setRecord:(RashRecord *)rashRecord AtIndex:(NSInteger)index
{
    UIButton *button = [_imageDays objectAtIndex:index];
    button.hidden =! [self imageURL:rashRecord];
    int dosage = [rashRecord.num_am_pin intValue] + [rashRecord.num_pm_pin intValue];
    [self setDosage:dosage atIndex:index];
    
}

- (void)resetRecordAtIndex:(NSInteger)index
{
    UIButton *button = [_imageDays objectAtIndex:index];
    button.hidden = YES;
    [self resetDosageAtIndex:index];
    
}

- (void)setDosage:(NSInteger)dosage atIndex:(NSInteger)index
{
    NSArray *array = [_dosageImageViews objectAtIndex:index];
    for (int i = 0; i < array.count; i ++) {
        UIImageView *imageView = [array objectAtIndex:i];
        imageView.image = [UIImage imageNamed:(dosage > i)?@"medicament-drinked.png":@"medicament-not-drink.png"];
    }
}

- (void)resetDosageAtIndex:(NSInteger)index
{
    NSArray *array = [_dosageImageViews objectAtIndex:index];
    for (int i = 0; i < array.count; i ++) {
        UIImageView *imageView = [array objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"medicament-not-drink.png"];
    }
}

#pragma mark - Getters

- (RRPhotoBrowserView *)photoBrowserView
{
	if (!_photoBrowserView) {
        _photoBrowserView = [UIView loadFromNibNamed:@"RRPhotoBrowserView"];
	}
    return _photoBrowserView;

}

@end
