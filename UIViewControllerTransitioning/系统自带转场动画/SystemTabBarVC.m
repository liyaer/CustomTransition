//
//  SystemTabBarVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/21.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "SystemTabBarVC.h"

@interface SystemTabBarVC ()

@end

@implementation SystemTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 3; i++)
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"页面%d",i];
        vc.tabBarItem.title = [NSString stringWithFormat:@"页面%d",i];
        vc.view.backgroundColor = [UIColor colorWithRed:(3-i)*50/255.0 green:i*30/255.0 blue:(i+1)*50/255.0 alpha:1.0];
        [self addChildViewController:vc];
    }
    self.tabBar.tintColor = [UIColor redColor];//设置选中Item的title颜色
    self.tabBar.unselectedItemTintColor = [UIColor greenColor];//设置未选中Item的title颜色
    self.tabBar.translucent = NO;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    /** 私有API
     *  pageCurl       向上翻一页
     *  pageUnCurl     向下翻一页
     *  rippleEffect   水滴
     *  suckEffect     收缩
     *  cube           方块
     *  oglFlip        上下翻转
     */
    /** 公开的API
     *  kCATransitionFade       淡出
     *  kCATransitionMoveIn     覆盖
     *  kCATransitionReveal     底部显示
     *  kCATransitionPush       推出
     */
    animation.type = @"rippleEffect";
    
    /**  subtype：出现的方向
     *  kCATransitionFromRight       右
     *  kCATransitionFromLeft        左
     *  kCATransitionFromTop         上
     *  kCATransitionFromBottom      下
     */
//    animation.subtype = kCATransitionFromRight;
    //注意：不能写成self.view.layer，否则无法达到效果
    [self.view.window.layer addAnimation:animation forKey:nil];
}


@end
