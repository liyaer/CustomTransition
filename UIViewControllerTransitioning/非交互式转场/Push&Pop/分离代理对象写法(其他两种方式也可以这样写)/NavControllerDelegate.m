//
//  NavControllerDelegate.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/12.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "NavControllerDelegate.h"
#import "UnInteractivePushVC.h"

@implementation NavControllerDelegate

-(instancetype)init
{
    if (self = [super init])
    {
        self.customTransition = [[UnInteractiveCustomTransition alloc] init];
    }
    return self;
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    /*
     *   这种方式不像present&dismiss，提供了两个代理方法可用于分别处理present和dismiss时的动画，但是我们可以用fromVC通过iskindofclass方法来区分当前是push或pop（亲测可用），从而指定不同的动画效果

         向下面这样写，push和pop时转场动画是一样的
     */
//    return [NSClassFromString(@"UnInteractiveCustomTransition") new];
    
    if ([fromVC isKindOfClass:[UnInteractivePushVC class]])
    {
        self.customTransition.type = kPush;
    }
    else
    {
        self.customTransition.type = kPop;
    }
    return self.customTransition;
}

@end
