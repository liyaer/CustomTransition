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

@end
