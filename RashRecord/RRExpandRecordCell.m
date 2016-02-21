//
//  RRExpandRecordCell.m
//  RashRecord
//
//  Created by LongPD on 4/25/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRExpandRecordCell.h"

@implementation RRExpandRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.memoTextView.scrollsToTop = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setRashRecord:(RashRecord *)rashRecord
{
    _rashRecord = rashRecord;
    _statusSickLabel.text = rashRecord.title;
    int numAMPin = [rashRecord.num_am_pin intValue];
    _medicineAMFirstImageView.image = [UIImage imageNamed:(numAMPin > 0)?@"medicament-drinked.png":@"medicament-not-drink.png"];
    _medicineAMSecondImageView.image = [UIImage imageNamed:(numAMPin > 1)?@"medicament-drinked.png":@"medicament-not-drink.png"];

    int numPMPin = [rashRecord.num_pm_pin intValue];
    _medicinePMFirstImageView.image = [UIImage imageNamed:(numPMPin > 0)?@"medicament-drinked.png":@"medicament-not-drink.png"];
    _medicinePMSecondImageView.image = [UIImage imageNamed:(numPMPin > 1)?@"medicament-drinked.png":@"medicament-not-drink.png"];
    
    _seekMedicalTimeLabel.text = [rashRecord.hos_time stringValueFormattedBy:@"HH:mm"];
    [_seekMedicalTimeLabel sizeToFit];
    _seekMedicalAddLabel.x = _seekMedicalTimeLabel.rightXPoint + 10;
    _seekMedicalAddLabel.text = rashRecord.hos_address;
    _memoTextView.text = rashRecord.des;
    
}
@end
