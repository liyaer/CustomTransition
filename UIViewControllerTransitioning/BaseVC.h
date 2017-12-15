//
//  BaseVC.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/12.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

/*
    讲自定义转场就离不开这几个protocol：
        UIViewControllerContextTransitioning
        UIViewControllerAnimatedTransitioning
        UIViewControllerInteractiveTransitioning
        UIViewControllerTransitioningDelegate
        UINavigationControllerDelegate
        UITabBarControllerDelegate
 
    乍一看很多，其实很简单，我们可以将其分为三类：
    描述ViewController转场的：
        UIViewControllerTransitioningDelegate,
        UINavigationControllerDelegate,
        UITabBarControllerDelegate
 
    定义动画内容的
        UIViewControllerAnimatedTransitioning,
        UIViewControllerInteractiveTransitioning
 
    表示动画上下文的
        UIViewControllerContextTransitioning
 
 
 
 
    我们分别来看下：
        UIViewControllerTransitioningDelegate 自定义模态转场动画时使用。
        设置UIViewController的属性transitioningDelegate。
 
        UINavigationControllerDelegate 自定义navigation转场动画时使用。
        设置UINavigationController的属性delegate

        UITabBarControllerDelegate 自定义tab转场动画时使用。
        设置UITabBarController的属性delegate
    实际上这三个protocol干的事情是一样的，只不过他们的应用场景不同罢了
 */

@end
