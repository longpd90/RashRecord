//
//  PDARDatePicker.m
//  Pashadelic
//
//  Created by LongPD on 2/6/14.
//

#import "RRDatePicker.h"

@implementation RRDatePicker

- (id)init
{
	self = [UIView loadFromNibNamed:@"RRDatePicker"];
	
	if (self) {
	}
	return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - setters

- (void)setDosageIndex:(int)dosageIndex
{
    [self addSubview:_dosageView];
    _dosageView.y = self.height - _dosageView.height;
    _dosagesButton = [NSArray arrayWithObjects:_dosage1,_dosage2,_dosage3,_dosage4,_dosage5,_dosage6,_dosage7,_dosage8,_dosage9, nil];
    if (dosageIndex > 0) {
        UIButton *activeButton = (UIButton *)[_dosagesButton objectAtIndex:dosageIndex-1];
        activeButton.backgroundColor = [UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1];
    }
}

- (void)setTimingIndex:(int)timingIndex
{
    [self addSubview:_timingView];
    _timingView.y = self.height - _timingView.height;
    _timingsButton = [NSArray arrayWithObjects:_timing1,_timing2,_timing3,_timing4,_timing5,_timing6, nil];
    if (timingIndex > 0) {
        UIButton *activeButton = (UIButton *)[_timingsButton objectAtIndex:timingIndex-1];
        activeButton.backgroundColor = [UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1];
    }
}

#pragma mark - setters

- (void)setDate:(NSDate *)date withAM:(BOOL )AM
{
    [self addSubview:_datePickerBackgroundView];
    _datePickerBackgroundView.y = self.height - _datePickerBackgroundView.height;
    _datePicker.date = date;
    if (AM) {
        _datePicker.minimumDate = date.dayBegin;
        _datePicker.maximumDate = [NSDate dateWithTimeInterval:kRRNumberSecondsInDay/2.0 sinceDate:date.dayBegin];
    } else {
        _datePicker.maximumDate = date.dayEnd;
        _datePicker.minimumDate = [NSDate dateWithTimeInterval:- kRRNumberSecondsInDay/2.0 sinceDate:date.dayEnd];
    }

    _date = date;
}

- (void)setDate:(NSDate *)date
{
    [self addSubview:_datePickerBackgroundView];
    _datePickerBackgroundView.y = self.height - _datePickerBackgroundView.height;
    _datePicker.date = date;
    _date = date;
}

#pragma mark - action

- (IBAction)btndoneTaped:(id)sender {
    _date = [_datePicker date];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDoneBtnWithDate:)]) {
        [self.delegate clickDoneBtnWithDate:_date];
    }
}

- (IBAction)btnCancelTaped:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDoneBtnWithDate:)]) {
        [self.delegate didTouchesScreen];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDoneBtnWithDate:)]) {
        [self.delegate didTouchesScreen];
    }
}

- (IBAction)selectTiming:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTiming:atIndex:)]) {
        [self.delegate didSelectedTiming:sender.titleLabel.text atIndex:sender.tag];
    }
}

- (IBAction)selectDosage:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedDosage:atIndex:)]) {
        [self.delegate didSelectedDosage:sender.titleLabel.text atIndex:sender.tag];
    }
}

@end
