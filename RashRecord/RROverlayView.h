//
//  PDOverlayView.h
//  Pashadelic
//
//  Created by TungNT2 on 8/7/13.
//
//

#import <UIKit/UIKit.h>

@protocol RROverlayViewDelegate <NSObject>
- (void)didTouchesToOverlayView;
@end

@interface RROverlayView : UIView
@property (strong, nonatomic)id<RROverlayViewDelegate>delegate;

@end
