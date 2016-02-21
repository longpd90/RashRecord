//
//  RRTileHelpTableViewCell.h
//  RashRecord
//
//  Created by LongPD on 5/24/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRTileHelpTableViewCell;

@protocol RRTileHelpTableViewCellDelegate <NSObject>
- (void)didSelectCell:(RRTileHelpTableViewCell *)titleHelpCell withSelect:(BOOL)selected;
@end

@interface RRTileHelpTableViewCell : UITableViewCell
@property (weak, nonatomic) id<RRTileHelpTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *tileLabel;
@property (strong, nonatomic) NSString *tile;

- (IBAction)didSelectCell:(UIButton *)sender;

@end
