//
//  TabBarVCDelegate.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/15.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "TabBarVCDelegate.h"

@implementation TabBarVCDelegate
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

#pragma mark - UITabBarControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    _customTransition.type = ktabBar;
    return _customTransition;
}


@end
