//
//  SystemDismissVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/20.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "SystemDismissVC.h"

@interface SystemDismissVC ()

@end

@implementation SystemDismissVC

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
    animation.type = @"suckEffect";
    
    /**  subtype：出现的方向
     *  kCATransitionFromRight       右
     *  kCATransitionFromLeft        左
     *  kCATransitionFromTop         上
     *  kCATransitionFromBottom      下
     */
    animation.subtype = kCATransitionFromRight;
    //注意：不能写成self.view.layer，否则无法达到效果
    [self.view.window.layer addAnimation:animation forKey:nil];

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
