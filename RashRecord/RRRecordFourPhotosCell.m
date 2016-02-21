//
//  RRRecordPhotoCell.m
//  RashRecord
//
//  Created by LongPD on 4/23/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRRecordFourPhotosCell.h"

@implementation RRRecordFourPhotosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageViews = [NSArray arrayWithObjects:_leftHandImageView,_rightHandImageView,_leftLegImageView,_rightLegImageView, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (IBAction)showRecordButton:(id)sender
{
    _showRecordButton.selected =! _showRecordButton.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(toggleWithIndex:)]) {
        [self.delegate toggleWithIndex:self.tag];
    }
}

- (IBAction)showPhotoDetail:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showPhotoDetail:)]) {
        [self.delegate showPhotoDetail:[_imageURLs objectAtIndex:sender.tag]];
    }
}

- (void)setRashRecord:(RashRecord *)rashRecord leftHand:(BOOL)leftHand rightHand:(BOOL)rightHand leftLeg:(BOOL)leftLeg rightLeg:(BOOL)rightLeg
{
    _rashRecord = rashRecord;
    NSDate *today = [NSDate date];
    NSComparisonResult compareResult = [today compareDay:rashRecord.date];
    if (compareResult == NSOrderedSame) {
        [self.dateLabel setBackgroundColor:[UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1]];
        [self.weekDayLabel setBackgroundColor:[UIColor colorWithRed:51.0f/255 green:153.0f/255 blue:255.0/255 alpha:1]];

    } else {
        [self.dateLabel setBackgroundColor:[UIColor clearColor]];
        [self.weekDayLabel setBackgroundColor:[UIColor clearColor]];
    }
    int dayValue = [[rashRecord.date stringValueFormattedBy:@"dd"] intValue];
    int monthValue = [[rashRecord.date stringValueFormattedBy:@"MM"] intValue];
    self.dateLabel.text = [NSString stringWithFormat:@"%d/%d",monthValue,dayValue];
    self.weekDayLabel.text = [[rashRecord.date stringValueFormattedBy:@"EEE"] capitalizedString];
    
    int index = 0;
    for (int i = 0 ; i < _imageViews.count; i ++) {
        UIImageView *imageView = [_imageViews objectAtIndex:index];
        imageView.image = nil;
    }
    _imageURLs = [[NSMutableArray alloc] init];
    if (leftHand) {
        [self setImageFromAssetURLAtIndex:index withAssetURL:rashRecord.pt_left_hand];
        [_imageURLs addObject:rashRecord.pt_left_hand];
        index ++;
    }
    if (rightHand) {
        [self setImageFromAssetURLAtIndex:index withAssetURL:rashRecord.pt_right_hand];
        [_imageURLs addObject:rashRecord.pt_right_hand];
        index ++;
    }
    if (leftLeg) {
        [self setImageFromAssetURLAtIndex:index withAssetURL:rashRecord.pt_left_leg];
        [_imageURLs addObject:rashRecord.pt_left_leg];
        index ++;
    }
    if (rightLeg) {
        [self setImageFromAssetURLAtIndex:index withAssetURL:rashRecord.pt_right_leg];
        [_imageURLs addObject:rashRecord.pt_right_leg];
    }
}

- (void)setImageFromAssetURLAtIndex:(int )index withAssetURL:(NSString *)assetURL
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library assetForURL:[NSURL URLWithString:assetURL] resultBlock:^(ALAsset *asset)
     {
         UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
         UIImageView *imageView = [_imageViews objectAtIndex:index];
         imageView.image = copyOfOriginalImage;
         
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----");
     }];
}

@end
