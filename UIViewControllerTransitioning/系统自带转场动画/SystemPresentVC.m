//
//  SystemPresentVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/20.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "SystemPresentVC.h"
#import "SystemDismissVC.h"

@interface SystemPresentVC ()

@end

@implementation SystemPresentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 100);
    btn.center = self.view.center;
    [btn setTitle:@"click me" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

//大部分动画效果展示不完美，总能看到系统默认的present动画，尽管这个效果不太明显
-(void)next
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
    animation.type = kCATransitionPush;
    
    /**  subtype：出现的方向
     *  kCATransitionFromRight       右
     *  kCATransitionFromLeft        左
     *  kCATransitionFromTop         上
     *  kCATransitionFromBottom      下
     */
    animation.subtype = kCATransitionFromRight;
    //注意：不能写成self.view.layer，否则无法达到效果
    [self.view.window.layer addAnimation:animation forKey:nil];
    

    SystemDismissVC *vc = [[SystemDismissVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

//测试代码：尽管transitionFromView是对CATransition的封装，但是仅仅适用于UIView对象之间的转场动画，这种VC间的转场无法使用。
-(void)viewDidAppear:(BOOL)animated
{
//    SystemDismissVC *vc = [[SystemDismissVC alloc] init];
//    [UIView transitionFromView:self.view toView:vc.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished)
//     {
//         [self presentViewController:vc animated:YES completion:nil];
//     }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
