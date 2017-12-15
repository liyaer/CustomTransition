//
//  GestureInteractiveTransition.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "GestureInteractiveTransition.h"

@interface GestureInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *fromVC;
@property (nonatomic, strong) UIViewController *toVC;

@end




@implementation GestureInteractiveTransition

-(void)setGestureForToVC:(UIViewController *)toVC
{
    self.toVC = toVC;//两个内存地址一样哦
    UIPanGestureRecognizer *toGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [toVC.view addGestureRecognizer:toGesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            self.interacting = YES;
//            [self.toVC dismissViewControllerAnimated:YES completion:nil];
//            [self.toVC.navigationController popViewControllerAnimated:YES];
            self.toVC.tabBarController.selectedIndex = 0;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat fraction = translation.y / 400.0;
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            
            //系统方法：根据用户手势更新交互进度
            [self updateInteractiveTransition:fraction];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
            {
                //系统方法：报告交互取消，返回切换前的状态
                [self cancelInteractiveTransition];
            }
            else
            {
                //系统方法：报告交互完成，更新到切换后的状态
                [self finishInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}

//【cancelInteractiveTransition】【finishInteractiveTransition】会调用这个get方法(completionSpeed是一个属性)
-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

@end
