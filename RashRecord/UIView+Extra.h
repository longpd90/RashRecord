//
//  UIView+Extra.h
//  RashRecord
//
//  Created by LongPD on 4/25/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extra)

@property (nonatomic, getter=width, setter = setWidth:) CGFloat width;
@property (nonatomic, getter=height, setter = setHeight:) CGFloat height;
@property (nonatomic, getter=y, setter = setY:) CGFloat y;
@property (nonatomic, getter=x, setter = setX:) CGFloat x;

- (CGFloat) width;
- (void)setWidth:(CGFloat)width;
- (CGFloat) height;
- (void)setHeight:(CGFloat)height;
- (CGFloat) x;
- (void)setX:(CGFloat)x;
- (CGFloat) y;
- (void)setY:(CGFloat)y;

- (CGPoint) centerOfView;
- (CGFloat) bottomYPoint;
- (CGFloat) rightXPoint;
- (CGRect) zeroPositionFrame;

- (void)clearBackgroundColor;
+ (id)loadFromNibNamed:(NSString *)nibName;

@end
