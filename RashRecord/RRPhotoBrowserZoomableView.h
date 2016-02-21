//
//  RRPhotoBrowerView.h
//  RashRecord
//
//  Created by LongPD on 5/1/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extra.h"

@class RRPhotoBrowserZoomableView;

@protocol RRPhotoBrowserZoomableViewDelegate <NSObject>

- (void)didDoubleTapZoomableView:(RRPhotoBrowserZoomableView *)zoomableView;
- (void)didTouchesUpOutsideImage:(RRPhotoBrowserZoomableView *)zoomableView;

@end


@interface RRPhotoBrowserZoomableView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<RRPhotoBrowserZoomableViewDelegate> zoomableDelegate;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (id)init;
- (void)setImage:(UIImage *)image;
- (IBAction)didTouchesOutsideImage:(id)sender;

@end
