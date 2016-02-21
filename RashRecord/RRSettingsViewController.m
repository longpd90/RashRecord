//
//  RRSettingsViewController.m
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRSettingsViewController.h"

@interface RRSettingsViewController ()
- (IBAction)valueChangeSegment:(UISegmentedControl *)sender;

@end

@implementation RRSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - private

- (void)setContentView
{
    _userTextfield.text = kRRUserName;
    _sexSegment.selectedSegmentIndex = kRRUserSex;
    if(kRRDosageNote)
    {
        _dosageLabel.text = [NSString stringWithFormat:@"%@",kRRDosageNote];
    }
    _dosageAMSegment.selectedSegmentIndex = kRRDosageAM;
    _timeAMButton.enabled =! kRRDosageAM;
    _dosagePMSegment.selectedSegmentIndex = kRRDosagePM;
    _timePMButton.enabled =! kRRDosagePM;
    
    if (kRRTimeDrinkAM) {
        _timeAMLabel.text = [(NSDate *)kRRTimeDrinkAM stringValueFormattedBy:@"HH:mm"];
    }
    if (kRRTimeDrinkPM) {
        _timePMLabel.text = [(NSDate *)kRRTimeDrinkPM stringValueFormattedBy:@"HH:mm"];
    }
    _notificationSegment.selectedSegmentIndex = kRRNotificationGoToHospital;
    _timingbutton.enabled =! kRRNotificationGoToHospital;

    if (kRRTimingNotification) {
        _timingLabel.text = [NSString stringWithFormat:@"%@",kRRTimingNotification];
    }
    
    [self refreshFooterView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)refreshFooterView
{
    if (kRRDosageNoteIndex == 1) {
        self.dosageAMView.hidden = YES;
        self.dosagePMView.hidden = YES;
        self.footerView.y = 185;
    } else if (kRRDosageNoteIndex == 2 || kRRDosageNoteIndex == 5) {
        self.dosageAMView.hidden = NO;
        self.dosagePMView.hidden = YES;
        self.dosageAMView.y = 165;
        self.footerView.y = self.dosageAMView.bottomYPoint + 30;
    } else if (kRRDosageNoteIndex == 3 || kRRDosageNoteIndex == 6) {
        self.dosageAMView.hidden = YES;
        self.dosagePMView.hidden = NO;
        self.dosagePMView.y = 165;
        self.footerView.y = self.dosagePMView.bottomYPoint + 30;
    } else {
        self.dosageAMView.hidden = NO;
        self.dosagePMView.hidden = NO;

        self.dosageAMView.y = 165;
        self.dosagePMView.y = 210;
        self.footerView.y = self.dosagePMView.bottomYPoint + 30;
    }
}

- (void)showOverlayView
{
    if (!self.overlayView) {
        self.overlayView = [[RROverlayView alloc] initWithFrame:self.view.frame];
        self.overlayView.delegate = self;
        [self.view addSubview:self.overlayView];
    }
    self.overlayView.hidden = NO;

}

#pragma mark - action

- (IBAction)dosageButtonSelected:(UIButton *)sender {
    if (!sender.selected) {
        [self.datePickerView setDosageIndex:kRRDosageNoteIndex];
        [self showDatePicker];
    }
    sender.selected =! sender.selected;

}

- (IBAction)timingNotification:(UIButton *)sender {
    if (!sender.selected) {
        [self.datePickerView setTimingIndex:kRRTimingNotificationIndex];
        [self showDatePicker];
    }
    sender.selected =! sender.selected;
}

- (IBAction)valueChangeSegment:(UISegmentedControl *)sender {
    switch (sender.tag) {
        case 0:
            [kRRUserDefaults setInteger:sender.selectedSegmentIndex forKey:kRRUserSexKey];
            break;
        case 1:
            [kRRUserDefaults setInteger:sender.selectedSegmentIndex forKey:kRRDosageAMKey];
            _timeAMButton.enabled =! kRRDosageAM;
            break;
        case 2:
            [kRRUserDefaults setInteger:sender.selectedSegmentIndex forKey:kRRDosagePMKey];
            _timePMButton.enabled =! kRRDosagePM;
            break;
        case 3:
            [kRRUserDefaults setInteger:sender.selectedSegmentIndex forKey:kRRNotificationGoToHospitalKey];
            _timingbutton.enabled =! kRRNotificationGoToHospital;

            break;
        default:
            break;
    }
}

# pragma mark - date picker

- (IBAction)selectDate:(UIButton *)sender {
    if (!_datePickerShowing) {
        if (sender.tag == 0) {
            if (kRRTimeDrinkAM) {
                [self.datePickerView setDate:(NSDate *)kRRTimeDrinkAM withAM:YES];
            } else {
                [self.datePickerView setDate:[NSDate date] withAM:YES];
            }
        } else {
            if (kRRTimeDrinkPM) {
                [self.datePickerView setDate:(NSDate *)kRRTimeDrinkPM withAM:NO];
            } else {
                [self.datePickerView setDate:[NSDate date] withAM:NO];
            }
        }
        [self showDatePicker];
    }
    sender.selected =! sender.selected;
}

#pragma mark - getter
- (RRDatePicker *)datePickerView
{
    if (_datePickerView) {
        _datePickerView = nil;
    }
    _datePickerView = [[RRDatePicker alloc] init];
    _datePickerView.height = self.view.height;
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
    _dosageButton.selected = NO;
    _timeAMButton.selected = NO;
    _timePMButton.selected = NO;
    _timingbutton.selected = NO;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _datePickerView.y =  self.view.height;
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - overlay view delegate

- (void)didTouchesToOverlayView
{
    [_userTextfield resignFirstResponder];
    self.overlayView.hidden = YES;
}

#pragma mark - date picker delegate

- (void)clickDoneBtnWithDate:(NSDate *)date
{
    if (_timeAMButton.selected) {
        _timeAMLabel.text = [NSString stringWithFormat:@"%@",[_datePickerView.datePicker.date stringValueFormattedBy:@"HH:mm"]];
        [kRRUserDefaults setObject:_datePickerView.datePicker.date forKey:kRRTimeDrinkAMKey];
    } else {
        _timePMLabel.text = [NSString stringWithFormat:@"%@",[_datePickerView.datePicker.date stringValueFormattedBy:@"HH:mm"]];
        [kRRUserDefaults setObject:_datePickerView.datePicker.date forKey:kRRTimeDrinkPMKey];
    }
    [self hideDatePicker];
}

- (void)didTouchesScreen
{
    [self hideDatePicker];
}

- (void)didSelectedDosage:(NSString *)tile atIndex:(int)index
{
    [kRRUserDefaults setObject:tile forKey:kRRDosageNoteKey];
    [kRRUserDefaults setInteger:index forKey:kRRDosageNoteIndexKey];
    _dosageLabel.text = [NSString stringWithFormat:@"%@",kRRDosageNote];
    [self hideDatePicker];
    [self refreshFooterView];
}

- (void)didSelectedTiming:(NSString *)tile atIndex:(int)index
{
    [kRRUserDefaults setObject:tile forKey:kRRTimingNotificationKey];
    [kRRUserDefaults setInteger:index forKey:kRRTimingNotificationIndexKey];
    _timingLabel.text = [NSString stringWithFormat:@"%@",kRRTimingNotification];
    [self hideDatePicker];
    [self refreshFooterView];
}

#pragma mark - UITextViewDelegate and UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showOverlayView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _overlayView.hidden = YES;
    return YES;
}

- (void)textFieldDidChange:(NSNotification *)notification
{
    if ([notification.object isEqual:self.userTextfield]) {
        [kRRUserDefaults setObject:_userTextfield.text forKey:kRRUserNameKey];
    }
}

@end
