//
//  RRTileHelpTableViewCell.m
//  RashRecord
//
//  Created by LongPD on 5/24/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRTileHelpTableViewCell.h"

@implementation RRTileHelpTableViewCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setTile:(NSString *)tile
{
    _tile = tile;
    _tileLabel.text = tile;
}

- (IBAction)didSelectCell:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCell:)]) {
        [self.delegate didSelectCell:self withSelect:sender.selected];
        sender.selected =! sender.selected;
    }
}
@end
