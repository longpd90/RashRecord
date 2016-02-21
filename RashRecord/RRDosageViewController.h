//
//  RRRemindViewController.h
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRViewController.h"

@interface RRDosageViewController : RRViewController

@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipeGesture;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipeGesture;
@property (nonatomic, strong) RRPhotoBrowserView *photoBrowserView;

@property (weak, nonatomic) IBOutlet UIView *dosageView;
@property (weak, nonatomic) IBOutlet UILabel *firstDay;
@property (weak, nonatomic) IBOutlet UILabel *secondDay;
@property (weak, nonatomic) IBOutlet UILabel *third;
@property (weak, nonatomic) IBOutlet UILabel *fourthDay;
@property (weak, nonatomic) IBOutlet UILabel *fifthDay;
@property (weak, nonatomic) IBOutlet UILabel *sixthDay;
@property (weak, nonatomic) IBOutlet UILabel *seventhDay;

@property (weak, nonatomic) IBOutlet UILabel *firstWeekday;
@property (weak, nonatomic) IBOutlet UILabel *secondWeekday;
@property (weak, nonatomic) IBOutlet UILabel *thirdWeekday;
@property (weak, nonatomic) IBOutlet UILabel *fourthWeekday;
@property (weak, nonatomic) IBOutlet UILabel *fifthWeekday;
@property (weak, nonatomic) IBOutlet UILabel *sixthWeekday;
@property (weak, nonatomic) IBOutlet UILabel *seventhWeekday;

@property (weak, nonatomic) IBOutlet UIButton *firstImage;
@property (weak, nonatomic) IBOutlet UIButton *secondImage;
@property (weak, nonatomic) IBOutlet UIButton *thirdImage;
@property (weak, nonatomic) IBOutlet UIButton *fourthImage;
@property (weak, nonatomic) IBOutlet UIButton *fifthImage;
@property (weak, nonatomic) IBOutlet UIButton *sixthImage;
@property (weak, nonatomic) IBOutlet UIButton *seventhImage;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1FirstDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2FirstDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3FirstDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4FirstDay;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1secondDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2secondDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3secondDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4secondDay;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1thirdDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2thirdDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3thirdDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4thirdDay;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1fourthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2fourthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3fourthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4fourthDay;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1fifthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2fifthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3fifthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4fifthDay;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1sixthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2sixthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3sixthDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4sixthDay;

@property (weak, nonatomic) IBOutlet UIImageView *medicine1seventhDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine2seventhDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine3seventhDay;
@property (weak, nonatomic) IBOutlet UIImageView *medicine4seventhDay;


@property (weak, nonatomic) IBOutlet UILabel *dosageThisTime;
@property (weak, nonatomic) IBOutlet UILabel *dosageThisMonth;
@property (weak, nonatomic) IBOutlet UILabel *allDosage;
@property (weak, nonatomic) IBOutlet UILabel *nameOfMonthLabel;

- (IBAction)showRecordPhotos:(UIButton *)sender;

@end
