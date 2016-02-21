//
//  RRContentHelpTableViewCell.h
//  RashRecord
//
//  Created by LongPD on 5/24/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extra.h"

@interface RRContentHelpTableViewCell : UITableViewCell
@property (strong, nonatomic) NSString *contentHelp;
@property (weak, nonatomic) IBOutlet UILabel *contentHelpLabel;

@end
