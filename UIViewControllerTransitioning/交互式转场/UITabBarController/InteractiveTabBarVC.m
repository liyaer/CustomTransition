//
//  InteractiveTabBarVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractiveTabBarVC.h"
#import "InteractiveCustonTransition.h"
#import "GestureInteractiveTransition.h"//相比非交互式，增加


@interface InteractiveTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong) GestureInteractiveTransition *interactiveTransition;//相比非交互式，增加

@end

@implementation InteractiveTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactiveTransition = [GestureInteractiveTransition new];//相比非交互式，增加

    for (int i = 0; i < 3; i++)
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"页面%d",i];
        vc.tabBarItem.title = [NSString stringWithFormat:@"页面%d",i];
        vc.view.backgroundColor = [UIColor colorWithRed:1.0 green:(i+1)*50/255.0 blue:(i+1)*50/255.0 alpha:1.0];
#warning 无论VC是否在Nav中，都不影响自定义转场动画
        //        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:vc];
        [self.interactiveTransition setGestureForToVC:vc];//相比非交互式，增加
    }
    self.tabBar.tintColor = [UIColor redColor];//设置选中Item的title颜色
    self.tabBar.unselectedItemTintColor = [UIColor greenColor];//设置未选中Item的title颜色
    
    
    self.delegate = self;
}

#pragma mark - UITabBarControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [InteractiveCustonTransition new];
}

//----------//相比非交互式，增加
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0)
{
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}


@end
