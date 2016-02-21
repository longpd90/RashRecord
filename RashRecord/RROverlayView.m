//
//  PDOverlayView.m
//  Pashadelic
//
//  Created by TungNT2 on 8/7/13.
//
//

#import "RROverlayView.h"

@implementation RROverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTouchesToOverlayView)]){
        [self.delegate didTouchesToOverlayView];
    }
}

@end
