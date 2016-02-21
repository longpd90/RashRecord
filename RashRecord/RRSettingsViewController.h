//
//  RRSettingsViewController.h
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRViewController.h"
#import "RRDatePicker.h"
#import "RROverlayView.h"

@interface RRSettingsViewController : RRViewController<RRDatePickerrDelegate,RROverlayViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *userTextfield;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dosageAMSegment;
@property (weak, nonatomic) IBOutlet UIButton *dosageButton;
@property (weak, nonatomic) IBOutlet UILabel *dosageLabel;
@property (weak, nonatomic) IBOutlet UIView *dosageAMView;
@property (weak, nonatomic) IBOutlet UILabel *timeAMLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeAMButton;
@property (weak, nonatomic) IBOutlet UIView *dosagePMView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dosagePMSegment;
@property (weak, nonatomic) IBOutlet UILabel *timePMLabel;
@property (weak, nonatomic) IBOutlet UIButton *timePMButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *notificationSegment;
@property (weak, nonatomic) IBOutlet UIButton *timingbutton;
@property (weak, nonatomic) IBOutlet UIButton *linkToStoreButton;
@property (weak, nonatomic) IBOutlet UIButton *linkToSynchroButton;
@property (weak, nonatomic) IBOutlet UILabel *timingLabel;
@property (strong, nonatomic) RRDatePicker *datePickerView;
@property (strong, nonatomic) RROverlayView *overlayView;

@property (assign, nonatomic) BOOL datePickerShowing;

- (IBAction)dosageButtonSelected:(UIButton *)sender;
- (IBAction)timingNotification:(UIButton *)sender;
- (IBAction)selectDate:(UIButton *)sender;

@end
