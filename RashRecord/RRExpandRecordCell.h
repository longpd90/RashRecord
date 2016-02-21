//
//  RRExpandRecordCell.h
//  RashRecord
//
//  Created by LongPD on 4/25/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RashRecord.h"
#import "NSDate+Extra.h"
#import "UIView+Extra.h"

@interface RRExpandRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusSickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *medicineAMFirstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *medicineAMSecondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *medicinePMFirstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *medicinePMSecondImageView;
@property (weak, nonatomic) IBOutlet UILabel *seekMedicalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *seekMedicalAddLabel;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (strong, nonatomic) RashRecord *rashRecord;

@end
