//
//  GestureInteractiveTransition.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

//手势的方向
typedef NS_ENUM(NSUInteger, GesDirection)
{
    kLeft,
    kRight,
    kUp,
    kDown,
};

//当前交互的转场类型
typedef enum : NSUInteger
{
    gPresent,
    gDismiss,
    gPush,
    gPop,
    gTabBar,
}
TransitionType;

//present和push转场时在这里操作不方便，做个block传递到VC中完成操作
typedef void(^GestureConifg)();




@interface GestureInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,copy) GestureConifg gesPresentConfig;
@property (nonatomic,copy) GestureConifg gesPushConfig;

@property (nonatomic, assign) BOOL interacting;//当前是否在交互状态，主要为了保证一次交互的过程中不会再出发第二次交互，直到本次交互完毕


-(instancetype)initWithTransitionType:(TransitionType)type GesDirection:(GesDirection)direction addGesVC:(UIViewController *)vc;

@end
