//
//  RRPhotosViewController.h
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRViewController.h"

typedef enum {
	RRTableViewStateNormal = 0,
	RRTableViewStateLoadingMoreContent
} RRTableViewViewState;

typedef enum {
	RRTableViewModeOnePhoto = 1,
	RRTableViewModeTwoPhoto,
    RRTableViewModeThreePhoto,
    RRTableViewModeFourPhoto
} RRTableViewMode;

@interface RRPhotosViewController : RRViewController
@property (weak, nonatomic) IBOutlet UIButton *leftHandButton;
@property (weak, nonatomic) IBOutlet UIButton *rightHandButton;
@property (weak, nonatomic) IBOutlet UIButton *leftLegButton;
@property (weak, nonatomic) IBOutlet UIButton *rightLegButton;
@property (weak, nonatomic) IBOutlet UITableView *photosTableView;
@property (strong, nonatomic) UIView *loadingMoreContentView;
@property (assign, nonatomic) RRTableViewViewState tableViewState;
@property (assign, nonatomic) RRTableViewMode tableViewMode;

- (IBAction)changeSource:(UIButton *)button;

@end
