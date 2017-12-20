//
//  CustomPresentAnimation.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/11.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "CustomTransitionAnimation.h"

/*
 *   总结：
        1，除了交互式tabBarVC,其他情况下都可以直接用view做动画，好处是系统帮助我们保证动画view的真实完整，但是动画完成需要恢复动画前的状态，以便于后续使用。
        2，交互式tabBarVC使用fromVC的截图，toVC的view做动画，最后添加toVC的截图遮盖bug效果
        3，使用截图做动画需要考虑截图时VC是否初始化完成，否则截图对象为nil,好处是动画玩无需恢复，直接移除即可
 */

@implementation CustomTransitionAnimation

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
            [self presentTransitionAnimation3:transitionContext];
            break;
            
        case kDismiss:
            [self dismissTransitionAnimation3:transitionContext];
            break;
            
        case kPush:
            [self pushTransitionAnimation3:transitionContext];
            break;
            
        case kPop:
            [self popTransitionAnimation3:transitionContext];
            break;
            
        case ktabBar:
            [self tabBarTransitionAnimation3:transitionContext];
            break;
            
        default:
            break;
    }
}

#pragma mark - 直接使用vc.view进行动画

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

//交互式时无论取消手势还是成功切换，都会出现抖动（下面会专门针对这一情况做优化处理）
-(void)tabBarTransitionAnimation:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    //这是一段测试代码，真实使用请移除
//    [self test:transitionContext fromVC:fromVC toVC:toVC];
    
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
         
         //向这个context报告切换是否完成
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
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

#pragma mark - 使用截图进行动画（比View做动画代价小，动画完成不用恢复原状，直接移除截图）

//fromVC用截图，toVC用view做动画
-(void)presentTransitionAnimation3:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    //动画开始前的一些准备
    fromVC.view.hidden = YES;
    
    UIView *fromViewSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromViewSnap.frame = fromVC.view.frame;
    [[transitionContext containerView] addSubview:fromViewSnap];
    
    toVC.view.alpha = 0.0;
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewSnap.transform = CGAffineTransformMakeScale(1.4, 1.4);
         fromViewSnap.alpha = 0.0;
         toVC.view.alpha = 1.0;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.hidden = NO;
         [fromViewSnap removeFromSuperview];

         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

//fromVC用截图，toVC用view做动画
-(void)dismissTransitionAnimation3:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    //动画开始前的一些准备
    fromVC.view.hidden = YES;
    
    UIView *fromViewSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromViewSnap.frame = fromVC.view.bounds;
    [[transitionContext containerView] addSubview:fromViewSnap];
    
    toVC.view.alpha = 0.0;
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewSnap.transform = CGAffineTransformMakeScale(0.8, 0.8);
         fromViewSnap.alpha = 0.0;
         toVC.view.alpha = 1.0;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.hidden = NO;
         [fromViewSnap removeFromSuperview];
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

//这里用了toVC的截图做动画，但是最好还是fromVC用截图，toVC用view做动画
-(void)pushTransitionAnimation3:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    //动画开始前的一些准备
    fromVC.view.hidden = YES;
    
    UIView *fromViewSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromViewSnap.frame = fromVC.view.bounds;
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    fromViewSnap.layer.anchorPoint = CGPointMake(0.0, 0.5);
    fromViewSnap.frame = frame;
    [[transitionContext containerView] addSubview:fromViewSnap];
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewSnap.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         fromVC.view.hidden = NO;
         [fromViewSnap removeFromSuperview];
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

//fromVC用截图，toVC用view做动画
-(void)popTransitionAnimation3:(id)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    //动画开始前的一些准备
    toVC.view.hidden = YES;
    
    UIView *toViewSnap = [toVC.view snapshotViewAfterScreenUpdates:NO];
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    toViewSnap.layer.anchorPoint = CGPointMake(0.0, 0.5);
    toViewSnap.frame = frame;
    toViewSnap.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    CATransform3D transform = CATransform3DIdentity;
    [[transitionContext containerView] addSubview:toViewSnap];
    
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         toViewSnap.layer.transform = transform;
     }
    completion:^(BOOL finished)
     {
         //还原动画前的状态
         toVC.view.hidden = NO;
         [toViewSnap removeFromSuperview];
         
         
         //非交互式转场直接写成YES也行，因为不存在NO的情况
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//向这个context报告切换是否完成
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

#warning 1，2，3中关于vc.view hidden部分代码写的初衷是因为使用截图做动画，那么vc.view在动画过程中就无关紧要了，隐藏掉便于查看测试效果，但是其实只要理清楚视图层级关系，根本无需隐藏。1中没注释是为了方便查看效果，如果注释掉，查看运行结果可能会误以为是满足要求的，实则不然，只是因为未隐藏vc.view的缘故，仔细观察的话，他的动画效果和我们设定的动画效果是不一样的，2，3直接不隐藏也无所谓。总之：解决方案就是3，至于是否隐藏主要看是否影响动画效果而定（上面四种写法也都是3的写法,只不过动画结束无需加截图遮盖，因为他们不会抖动,准确的说是2的写法）
/*
    fromVC和toVC全部用截图做动画
    因为tabBarVC的原因，首次点击切换或者手势切换时，子VC还未初始化加载完成，所以截图是黑屏，子VC被加载一次后，动画完美展现。
    首次黑屏，这个对交互式和非交互式都会产生黑屏的影响，弃用！
 */
-(void)tabBarTransitionAnimation1:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    //动画开始前的一些准备
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    
    UIView *fromViewSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromViewSnap.frame = frame;
    [[transitionContext containerView] addSubview:fromViewSnap];
    
    UIView *toViewSnap = [toVC.view snapshotViewAfterScreenUpdates:NO];
    toViewSnap.frame = CGRectOffset(frame, frame.size.width, 0);
    [[transitionContext containerView] addSubview:toViewSnap];
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewSnap.frame = CGRectOffset(frame, -frame.size.width, 0);
         toViewSnap.frame = frame;
     }
    completion:^(BOOL finished)
     {
         fromVC.view.hidden = NO;
         toVC.view.hidden = NO;
         [fromViewSnap removeFromSuperview];
         [toViewSnap removeFromSuperview];
         
         //向这个context报告切换是否完成
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

/*
    fromVC用截图，toVC用view做动画
    对1进行思考后，既然toVC首次截图是黑屏，那么我们干脆直接对于toVC使用view做动画
    交互式中途取消动画完美，但是成功切换时，还是抖动；非交互式正常，还是弃用！
 */
-(void)tabBarTransitionAnimation2:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    //动画开始前的一些准备
//    fromVC.view.hidden = YES;
    
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    
    UIView *fromViewSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromViewSnap.frame = frame;
    [[transitionContext containerView] addSubview:fromViewSnap];
    
    toVC.view.frame = CGRectOffset(frame, frame.size.width, 0);
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewSnap.frame = CGRectOffset(frame, -frame.size.width, 0);
         toVC.view.frame = frame;
     }
    completion:^(BOOL finished)
     {
//         fromVC.view.hidden = NO;
         [fromViewSnap removeFromSuperview];
         
         //向这个context报告切换是否完成
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}

/*
    终极解决办法，2的进阶
    对2进行思考后，既然只有成功切换时抖动，那么我们在动画结束时，添加一张toVC.view的截图覆盖
    其上，因为切换成功屏幕本来显示的就是toVC，所以此时截图内容和实际显示内容完全一致，截图内容 
    遮盖掉抖动的toVC.view即可（看下面逻辑，基本上就是刚添加上截图就立马移除了，但是确实这样确
    实达到了遮盖的效果）
 */
-(void)tabBarTransitionAnimation3:(id)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];

    
    //动画开始前的一些准备
//    fromVC.view.hidden = YES;
    
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    
    UIView *fromViewSnap = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromViewSnap.frame = frame;
    [[transitionContext containerView] addSubview:fromViewSnap];
    
    toVC.view.frame = CGRectOffset(frame, frame.size.width, 0);
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
     {
         fromViewSnap.frame = CGRectOffset(frame, -frame.size.width, 0);
         toVC.view.frame = frame;
     }
    completion:^(BOOL finished)
     {
         UIView *toViewSnap;
         if ([transitionContext transitionWasCancelled])
         {
             NSLog(@"cancel");
         }
         else
         {
             toViewSnap = [toVC.view snapshotViewAfterScreenUpdates:NO];
             toViewSnap.frame = CGRectOffset(frame, frame.size.width, 0);
             [[transitionContext containerView] addSubview:toViewSnap];
             
             NSLog(@"UNUNUNcancel");
         }
         
//         fromVC.view.hidden = NO;
         [fromViewSnap removeFromSuperview];
         if (toViewSnap)
         {
             [toViewSnap removeFromSuperview];
         }
         
         //向这个context报告切换是否完成
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
         NSLog(@"setCompleteTransition %@",[[transitionContext containerView] subviews]);
     }];
}


@end
