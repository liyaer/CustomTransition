//
//  InteractiveCustonTransition.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    present,
    dismiss,
} customAnimation;


@interface InteractiveCustonTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) customAnimation custom;

@end
