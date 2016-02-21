//
//  RRContentHelpTableViewCell.m
//  RashRecord
//
//  Created by LongPD on 5/24/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRContentHelpTableViewCell.h"

@implementation RRContentHelpTableViewCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setContentHelp:(NSString *)contentHelp
{
    _contentHelp = contentHelp;
    _contentHelpLabel.text = contentHelp;
    _contentHelpLabel.height = [self heightLabel];
}

- (CGFloat)heightLabel
{
    CGSize maximumLabelSize = CGSizeMake(_contentHelpLabel.width, FLT_MAX);
    
    CGSize expectedLabelSize = [_contentHelp sizeWithFont:_contentHelpLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_contentHelpLabel.lineBreakMode];
    
    return expectedLabelSize.height;
}

@end
