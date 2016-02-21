//
//  RRPhotoBrowerView.m
//  RashRecord
//
//  Created by LongPD on 5/1/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRPhotoBrowserView.h"

@interface RRPhotoBrowserView ()<RRPhotoBrowserZoomableViewDelegate,UIGestureRecognizerDelegate>
{
    CGPoint _startingPanPoint;
}
@property (nonatomic, strong) UIWindow *previousWindow;
@property (nonatomic, strong) UIWindow *currentWindow;
@property (nonatomic, assign, getter = isDisplayingDetailedView) BOOL displayingDetailedView;
@property (nonatomic, strong) RRPhotoBrowserZoomableView *zoomableView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation RRPhotoBrowserView

# pragma mark - show and hidden photo browser

- (void)showPhotoBrowserWithImageURL:(NSString *)imageURL
{
    if (imageURL.length <= 0) {
        return;
    }
    if (_photoShowing) {
        return;
    }
    [self.zoomableView setImage:nil];
    self.previousWindow = [[UIApplication sharedApplication] keyWindow];
    self.currentWindow = [[UIWindow alloc] initWithFrame:self.previousWindow.bounds];
    self.currentWindow.windowLevel = UIWindowLevelStatusBar;
    self.currentWindow.hidden = NO;
    self.currentWindow.backgroundColor = [UIColor clearColor];
    [self.currentWindow makeKeyAndVisible];
    self.frame = self.currentWindow.frame;
    [self.currentWindow addSubview:self];
    [self setupContentView];
    [self setImageAssetWithAssetURL:imageURL];

	[UIView animateWithDuration:0.25
					 animations:^(){
						 self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.];
					 }
					 completion:^(BOOL finished){
						 if (finished) {
							 self.userInteractionEnabled = YES;
							 self.displayingDetailedView = YES;
						 }
					 }];
    _photoShowing = YES;
}

- (void)showRecordPhotos:(RashRecord *)rashRecord
{
    _rashRecord = rashRecord;
    if (!rashRecord) {
        return;
    }
    if (_photoShowing) {
        return;
    }
    _leftHandImageView.image = nil;
    _rightHandImageView.image = nil;
    _leftLegImageView.image = nil;
    _rightLegImageView.image = nil;
    [self.zoomableView setImage:nil];
    
    self.previousWindow = [[UIApplication sharedApplication] keyWindow];
    self.currentWindow = [[UIWindow alloc] initWithFrame:self.previousWindow.bounds];
    self.currentWindow.windowLevel = UIWindowLevelStatusBar;
    self.currentWindow.hidden = NO;
    self.currentWindow.backgroundColor = [UIColor clearColor];
    [self.currentWindow makeKeyAndVisible];
    self.frame = self.currentWindow.frame;
    [self.currentWindow addSubview:self];
    [self addSubview:_photoRecordsView];
    _photoRecordsView.center = self.center;
    
    [self setImageAssetForImageView:_leftHandImageView withURL:rashRecord.pt_left_hand];
    [self setImageAssetForImageView:_rightHandImageView withURL:rashRecord.pt_right_hand];
    [self setImageAssetForImageView:_leftLegImageView withURL:rashRecord.pt_left_leg];
    [self setImageAssetForImageView:_rightLegImageView withURL:rashRecord.pt_right_leg];
	
	[UIView animateWithDuration:0.25
					 animations:^(){
						 self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.];
					 }
					 completion:^(BOOL finished){
						 if (finished) {
							 self.userInteractionEnabled = YES;
							 self.displayingDetailedView = YES;
						 }
					 }];
    _photoShowing = YES;
}

- (void)setImageAssetForImageView:(UIImageView *)imageView withURL:(NSString *)assetURL
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library assetForURL:[NSURL URLWithString:assetURL] resultBlock:^(ALAsset *asset)
     {
         UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
         if (!copyOfOriginalImage) {
             return ;
         }
         imageView.image =copyOfOriginalImage;
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----");
     }];
}

- (void)setImageAssetWithAssetURL:(NSString *)assetURL
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library assetForURL:[NSURL URLWithString:assetURL] resultBlock:^(ALAsset *asset)
     {
         UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
         if (!copyOfOriginalImage) {
             return ;
         }
         [self setImage:copyOfOriginalImage];
         
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----");
     }];
}

- (void)hideWithCompletion:( void (^) (BOOL finished) )completionBlock
{
	[UIView animateWithDuration:0.25
					 animations:^(){
						 self.backgroundColor = [UIColor colorWithWhite:0. alpha:0.];
					 }
					 completion:^(BOOL finished){
						 self.userInteractionEnabled = NO;
                         [self removeFromSuperview];
                         [self.previousWindow makeKeyAndVisible];
                         self.currentWindow.hidden = YES;
                         self.currentWindow = nil;
						 if(completionBlock) {
							 completionBlock(finished);
						 }
					 }];
    _photoShowing = NO;
}

#pragma mark - action 

- (IBAction)showFullSizeImage:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self showFullSizeImageWithImageURL:_rashRecord.pt_left_hand];
            break;
        case 1:
            [self showFullSizeImageWithImageURL:_rashRecord.pt_right_hand];
            break;
        case 2:
            [self showFullSizeImageWithImageURL:_rashRecord.pt_left_leg];
            break;
        case 3:
            [self showFullSizeImageWithImageURL:_rashRecord.pt_right_leg];
            break;
        default:
            break;
    }
}

- (void)showFullSizeImageWithImageURL:(NSString *)imageURL
{
    if (imageURL.length <= 0) {
        return;
    }
    [self.zoomableView setImage:nil];
    [self setupContentView];
    [self setImageAssetWithAssetURL:imageURL];
	[UIView animateWithDuration:0.25
					 animations:^(){
						 self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.];
					 }
					 completion:^(BOOL finished){
						 if (finished) {
							 self.userInteractionEnabled = YES;
							 self.displayingDetailedView = YES;
						 }
					 }];
}

- (IBAction)closeButton:(id)sender {
    [self hideWithCompletion:^(BOOL finished) {
    
    }];
}

- (IBAction)deleteButton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"予告", "Message") message:NSLocalizedString(@"本当にこの写真を消しますか？", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"桶", "Oke") otherButtonTitles:NSLocalizedString(@"キャンセル", "Cancel"), nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self deleteAccept];
            break;
            
        default:
            break;
    }
}
- (void)deleteAccept
{
    [self hideWithCompletion:^(BOOL finished) {
        
    }];
    [self.delegate deleteButton];
}
#pragma mark - Getters

- (RRPhotoBrowserZoomableView *)zoomableView
{
	if (!_zoomableView) {
		_zoomableView = [[RRPhotoBrowserZoomableView alloc] init];
        _zoomableView.zoomableDelegate = self;
		
		[_zoomableView.imageView addGestureRecognizer:self.panGesture];
		CGPoint origin = _zoomableView.frame.origin;
        CGRect frame = _zoomableView.frame;
        frame.origin = origin;
        _zoomableView.frame = frame;
	}
	
	return _zoomableView;
}

- (UIPanGestureRecognizer *)panGesture
{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(p_imageViewPanned:)];
		_panGesture.delegate = self;
		_panGesture.maximumNumberOfTouches = 1;
		_panGesture.minimumNumberOfTouches = 1;
    }
    
    return _panGesture;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.panGesture) {
        UIView *imageView = [gestureRecognizer view];
        CGPoint translation = [gestureRecognizer translationInView:[imageView superview]];
        
        // -- Check for horizontal gesture
        if (fabsf(translation.x) > fabsf(translation.y)) {
            return YES;
        }
    }
	
    return NO;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
	[self.zoomableView setImage:image];
	
	[self setNeedsUpdateConstraints];
}

- (void)setDisplayingDetailedView:(BOOL)displayingDetailedView
{
	_displayingDetailedView = displayingDetailedView;
	
//	CGFloat newAlpha;
	
	if (_displayingDetailedView) {
//		[self.overlayView setOverlayVisible:YES animated:YES];
//		newAlpha = 1.;
	} else {
//		[self.overlayView setOverlayVisible:NO animated:YES];
//		newAlpha = 0.;
	}
	
	[UIView animateWithDuration:0.25
					 animations:^(){
//						 self.doneButton.alpha = newAlpha;
					 }];
}


#pragma mark - Public methods

- (void)resetZoomScale
{
	[self.zoomableView setZoomScale:1.];
}

#pragma mark - Private methods

- (void)setupContentView
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:self.zoomableView];
    [self bringSubviewToFront:self.closeButton];
    [self bringSubviewToFront:self.deleteButton];
    //self.deleteButton.hidden = YES;
}

- (void)p_imageViewPanned:(UIPanGestureRecognizer *)recognizer
{
    [self imageViewPanned:recognizer];
}

#pragma mark - Recognizers

- (void)imageViewPanned:(UIPanGestureRecognizer *)recognizer
{
	RRPhotoBrowserZoomableView *imageView = (RRPhotoBrowserZoomableView *)recognizer.view;
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		// -- Hide detailed view
		self.displayingDetailedView = NO;
		_startingPanPoint = imageView.center;
		return;
	}
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		// -- Check if user dismissed the view
		CGPoint endingPanPoint = [recognizer translationInView:self];
        
		UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
		CGPoint translatedPoint;
		
        if (UIDeviceOrientationIsPortrait(orientation) || orientation == UIDeviceOrientationFaceUp) {
            translatedPoint = CGPointMake(_startingPanPoint.x - endingPanPoint.y, _startingPanPoint.y);
        } else if (orientation == UIDeviceOrientationLandscapeLeft) {
            translatedPoint = CGPointMake(_startingPanPoint.x + endingPanPoint.x, _startingPanPoint.y);
        } else {
            translatedPoint = CGPointMake(_startingPanPoint.x - endingPanPoint.x, _startingPanPoint.y);
        }
		
		imageView.center = translatedPoint;
		int heightDifference = abs(floor(_startingPanPoint.x - translatedPoint.x));
		
		if (heightDifference <= 150) {
			// -- Back to original center
			[UIView animateWithDuration:0.25
							 animations:^(){
								 self.backgroundColor = [UIColor colorWithWhite:0. alpha:1.];
								 imageView.center = self->_startingPanPoint;
							 } completion:^(BOOL finished){
								 // -- show detailed view?
								 self.displayingDetailedView = YES;
							 }];
		} else {
			// -- Animate out!
			typeof(self) weakSelf __weak = self;
			[self hideWithCompletion:^(BOOL finished){
				typeof(weakSelf) strongSelf __strong = weakSelf;
				if (strongSelf) {
					imageView.center = strongSelf->_startingPanPoint;
				}
			}];
		}
	} else {
		CGPoint middlePanPoint = [recognizer translationInView:self];
		
		UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
		CGPoint translatedPoint;
		
        if (UIDeviceOrientationIsPortrait(orientation) || orientation == UIDeviceOrientationFaceUp) {
            translatedPoint = CGPointMake(_startingPanPoint.x - middlePanPoint.y, _startingPanPoint.y);
        } else if (orientation == UIDeviceOrientationLandscapeLeft) {
            translatedPoint = CGPointMake(_startingPanPoint.x + middlePanPoint.x, _startingPanPoint.y);
        } else {
            translatedPoint = CGPointMake(_startingPanPoint.x - middlePanPoint.x, _startingPanPoint.y);
        }
		
		imageView.center = translatedPoint;
		int heightDifference = abs(floor(_startingPanPoint.x - translatedPoint.x));
		CGFloat ratio = (_startingPanPoint.x - heightDifference)/_startingPanPoint.x;
		self.backgroundColor = [UIColor colorWithWhite:0. alpha:ratio];
	}
}

#pragma mark - AGPhotoBrowserZoomableViewDelegate

- (void)didDoubleTapZoomableView:(RRPhotoBrowserZoomableView *)zoomableView
{
    self.displayingDetailedView = !self.isDisplayingDetailedView;
}

- (void)didTouchesUpOutsideImage:(RRPhotoBrowserZoomableView *)zoomableView
{
    [self hideWithCompletion:^(BOOL finished) {
    }];
}

@end
