//
//  RRViewController.h
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRViewController.h"

extern NSString *const MHCustomTabBarControllerViewControllerChangedNotification;
extern NSString *const MHCustomTabBarControllerViewControllerAlreadyVisibleNotification;

@interface RRMainViewController : RRViewController
@property (weak,nonatomic) UIViewController *destinationViewController;
@property (strong, nonatomic) NSString *destinationIdentifier;
@property (strong, nonatomic) UIViewController *oldViewController;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end
