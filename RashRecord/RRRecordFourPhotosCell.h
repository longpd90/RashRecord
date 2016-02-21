//
//  RRRecordPhotoCell.h
//  RashRecord
//
//  Created by LongPD on 4/23/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RashRecord.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSDate+Extra.h"

@protocol RRRecordPhotoCellDelegate <NSObject>

@optional

- (void)toggleWithIndex:(NSInteger )index;
- (void)showPhotoDetail:(NSString *)imageURL;

@end

@interface RRRecordFourPhotosCell : UITableViewCell
@property (weak, nonatomic) id<RRRecordPhotoCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftHandImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftHandButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightHandImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightHandButton;
@property (weak, nonatomic) IBOutlet UIImageView *leftLegImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftLegButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightLegImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightLegButton;
@property (weak, nonatomic) IBOutlet UIButton *showRecordButton;
@property (strong, nonatomic) RashRecord *rashRecord;
@property (strong, nonatomic) NSArray *imageViews;
@property (strong, nonatomic) NSMutableArray *imageURLs;

- (IBAction)showRecordButton:(id)sender;
- (IBAction)showPhotoDetail:(UIButton *)sender;
- (void)setRashRecord:(RashRecord *)rashRecord leftHand:(BOOL)leftHand rightHand:(BOOL)rightHand leftLeg:(BOOL)leftLeg rightLeg:(BOOL)rightLeg;

@end
