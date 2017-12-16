//
//  InteractivePushVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractivePushVC.h"
#import "InteractivePopVC.h"
#import "CustomTransitionAnimation.h"
#import "GestureInteractiveTransition.h"//相比非交互式，增加




@interface InteractivePushVC ()<UINavigationControllerDelegate>

@property (nonatomic,strong) CustomTransitionAnimation *customTransition;

@property (nonatomic,strong) GestureInteractiveTransition *IT_push;//相比非交互式，增加
@property (nonatomic,strong) GestureInteractiveTransition *IT_pop;//相比非交互式，增加

@end




@implementation InteractivePushVC
{
    BOOL _isPushVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回yiya" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    self.customTransition = [CustomTransitionAnimation new];
    //相比非交互式，增加
    self.IT_push = [[GestureInteractiveTransition alloc] initWithTransitionType:gPush GesDirection:kDown addGesVC:self];
    __weak typeof(self) weakSelf = self;
    self.IT_push.gesPushConfig = ^
    {
        [weakSelf pushAction:nil];
    };
}

-(void)backAction
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushAction:(id)sender
{
    InteractivePopVC *vc = [InteractivePopVC new];
    self.navigationController.delegate = self;
    //相比非交互式，增加
    self.IT_pop = [[GestureInteractiveTransition alloc] initWithTransitionType:gPop GesDirection:kDown addGesVC:vc];
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ([fromVC isKindOfClass:[self class]])
    {
        self.customTransition.type = kPush;
        _isPushVC = YES;
    }
    else
    {
        self.customTransition.type = kPop;
        _isPushVC = NO;
    }
    return self.customTransition;
}

//----------//相比非交互式，增加
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (_isPushVC)
    {
        return self.IT_push.interacting ? self.IT_push : nil;
    }
    else
    {
        return self.IT_pop.interacting ? self.IT_pop : nil;
    }
}

@end
