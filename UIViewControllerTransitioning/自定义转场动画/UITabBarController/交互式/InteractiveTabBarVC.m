//
//  InteractiveTabBarVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractiveTabBarVC.h"
#import "CustomTransitionAnimation.h"
#import "GestureInteractiveTransition.h"//相比非交互式，增加




@interface InteractiveTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong) CustomTransitionAnimation *customTransition;

@property (nonatomic,strong) GestureInteractiveTransition *interactiveTransition;//相比非交互式，增加

@end




@implementation InteractiveTabBarVC

-(void)addBGLayerForVC:(UIViewController *)vc index:(int)i
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = vc.view.bounds;
    //设置渐变梯度（水平，垂直，对角）
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.0)];
    [gradientLayer setEndPoint:CGPointMake(1.0, 0.0)];
    gradientLayer.colors = @[(id)[[UIColor colorWithRed:(3-i)*50/255.0 green:i*30/255.0 blue:(i+1)*50/255.0 alpha:1.0] CGColor],(id)[UIColor brownColor].CGColor];
    [vc.view.layer addSublayer:gradientLayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    for (int i = 0; i < 3; i++)
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"页面%d",i];
        vc.tabBarItem.title = [NSString stringWithFormat:@"页面%d",i];
        [self addBGLayerForVC:vc index:i];
#warning 无论VC是否在Nav中，都不影响自定义转场动画
        //        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:vc];
    }
    self.tabBar.tintColor = [UIColor redColor];//设置选中Item的title颜色
    self.tabBar.unselectedItemTintColor = [UIColor greenColor];//设置未选中Item的title颜色
    
    
    self.customTransition = [CustomTransitionAnimation new];
    self.delegate = self;
    //相比非交互式，增加
    self.interactiveTransition = [[GestureInteractiveTransition alloc] initWithTransitionType:gTabBar GesDirection:kDown addGesVC:self];
}




#pragma mark - UITabBarControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    self.customTransition.type = ktabBar;
    return self.customTransition;
}

//----------//相比非交互式，增加
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController 
{
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}


@end
