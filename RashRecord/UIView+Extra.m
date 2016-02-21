//
//  UIView+Extra.m
//  RashRecord
//
//  Created by LongPD on 4/25/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)

CGRect CGRectWithY(CGRect rect, CGFloat y)
{
	CGRect newRect = rect;
	newRect.origin.y = y;
	return newRect;
}

CGRect CGRectWithX(CGRect rect, CGFloat x)
{
	CGRect newRect = rect;
	newRect.origin.x = x;
	return newRect;
}

CGRect CGRectWithWidth(CGRect rect, CGFloat width)
{
	CGRect newRect = rect;
	newRect.size.width = width;
	return newRect;
}

CGRect CGRectWithHeight(CGRect rect, CGFloat height)
{
	CGRect newRect = rect;
	newRect.size.height	= height;
	return newRect;
}

CGRect CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size)
{
	return CGRectMake(x, y, size.width, size.height);
}

- (void)rasterizeLayer
{
	self.layer.shouldRasterize = YES;
	self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGPoint)centerOfView
{
	return CGPointMake(roundf(self.width / 2), roundf(self.height / 2));
}

- (CGFloat) width
{
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
	self.frame = CGRectWithWidth(self.frame, width);
}

- (CGFloat) height
{
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
	self.frame = CGRectWithHeight(self.frame, height);
}

- (CGFloat) x
{
	return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
	self.frame = CGRectWithX(self.frame, x);
}

- (CGFloat) y
{
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
	self.frame = CGRectWithY(self.frame, y);
}

- (CGFloat)bottomYPoint
{
	return self.y + self.height;
}

- (CGRect)zeroPositionFrame
{
	return CGRectMakeWithSize(0, 0, self.frame.size);
}

- (void)clearBackgroundColor
{
	self.backgroundColor = [UIColor clearColor];
}

- (CGFloat)rightXPoint
{
	return self.x + self.width;
}


+ (id)loadFromNibNamed:(NSString *)nibName
{
	if (![[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"]) {
        nibName = [nibName stringByAppendingString:@"_iPhone"];
	}
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	return [nib objectAtIndex:0];
}

@end
