//
//  BaseVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/12.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "BaseVC.h"
//自定义转场动画
#import "UnInteractivePresentVC.h"
#import "UnInteractivePushVC.h"
#import "UnInteractiveTabBarVC.h"
#import "InteractivePresentVC.h"
#import "InteractivePushVC.h"
#import "InteractiveTabBarVC.h"
//系统自带转场动画
#import "SystemPresentVC.h"
#import "SystemPushVC.h"
#import "SystemTabBarVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//自定义转场动画
- (IBAction)go:(id)sender
{
    UnInteractivePresentVC *vc = [[UnInteractivePresentVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)gogo:(id)sender
{
    UnInteractivePushVC *vc = [[UnInteractivePushVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)gogogo:(id)sender
{
    UnInteractiveTabBarVC *vc = [[UnInteractiveTabBarVC alloc] init];
#warning 无论外层（相对于tabBarVC而言这里就是外层）是push还是present方式，都不影响tabBarVC的自定义转场
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)to:(id)sender
{
    InteractivePresentVC *vc = [[InteractivePresentVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)totot:(id)sender
{
    InteractivePushVC *vc = [[InteractivePushVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tototo:(id)sender
{
    InteractiveTabBarVC *vc = [[InteractiveTabBarVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//系统自带转场动画
- (IBAction)ha:(id)sender
{
    [self presentViewController:[SystemPresentVC new] animated:YES completion:nil];
}

- (IBAction)haha:(id)sender
{
    [self.navigationController pushViewController:[SystemPushVC new] animated:YES];
}

- (IBAction)hahaha:(id)sender
{
    [self.navigationController pushViewController:[SystemTabBarVC new] animated:YES];
}

@end
