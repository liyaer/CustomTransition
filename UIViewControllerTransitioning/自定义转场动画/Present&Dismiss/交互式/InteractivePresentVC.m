//
//  InteractivePresentVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractivePresentVC.h"
#import "InteractiveDismissVC.h"
#import "CustomTransitionAnimation.h"
#import "GestureInteractiveTransition.h"//相比非交互式，增加




@interface InteractivePresentVC ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) CustomTransitionAnimation *customAnimation;

@property (nonatomic,strong) GestureInteractiveTransition *IT_present;//相比非交互式，增加
@property (nonatomic,strong) GestureInteractiveTransition *IT_dismiss;//相比非交互式，增加

@end




@implementation InteractivePresentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customAnimation = [CustomTransitionAnimation new];
    
    //相比非交互式，增加
    self.IT_present = [[GestureInteractiveTransition alloc] initWithTransitionType:gPresent GesDirection:kDown addGesVC:self];    __weak typeof(self) weakSelf = self;
    self.IT_present.gesPresentConfig = ^
    {
        [weakSelf presentAction:nil];
    };
}

- (IBAction)presentAction:(id)sender
{
    InteractiveDismissVC *vc = [[InteractiveDismissVC alloc] init];
    vc.transitioningDelegate = self;
//    vc.modalPresentationStyle = UIModalPresentationCustom;//下面有详细说明
    //相比非交互式，增加
    self.IT_dismiss = [[GestureInteractiveTransition alloc] initWithTransitionType:gDismiss GesDirection:kDown addGesVC:vc];
    [self presentViewController:vc animated:YES completion:nil];
}




#pragma mark - UIViewControllerTransitioningDelegate

//present动画效果
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.customAnimation.type = kPresent;
    return self.customAnimation;
}

//dismiss动画效果
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.customAnimation.type = kDismiss;
    return self.customAnimation;
}

//present交互动画效果   ----------//相比非交互式，增加
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.IT_present.interacting ? self.IT_present : nil;
}

//dismiss交互动画效果   ----------//相比非交互式，增加
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.IT_dismiss.interacting ? self.IT_dismiss : nil;
}




- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
    1，UINavigationController 和 UITabBarController 这两个容器 VC 的根视图在屏幕上是不可见的(或者说是透明的)，可见的只是内嵌在这两者中的子 VC 中的视图，转场是从子 VC 的视图转换到另外一个子 VC 的视图，其根视图并未参与转场。而且 NavigationController 和 TabBarController 转场中的 containerView 也并非这两者的根视图；
      而 Modal 转场，以 presentation 为例，是从 presentingView 转换到 presentedView，根视图 presentingView 也就是 fromView 参与了转场。
 
    2，Modal 转场与两种容器 VC 的转场的另外一个不同是：Modal 转场结束后 presentingView 可能依然可见（屏幕上同时展示fromVC和toVC的那种动画效果），UIModalPresentationPageSheet 模式就是这样。这种不同导致了 Modal 转场和容器 VC 的转场对 fromView 的处理差异：
            容器 VC 的转场结束后 fromView 会被主动移出视图结构，这是可预见的结果，我们也可以在转场结束前手动移除；
            而 Modal 转场中，presentation 结束后 presentingView(fromView) 并未主动被从视图结构中移除。准确来说，是 UIModalPresentationCustom 这种模式下的 Modal 转场结束时 fromView 并未从视图结构中移除；UIModalPresentationFullScreen 模式的 Modal 转场结束后 fromView 依然主动被从视图结构中移除了。这种差异导致在处理 dismissal 转场的时候很容易出现问题，没有意识到这个不同点的话出错时就会毫无头绪。下面来看看 dismissal 转场时的场景。
 
    3，在 dismissal 转场中：
    UIModalPresentationFullScreen 模式：presentation 后，presentingView 被主动移出视图结构，在 dismissal 中 presentingView 是 toView 的角色，需要我们将其重新加入 containerView 中。
    UIModalPresentationCustom 模式：转场时 containerView 并不担任 presentingView 的父视图，后者由 UIKit 另行管理。在 presentation 后，fromView(presentingView) 未被移出视图结构，在 dismissal 中，注意不要像其他转场中那样将 toView(presentingView) 加入 containerView 中，否则本来可见的 presentingView 将会被移除出自身所处的视图结构消失不见。如果你在使用 Custom 模式时没有注意到这点，就很容易掉进这个陷阱而很难察觉问题所在，这个问题曾困扰了我一天。
 
    个人总结：
        1，对于present&dismissz转场方式而言，如果动画结果需要同时展示fromVC和toVC，那么需要
        设置vc.modalPresentationStyle = UIModalPresentationCustom;同时在动画部分
        不能设置[[transitionContext containerView] addSubview:toVC.view];
        2，无论那种转场方式，如果是直接用vc.view做动画，那么动画结束后无需写任何关于vc.view移除的代码，交给系统自动管理；如果使用截图做动画，需要手动管理截图，动画结束后从父试图移除截图。
 */



@end
