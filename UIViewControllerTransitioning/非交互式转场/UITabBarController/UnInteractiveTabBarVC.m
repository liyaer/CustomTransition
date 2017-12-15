//
//  UnInteractiveTabBarVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UnInteractiveTabBarVC.h"
#import "TabBarVCDelegate.h"




@interface UnInteractiveTabBarVC ()

@property (nonatomic,strong) TabBarVCDelegate *tabBarVCDelegate;

@end




@implementation UnInteractiveTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < 3; i++)
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"页面%d",i];
        vc.tabBarItem.title = [NSString stringWithFormat:@"页面%d",i];
        vc.view.backgroundColor = [UIColor colorWithRed:(3-i)*50/255.0 green:i*30/255.0 blue:(i+1)*50/255.0 alpha:1.0];
#warning 无论VC是否在Nav中，都不影响自定义转场动画
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:vc];
    }
    self.tabBar.tintColor = [UIColor redColor];//设置选中Item的title颜色
    self.tabBar.unselectedItemTintColor = [UIColor greenColor];//设置未选中Item的title颜色
    
    //自定义转场设置
    self.tabBarVCDelegate = [TabBarVCDelegate new];
    self.delegate = self.tabBarVCDelegate;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}


@end
