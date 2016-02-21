//
//  PDARDatePicker.h
//  Pashadelic
//
//  Created by LongPD on 2/6/14.
//

#import <UIKit/UIKit.h>
#import "UIView+Extra.h"
#import "NSDate+Extra.h"
#import "RRGlobal.h"

@protocol RRDatePickerrDelegate <NSObject>
@optional
- (void)clickDoneBtnWithDate:(NSDate *)date;
- (void)didTouchesScreen;
- (void)didSelectedTiming:(NSString *)tile atIndex:(int)index;
- (void)didSelectedDosage:(NSString *)tile atIndex:(int)index;
@end

@interface RRDatePicker : UIView {
    
}

@property (strong, nonatomic) id<RRDatePickerrDelegate> delegate;

@property (assign, nonatomic) int dosageIndex;
@property (assign, nonatomic) int timingIndex;
@property (assign, nonatomic) BOOL hoursInAM;
@property (strong, nonatomic) NSDate *date;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIView *dosageView;
@property (weak, nonatomic) IBOutlet UIView *timingView;
@property (weak, nonatomic) IBOutlet UIButton *dosage1;
@property (weak, nonatomic) IBOutlet UIButton *dosage2;
@property (weak, nonatomic) IBOutlet UIButton *dosage3;
@property (weak, nonatomic) IBOutlet UIButton *dosage4;
@property (weak, nonatomic) IBOutlet UIButton *dosage5;
@property (weak, nonatomic) IBOutlet UIButton *dosage6;
@property (weak, nonatomic) IBOutlet UIButton *dosage7;
@property (weak, nonatomic) IBOutlet UIButton *dosage8;
@property (weak, nonatomic) IBOutlet UIButton *dosage9;

@property (weak, nonatomic) IBOutlet UIButton *timing1;
@property (weak, nonatomic) IBOutlet UIButton *timing2;
@property (weak, nonatomic) IBOutlet UIButton *timing3;
@property (weak, nonatomic) IBOutlet UIButton *timing4;
@property (weak, nonatomic) IBOutlet UIButton *timing5;
@property (weak, nonatomic) IBOutlet UIButton *timing6;

@property (strong, nonatomic) NSArray *dosagesButton;
@property (strong, nonatomic) NSArray *timingsButton;

- (id)init;
- (IBAction)btndoneTaped:(id)sender;
- (IBAction)btnCancelTaped:(id)sender;
- (IBAction)selectTiming:(UIButton *)sender;
- (IBAction)selectDosage:(UIButton *)sender;
- (void)setDate:(NSDate *)date withAM:(BOOL )AM;

@end
