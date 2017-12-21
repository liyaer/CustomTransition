//
//  CustomPresentAnimation.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/11.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//根据type设定不同动画类型，如果往返动画一样，可以不需要此枚举
typedef enum : NSUInteger
{
    kPresent,
    kDismiss,
    kPush,
    kPop,
    ktabBar,
}
transitionType;


@interface CustomTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) transitionType type;

@end
