//
//  GestureInteractiveTransition.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "GestureInteractiveTransition.h"

@interface GestureInteractiveTransition ()

@property (nonatomic,assign) GesDirection diretion;
@property (nonatomic,assign) TransitionType type;
@property (nonatomic, strong) UIViewController *vc;

@property (nonatomic, assign) BOOL shouldComplete;//规定本次交互是否成功完成

@end




@implementation GestureInteractiveTransition

-(instancetype)initWithTransitionType:(TransitionType)type GesDirection:(GesDirection)direction addGesVC:(UIViewController *)vc
{
    if (self = [super init])
    {
        _diretion = direction;
        _type = type;
        
        _vc = vc;//两个内存地址一样哦
        UIPanGestureRecognizer *toGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [vc.view addGestureRecognizer:toGesture];
    }
    return self;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            self.interacting = YES;
            
            [self transitionOperate];
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

-(void)transitionOperate
{
    switch (_type)
    {
        case gPresent:
        {
            if (self.gesPresentConfig)
            {
                self.gesPresentConfig();
            }
        }
            break;
            
        case gDismiss:
        {
            [self.vc dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        case gPush:
        {
            if (self.gesPushConfig)
            {
                self.gesPushConfig();
            }
        }
            break;
            
        case gPop:
        {
            [self.vc.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case gTabBar:
        {
            UITabBarController *tabBar = (UITabBarController *)self.vc;
            tabBar.selectedIndex = 0;
        }
            break;
            
        default:
            break;
    }
}

@end
