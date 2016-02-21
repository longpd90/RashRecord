//
//  RRRecordDetailView.h
//  RashRecord
//
//  Created by LongPD on 4/25/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRDatabaseHelper.h"
@protocol RRRecordDetailDelegate <NSObject>
- (void)textFieldBeginEditting;
- (void)textFieldShouldBeginEditting;
- (void)clickIconMedicine;
@end
@interface RRRecordDetailView : UIView<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewData;
@property (weak, nonatomic) IBOutlet UIView *viewImage;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UIView *viewMedicine;
@property (weak, nonatomic) IBOutlet UIView *viewHospital;
@property (weak, nonatomic) IBOutlet UIView *viewMemo;
@property (nonatomic, strong) id<RRRecordDetailDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnCalendarDetail;
//Image
@property (weak, nonatomic) IBOutlet UIImageView *leftHandImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftHand;
@property (weak, nonatomic) IBOutlet UIImageView *rightHandImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblRightHand;
@property (weak, nonatomic) IBOutlet UIImageView *leftLegImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftLeg;
@property (weak, nonatomic) IBOutlet UIImageView *rightLegImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblRightLeg;

//textField
@property (weak, nonatomic) IBOutlet UITextView *textViewNote;
@property (weak, nonatomic) IBOutlet UITextField *txtDiseaseName;

@property (nonatomic) int numAM;
@property (nonatomic) int numPM;

//Button


@property (weak, nonatomic) IBOutlet UIButton *btnMedicineMorning1;
- (IBAction)btnMedicineMorning1Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMedicineMorning2;
- (IBAction)btnMedicineMorning2Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMedicineNight1;
- (IBAction)btnMedicineNight1Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMedicineNight2;
- (IBAction)btnMedicineNight2Clicked:(id)sender;
- (void)loadButtonMedicineMorning;
- (void)loadButtonMedicineNight;
//Examination
@property (weak, nonatomic) IBOutlet UITextField *txtExaminationTime;
@property (weak, nonatomic) IBOutlet UITextField *txtExaminationPlace;

@end
