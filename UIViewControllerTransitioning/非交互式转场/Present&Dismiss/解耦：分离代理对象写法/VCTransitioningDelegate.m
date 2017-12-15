//
//  VCTransitioningDelegate.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/15.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "VCTransitioningDelegate.h"

@implementation VCTransitioningDelegate

-(instancetype)init
{
    if (self = [super init])
    {
        self.customTransition = [[UnInteractiveCustomTransition alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

//present时的动画效果
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.customTransition.type = kPresent;
    return self.customTransition;
}

//dismiss时的动画效果
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.customTransition.type = kDismiss;
    return self.customTransition;
}

@end
