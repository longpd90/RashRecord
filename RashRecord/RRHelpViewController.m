//
//  RRHelp[ViewController.m
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRHelpViewController.h"
#import "RRTileHelpTableViewCell.h"
#import "RRContentHelpTableViewCell.h"

@interface RRHelpViewController ()<RRTileHelpTableViewCellDelegate>
@property NSInteger currentNumberOfCell;
@property (strong, nonatomic) NSArray *tileHelps;
@property (strong, nonatomic) NSArray *contentHelps;

@end

@implementation RRHelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initContentHelp];
    _currentNumberOfCell = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initContentHelp
{
    NSString *tileHelp = @"免責事項";
    NSString *tileHelp1 = @"項目１";
    NSString *tileHelp2 = @"項目 2";
    NSString *tileHelp3 = @"項目 3";
    NSString *tileHelp4 = @"項目 4";
    NSString *tileHelp5 = @"項目 5";
    _tileHelps = [NSArray arrayWithObjects:tileHelp,tileHelp1,tileHelp2,tileHelp3,tileHelp4,tileHelp5,nil];
    
    NSString *contentHelp = @"ここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入る。/nここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入る";
    NSString *contentHelp1 = @"ここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入る。";
    NSString *contentHelp2 = @"ここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入るここに本文が入る。/nここに本文が入るここに本文が入るここに本文が入るここに本文が入る。";
    NSString *contentHelp3 = @"項目 3";
    NSString *contentHelp4 = @"項目 4";
    NSString *contentHelp5 = @"項目 5";
    _contentHelps = [NSArray arrayWithObjects:contentHelp,contentHelp1,contentHelp2,contentHelp3,contentHelp4,contentHelp4,contentHelp5, nil];
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentNumberOfCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tileHelpCellIdentifier = @"RRTileHelpTableViewCell";
    RRTileHelpTableViewCell *tileHelpCell = (RRTileHelpTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tileHelpCellIdentifier];
    if (!tileHelpCell) {
        tileHelpCell = [UIView loadFromNibNamed:tileHelpCellIdentifier];
    }
    tileHelpCell.tile = [_tileHelps objectAtIndex:indexPath.row];
    return tileHelpCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
//    return indexPath.row == _currentExpandedCell ? EXPANDED_CELL_HEIGHT : [self collapsedCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - toggle expand help

- (void)collapseCellsAtIndexPaths:(NSArray*)indexPaths {
    _currentNumberOfCell--;
    [_helpTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)expandCellsAtIndexPaths:(NSArray*)indexPaths{
    _currentNumberOfCell++;
    [_helpTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [_helpTableView scrollToRowAtIndexPath:[indexPaths objectAtIndex:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

# pragma mark - tile help cell delegate

- (void)didSelectCell:(RRTileHelpTableViewCell *)titleHelpCell withSelect:(BOOL)selected
{
    NSIndexPath *indexPath = [_helpTableView indexPathForCell:titleHelpCell];
    NSArray *currentIndexPath = [[NSArray alloc]initWithObjects:[NSIndexPath indexPathForItem:indexPath.row + 1 inSection:0], nil];
    if (!selected) {
        [self expandCellsAtIndexPaths:currentIndexPath];
    } else {
        [self collapseCellsAtIndexPaths:currentIndexPath];
    }
}

@end
