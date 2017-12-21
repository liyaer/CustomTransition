//
//  SystemPushVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/21.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "SystemPushVC.h"
#import "SystemPopVC.h"

@interface SystemPushVC ()

@end

@implementation SystemPushVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor brownColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0;
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
    animation.type = @"cube";
    
    /**  subtype：出现的方向
     *  kCATransitionFromRight       右
     *  kCATransitionFromLeft        左
     *  kCATransitionFromTop         上
     *  kCATransitionFromBottom      下
     */
    animation.subtype = kCATransitionFromRight;
    //注意：不能写成self.view.layer，否则无法达到效果
    [self.view.window.layer addAnimation:animation forKey:nil];

    
    [self.navigationController pushViewController:[SystemPopVC new] animated:YES];
}


@end
