//
//  RRPhotoBrowerView.h
//  RashRecord
//
//  Created by LongPD on 5/1/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRPhotoBrowserZoomableView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RashRecord.h"
#import "UIView+Extra.h"

@class RRPhotoBrowserView;

@protocol RRPhotoBrowserViewDelegate <NSObject>

@optional

- (void)photoBrowser:(RRPhotoBrowserView *)photoBrowser;
- (void)didDoubleTapOnZoomableViewForCell:(RRPhotoBrowserView *)cell;
- (void)didPanOnZoomableViewForCell:(RRPhotoBrowserView *)cell withRecognizer:(UIPanGestureRecognizer *)recognizer;
- (void)deleteButton;

@end

@interface RRPhotoBrowserView : UIView<UIAlertViewDelegate>

@property (nonatomic, weak) id<RRPhotoBrowserViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *photoRecordsView;
@property (weak, nonatomic) IBOutlet UIImageView *leftHandImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightHandImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftLegImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightLegImageView;
@property (strong, nonatomic) RashRecord *rashRecord;
@property (assign, nonatomic) BOOL photoShowing;

- (void)showPhotoBrowserWithImageURL:(NSString *)imageURL;
- (void)hideWithCompletion:( void (^) (BOOL finished) )completionBlock;
- (IBAction)closeButton:(id)sender;
- (IBAction)deleteButton:(id)sender;
- (void)showRecordPhotos:(RashRecord *)rashRecord;
- (IBAction)showFullSizeImage:(UIButton *)sender;


@end
