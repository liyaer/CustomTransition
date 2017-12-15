//
//  InteractivePresentVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractivePresentVC.h"
#import "InteractiveDismissVC.h"
#import "GestureInteractiveTransition.h"//相比非交互式，增加
#import "InteractiveCustonTransition.h"//相比非交互式，修改


@interface InteractivePresentVC ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) InteractiveCustonTransition *customAnimation;
@property (nonatomic,strong) GestureInteractiveTransition *interactiveTransition;//相比非交互式，增加

@end




@implementation InteractivePresentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customAnimation = [InteractiveCustonTransition new];
    self.interactiveTransition = [GestureInteractiveTransition new];//相比非交互式，增加
}

- (IBAction)presentAction:(id)sender
{
    InteractiveDismissVC *vc = [[InteractiveDismissVC alloc] init];
    vc.transitioningDelegate = self;
    [self.interactiveTransition setGestureForToVC:vc];//相比非交互式，增加
    [self presentViewController:vc animated:YES completion:nil];
}




#pragma mark - UIViewControllerTransitioningDelegate

//present动画效果
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.customAnimation.custom = present;
    return self.customAnimation;
}

//dismiss动画效果
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.customAnimation.custom = dismiss;
    return self.customAnimation;
}

//present交互动画效果   ----------//相比非交互式，增加
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}

//dismiss交互动画效果   ----------//相比非交互式，增加
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}




- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
