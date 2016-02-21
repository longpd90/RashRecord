//
//  RRPhotoBrowerView.h
//  RashRecord
//
//  Created by LongPD on 5/1/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRPhotoBrowserZoomableView.h"


@interface RRPhotoBrowserZoomableView ()

@end

@implementation RRPhotoBrowserZoomableView

- (id)init
{
	self = [UIView loadFromNibNamed:@"RRPhotoBrowserZoomableView"];
	
	if (self) {
		[self initialize];
	}
	return self;
}

- (void)initialize
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.delegate = self;
    self.minimumZoomScale = 1.0f;
    self.maximumZoomScale = 5.0f;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(doubleTapped:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [self.imageView addGestureRecognizer:doubleTap];
}

#pragma mark - Public methods

- (void)setImage:(UIImage *)image
{
    if (!image) {
        self.imageView.image = image;
        return;
    }
    self.imageView.image = image;
    CGSize imageSize = image.size;
    float scaleValue = self.imageView.width / imageSize.width;
    float photoHeight = imageSize.height * scaleValue;
    
    self.imageView.height = photoHeight;
    self.imageView.center = self.center;
}

- (IBAction)didTouchesOutsideImage:(id)sender {
    if (self.zoomableDelegate && [self.zoomableDelegate respondsToSelector:@selector(didTouchesUpOutsideImage:)]) {
        [self.zoomableDelegate didTouchesUpOutsideImage:self];
    }
}

#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.zoomableDelegate respondsToSelector:@selector(didDoubleTapZoomableView:)]) {
        [self.zoomableDelegate didDoubleTapZoomableView:self];
    }
}

#pragma mark - Recognizer

- (void)doubleTapped:(UITapGestureRecognizer *)recognizer
{
    if (self.zoomScale > 1.0f) {
        [UIView animateWithDuration:0.35 animations:^{
            self.zoomScale = 1.0f;
        }];
    } else {
        [UIView animateWithDuration:0.35 animations:^{
            CGPoint point = [recognizer locationInView:self];
            [self zoomToRect:CGRectMake(point.x, point.y, 0, 0) animated:YES];
        }];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
