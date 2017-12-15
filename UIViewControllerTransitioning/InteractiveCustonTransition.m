//
//  InteractiveCustonTransition.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractiveCustonTransition.h"

@implementation InteractiveCustonTransition

//动画时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

//动画切换过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    /*
     fromVC和toVC都是相对而言的，比如A presentTo B，fromVC=A,toVC=B；B dismissTo A，fromVC=B,toVC=A
     fromVC永远都是当前正在显示的VC,toVC永远都是即将显示的那个VC
     */
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /*
     系统会自动添加当前正在显示的fromVC.view,因此我们只需要添加toVC.view即可，但是最后别忘了将fromVC.view移到最前面
     */
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] bringSubviewToFront:fromVC.view];
    
    //动画前的一些处理
    CGRect fromVCFrame = [transitionContext initialFrameForViewController:fromVC];
    CATransform3D transform = CATransform3DIdentity;
    fromVC.view.layer.anchorPoint = CGPointMake(0.0, 0.5);
    fromVC.view.frame = fromVCFrame;//改变了anchorPoint，为保持原本frame不变，重设一下即可
//    toVC.view.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         if (self.custom == dismiss)
         {
             fromVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
         }
         fromVC.view.alpha = 0.0;
//         toVC.view.alpha = 1.0;
     }
     completion:^(BOOL finished)
     {
         //转场动画结束，恢复专场前的状态
         if (self.custom == dismiss)
         {
             fromVC.view.layer.transform = transform;
         }
         fromVC.view.alpha = 1.0;
         fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
         fromVC.view.frame = fromVCFrame;//改变了anchorPoint，为保持原本frame不变，重设一下即可
         
         //用户中途取消转场的处理
         if ([transitionContext transitionWasCancelled])
         {
             [toVC.view removeFromSuperview];
             NSLog(@"cancel");
         }
         else
         {
             [fromVC.view removeFromSuperview];
             NSLog(@"UNUNUNcancel");
         }
         
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}


@end
