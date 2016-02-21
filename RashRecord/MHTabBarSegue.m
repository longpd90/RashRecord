//
//  RRRecordPhotoCell.h
//  RashRecord
//
//  Created by LongPD on 4/23/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "MHTabBarSegue.h"
#import "RRMainViewController.h"

@implementation MHTabBarSegue
- (void) perform {
    RRMainViewController *tabBarViewController = (RRMainViewController *)self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *) tabBarViewController.destinationViewController;

    //remove old viewController
    if (tabBarViewController.oldViewController) {
        [tabBarViewController.oldViewController willMoveToParentViewController:nil];
        [tabBarViewController.oldViewController.view removeFromSuperview];
        [tabBarViewController.oldViewController removeFromParentViewController];
    }
    
    
    destinationViewController.view.frame = tabBarViewController.container.bounds;
    [tabBarViewController addChildViewController:destinationViewController];
    [tabBarViewController.container addSubview:destinationViewController.view];
    [destinationViewController didMoveToParentViewController:tabBarViewController];
}

@end
