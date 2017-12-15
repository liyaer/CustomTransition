//
//  CustomPresentAnimation.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/11.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger
{
    kPresent,
    kDismiss,
    kPush,
    kPop,
    ktabBar,
}
transitionType;


@interface UnInteractiveCustomTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) transitionType type;

@end
