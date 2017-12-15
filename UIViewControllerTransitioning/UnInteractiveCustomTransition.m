//
//  CustomPresentAnimation.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/11.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UnInteractiveCustomTransition.h"

@implementation UnInteractiveCustomTransition

//动画时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

//动画切换过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type)
    {
        case kPresent:
            [self presentTransitionAnimation:transitionContext];
            break;
        case kDismiss:
            [self dismissTransitionAnimation:transitionContext];
            break;
        case kPush:
            [self pushTransitionAnimation:transitionContext];
            break;
        case kPop:
            [self popTransitionAnimation:transitionContext];
            break;
        case ktabBar:
            [self tabBarTransitionAnimation:transitionContext];
            break;
            
        default:
            break;
    }
}

-(void)presentTransitionAnimation:(id)transitionContext
{
    /*
     fromVC和toVC都是相对而言的，比如A presentTo B，fromVC=A,toVC=B；B dismissTo A，fromVC=B,toVC=A
     fromVC永远都是当前正在显示的VC,toVC永远都是即将显示的那个VC
     */
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /*
     系统会自动添加当前正在显示的fromVC.view,因此我们只需要添加toVC.view即可，是否将fromVC.view移到最前面是根据动画需要设置的
     */
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] bringSubviewToFront:fromVC.view];
    
    
    //动画开始前的一些准备
    CGAffineTransform transform = CGAffineTransformIdentity;
    toVC.view.alpha = 0.0;
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromVC.view.transform = CGAffineTransformMakeScale(1.4, 1.4);
         fromVC.view.alpha = 0.0;
         toVC.view.alpha = 1.0;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.transform = transform;
         fromVC.view.alpha = 1.0;
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

-(void)dismissTransitionAnimation:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] bringSubviewToFront:fromVC.view];
    
    
    //动画开始前的一些准备
    CGAffineTransform transform = CGAffineTransformIdentity;
    toVC.view.alpha = 0.0;
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromVC.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
         fromVC.view.alpha = 0.0;
         toVC.view.alpha = 1.0;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.transform = transform;
         fromVC.view.alpha = 1.0;
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

-(void)pushTransitionAnimation:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] bringSubviewToFront:fromVC.view];
    
    
    //动画开始前的一些准备
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    CATransform3D transform = CATransform3DIdentity;
    fromVC.view.layer.anchorPoint = CGPointMake(0.0, 0.5);
    fromVC.view.frame = frame;
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.layer.transform = transform;
         fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
         fromVC.view.frame = frame;
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

-(void)popTransitionAnimation:(id)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    //这里因为动画需要，我们就不能将fromVC.view置前，否则会看不到动画
//    [[transitionContext containerView] bringSubviewToFront:fromVC.view];
    
    
    //动画开始前的一些准备
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    CATransform3D transform = CATransform3DIdentity;
    toVC.view.layer.anchorPoint = CGPointMake(0.0, 0.5);
    toVC.view.frame = frame;
    toVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         toVC.view.layer.transform = transform;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
         toVC.view.frame = frame;

         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

-(void)tabBarTransitionAnimation:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] bringSubviewToFront:fromVC.view];
    
    //这是一段测试代码，真实使用请移除
    [self test:transitionContext fromVC:fromVC toVC:toVC];
    
    //动画开始前的一些准备
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(frame, frame.size.width, 0);
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromVC.view.frame = CGRectOffset(frame, -frame.size.width, 0);
         toVC.view.frame = frame;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.frame = frame;
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

/*
    测试【initialFrameForViewController】和【finalFrameForViewController】对于fromVC和toVC的不同影响
    toVC使用final,fromVC使用initial获取正常的frame
    如果用不好或者不愿意记这些，直接使用fromVC.view.frame即可
 */
-(void)test:(id)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC
{
    CGRect frame = [transitionContext initialFrameForViewController:toVC];
    NSLog(@"%f",frame.size.width);
    frame = [transitionContext finalFrameForViewController:toVC];
    NSLog(@"%f",frame.size.width);
    frame = [transitionContext initialFrameForViewController:fromVC];
    NSLog(@"%f",frame.size.width);
    frame = [transitionContext finalFrameForViewController:fromVC];
    NSLog(@"%f",frame.size.width);
}


@end
