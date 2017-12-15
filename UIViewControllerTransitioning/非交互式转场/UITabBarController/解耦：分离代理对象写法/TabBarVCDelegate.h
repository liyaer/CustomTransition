//
//  TabBarVCDelegate.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/15.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UnInteractiveCustomTransition.h"

@interface TabBarVCDelegate : NSObject<UITabBarControllerDelegate>

@property (nonatomic,strong) UnInteractiveCustomTransition *customTransition;

@end
