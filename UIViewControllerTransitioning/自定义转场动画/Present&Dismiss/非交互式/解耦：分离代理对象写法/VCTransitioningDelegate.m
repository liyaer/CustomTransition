//
//  VCTransitioningDelegate.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/15.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "VCTransitioningDelegate.h"

@implementation VCTransitioningDelegate
{
   CustomTransitionAnimation *_customTransition;
}
-(instancetype)init
{
    if (self = [super init])
    {
        _customTransition = [[CustomTransitionAnimation alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

//present时的动画效果
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _customTransition.type = kPresent;
    return _customTransition;
}

//dismiss时的动画效果
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _customTransition.type = kDismiss;
    return _customTransition;
}

@end
