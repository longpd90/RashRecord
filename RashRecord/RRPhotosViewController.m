//
//  RRPhotosViewController.m
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRPhotosViewController.h"
#import "RRRecordFourPhotosCell.h"
#import "RRExpandRecordCell.h"

#define COLLAPSED_CELL_HEIGHT 65
#define EXPANDED_CELL_HEIGHT 225
#define NoCellExpand -1

@interface RRPhotosViewController ()<RRRecordPhotoCellDelegate>
@property (nonatomic)  CGFloat collapsedCellHeight;
@property NSInteger currentExpandedCell;
@property NSInteger currentNumberOfCell;
@property BOOL leftHandShowing;
@property BOOL rightHandShowing;
@property BOOL leftLegShowing;
@property BOOL rightLegShowing;
@property (strong, nonatomic) NSMutableArray *allRashRecords;
@property (strong, nonatomic) NSMutableArray *rashRecords;
@property (nonatomic, strong) RRPhotoBrowserView *photoBrowserView;

@end

@implementation RRPhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _leftHandShowing = YES;
    _rightHandShowing = YES;
    _leftLegShowing = YES;
    _rightLegShowing = YES;
    [self initInterface];
    [self initTableFooterView];
    self.tableViewMode = RRTableViewModeFourPhoto;

}

- (void)viewDidAppear:(BOOL)animated
{
    [self getData];
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private 

- (void)initInterface
{
    _leftHandButton.layer.borderColor=[[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]CGColor];
    _leftHandButton.layer.borderWidth= 1.0f;
    _rightHandButton.layer.borderColor=[[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]CGColor];
    _rightHandButton.layer.borderWidth= 1.0f;
    _leftLegButton.layer.borderColor=[[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]CGColor];
    _leftLegButton.layer.borderWidth= 1.0f;
    _rightLegButton.layer.borderColor=[[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]CGColor];
    _rightLegButton.layer.borderWidth= 1.0f;
}

- (void)initTableFooterView
{
    self.loadingMoreContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 46)];
	[self.loadingMoreContentView clearBackgroundColor];
	UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityView.color = [UIColor blackColor];
	activityView.center = self.loadingMoreContentView.centerOfView;
	[activityView startAnimating];
	[self.loadingMoreContentView addSubview:activityView];
    self.tableViewState = RRTableViewStateNormal;
}

- (void)setTableViewState:(RRTableViewViewState)tableViewState
{
	_tableViewState = tableViewState;
	switch (tableViewState) {
		case RRTableViewStateNormal:
		{
			self.photosTableView.tableFooterView = nil;
			break;
		}
		case RRTableViewStateLoadingMoreContent:
		{
			self.photosTableView.tableFooterView = self.loadingMoreContentView;
			break;
		}
		
		default:
			break;
	}
}

- (void)willShowLastCells
{
	if (self.currentNumberOfCell < self.rashRecords.count) {
		self.tableViewState = RRTableViewStateLoadingMoreContent;
        [self loadMoreData];
	} else {
        self.tableViewState = RRTableViewStateNormal;
    }
}

- (void)loadMoreData
{
    _currentNumberOfCell = _currentNumberOfCell + MIN(10,( _rashRecords.count - _currentNumberOfCell));
    [self.photosTableView reloadData];
}

- (CGFloat)collapsedCellHeight
{
    switch (self.tableViewMode) {
        case RRTableViewModeOnePhoto:
            return 120;
            break;
        case RRTableViewModeTwoPhoto:
            return 120;
            break;
        case RRTableViewModeThreePhoto:
            return 65;
            break;
        case RRTableViewModeFourPhoto:
            return 65;
            break;
            
        default:
            return 65;
            break;
    }
}

#pragma mark - progress Data

- (void)getData
{
    _allRashRecords = [[RRDatabaseHelper shareMyInstance] getRecordObjectsFromDatabase:kRRRashRecordTableName withRow:nil andKey:@"date" andSortAscending:NO];
    [self checkImageRecord];
    _rashRecords = _allRashRecords;
    _currentExpandedCell = NoCellExpand;
    _currentNumberOfCell = MIN(10, _rashRecords.count);
    [self.photosTableView reloadData];
}

- (void)checkImageRecord
{
    for (int i = 0; i <  _allRashRecords.count ; i ++) {
        RashRecord *rashRecord = [_allRashRecords objectAtIndex:i];
        
        if (![self checkImageURL:rashRecord]) {
            [_allRashRecords removeObjectAtIndex:i];
            i = i -1;
        }
    }
}

- (void)refreshView
{
    _rashRecords = [NSMutableArray arrayWithArray:_allRashRecords];
    
    if (self.tableViewMode == RRTableViewModeFourPhoto) {
        self.currentExpandedCell = NoCellExpand;
          _currentNumberOfCell = MIN(10, _rashRecords.count);
        [self.photosTableView reloadData];
        return;
    }
    for (int i = 0; i <  _rashRecords.count ; i ++) {
        RashRecord *rashRecord = [_rashRecords objectAtIndex:i];
        if (![self checkImageURL:rashRecord]) {
            [_rashRecords removeObjectAtIndex:i];
            i = i -1;
        }
    }
    self.currentExpandedCell = NoCellExpand;
    _currentNumberOfCell = MIN(10, _rashRecords.count);
    [self.photosTableView reloadData];
}

- (BOOL)checkImageURL:(RashRecord *)rashRecord
{
    if ((_leftHandShowing && rashRecord.pt_left_hand.length > 0) ||
        (_rightHandShowing && rashRecord.pt_right_hand.length > 0) ||
        (_leftLegShowing && rashRecord.pt_left_leg.length > 0) ||
        (_rightLegShowing && rashRecord.pt_right_leg.length > 0) )
    {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Record Cell delegate

- (void)toggleWithIndex:(NSInteger )index
{
    if (_currentExpandedCell == index + 1) {
        _currentExpandedCell = NoCellExpand;
        NSArray *currentIndexPath = [[NSArray alloc]initWithObjects:[NSIndexPath indexPathForItem:index + 1 inSection:0], nil];
        [self collapseCellsAtIndexPaths:currentIndexPath];
    } else {
        if (_currentExpandedCell == NoCellExpand) {
            _currentExpandedCell = index + 1;
            [self expandCellsAtIndexPaths:[[NSArray alloc] initWithObjects:[NSIndexPath indexPathForItem:_currentExpandedCell inSection:0], nil]];
        } else {
            NSArray *currentIndexPath = [[NSArray alloc]initWithObjects:[NSIndexPath indexPathForItem:_currentExpandedCell inSection:0], nil];
            [self collapseCellsAtIndexPaths:currentIndexPath];
            _currentExpandedCell = index + 1;
            [self expandCellsAtIndexPaths:[[NSArray alloc]initWithObjects:[NSIndexPath indexPathForItem:_currentExpandedCell inSection:0], nil]];
        }
    }
}

- (void)showPhotoDetail:(NSString *)imageURL
{
    [self.photoBrowserView showPhotoBrowserWithImageURL:imageURL];
}

#pragma mark - toggle expand record

- (void)collapseCellsAtIndexPaths:(NSArray*)indexPaths {
    _currentNumberOfCell--;
    [_photosTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    RRRecordFourPhotosCell *recordCell = (RRRecordFourPhotosCell *)[self.photosTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0]];
    recordCell.showRecordButton.selected = NO;
}

- (void)expandCellsAtIndexPaths:(NSArray*)indexPaths{
    _currentNumberOfCell++;
    [_photosTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.photosTableView scrollToRowAtIndexPath:[indexPaths objectAtIndex:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
    static NSString *expandedRecordCellIdentifier = @"RRExpandRecordCell";
    if (indexPath.row == _currentExpandedCell) {
        RRExpandRecordCell *expandRcordCell = (RRExpandRecordCell *)[tableView dequeueReusableCellWithIdentifier:expandedRecordCellIdentifier];
        if (expandRcordCell == nil) {
            expandRcordCell = [UIView loadFromNibNamed:expandedRecordCellIdentifier];
        }
        expandRcordCell.rashRecord = [_rashRecords objectAtIndex:indexPath.row - 1];
        return expandRcordCell;
        
    } else {
        RRRecordFourPhotosCell *recordCell;
        switch (self.tableViewMode) {
            case RRTableViewModeOnePhoto:{
                static NSString *recordCellIndentifier = @"RRRecoreOnePhotoCell";
                recordCell = (RRRecordFourPhotosCell *)[tableView dequeueReusableCellWithIdentifier:recordCellIndentifier];
                if (!recordCell) {
                    recordCell = [UIView loadFromNibNamed:recordCellIndentifier];
                    recordCell.delegate = self;
                }
                break;
            }
            case RRTableViewModeTwoPhoto:{
                static NSString *recordCellIndentifier = @"RRRecordTwoPhotoCell";

                recordCell = (RRRecordFourPhotosCell *)[tableView dequeueReusableCellWithIdentifier:recordCellIndentifier];
                if (!recordCell) {
                    recordCell = [UIView loadFromNibNamed:recordCellIndentifier];
                    recordCell.delegate = self;
                }
                break;
            }
            case RRTableViewModeThreePhoto:{
                static NSString *recordCellIndentifier = @"RRRecordThreePhotoCell";
                 recordCell = (RRRecordFourPhotosCell *)[tableView dequeueReusableCellWithIdentifier:recordCellIndentifier];
                if (!recordCell) {
                    recordCell = [UIView loadFromNibNamed:recordCellIndentifier];
                    recordCell.delegate = self;
                }
                break;
            }
            case RRTableViewModeFourPhoto:{
                static NSString *recordCellIndentifier = @"RRRecordFourPhotosCell";
                 recordCell = (RRRecordFourPhotosCell *)[tableView dequeueReusableCellWithIdentifier:recordCellIndentifier];
                if (!recordCell) {
                    recordCell = [UIView loadFromNibNamed:recordCellIndentifier];
                    recordCell.delegate = self;
                }
                break;
            }
                
            default:
                return nil;
                break;
        }
        
        if (_currentExpandedCell != NoCellExpand) {
            recordCell.showRecordButton.selected = NO;
            if (indexPath.row < _currentExpandedCell) {
                if (indexPath.row == _currentExpandedCell - 1) {
                    recordCell.showRecordButton.selected = YES;
                }
                recordCell.tag = indexPath.row;
            }else {
                recordCell.tag = indexPath.row  - 1;
            }
        }
        else {
            recordCell.showRecordButton.selected = NO;
            recordCell.tag = indexPath.row;
        }
        [recordCell setRashRecord:[_rashRecords objectAtIndex:recordCell.tag] leftHand:_leftHandShowing rightHand:_rightHandShowing leftLeg:_leftLegShowing rightLeg:_rightLegShowing ];
        
        return recordCell;
        
    }
    return  nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == _currentExpandedCell ? EXPANDED_CELL_HEIGHT : [self collapsedCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.photosTableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        [self willShowLastCells];
    }
}

#pragma mark - Getters

- (RRPhotoBrowserView *)photoBrowserView
{
	if (!_photoBrowserView) {
        _photoBrowserView = [UIView loadFromNibNamed:@"RRPhotoBrowserView"];
	}
	return _photoBrowserView;
}

#pragma mark - action

- (IBAction)changeSource:(UIButton *)button {
    
    if (button.selected) {
        if (_leftHandButton.selected + _rightHandButton.selected + _leftLegButton.selected + _rightLegButton.selected < 2) {
            return;
        }
        button.backgroundColor = [UIColor whiteColor];

    } else {
        button.backgroundColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    }
    
    button.selected =! button.selected;
    
    _leftHandShowing = _leftHandButton.selected;
    _rightHandShowing = _rightHandButton.selected;
    _leftLegShowing = _leftLegButton.selected;
    _rightLegShowing = _rightLegButton.selected;

    int tableViewMode = _leftHandButton.selected + _rightHandButton.selected + _leftLegButton.selected + _rightLegButton.selected;

    switch (tableViewMode) {
        case RRTableViewModeOnePhoto:
            self.tableViewMode = RRTableViewModeOnePhoto;
            break;
        case RRTableViewModeTwoPhoto:
            self.tableViewMode = RRTableViewModeTwoPhoto;
            break;
        case RRTableViewModeThreePhoto:
            self.tableViewMode = RRTableViewModeThreePhoto;
            break;
        case RRTableViewModeFourPhoto:
            self.tableViewMode = RRTableViewModeFourPhoto;
            break;
        default:
            break;
    }
    [self refreshView];
}
@end
