//
//  GestureInteractiveTransition.h
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//


/*
    转场交互化后结果有两种：完成和取消。取消后动画将会原路返回到初始状态，但已经变化了的数据怎么恢复？
 
    一种情况是，控制器的系统属性，比如，在 TabBarController 里使用上面的方法实现滑动切换 Tab 页面，中途取消的话，已经变化的selectedIndex属性该怎么恢复为原值；上面的代码里，取消转场的代码执行后，self.navigationController返回的依然还是是 nil，怎么让控制器回到 NavigationController 的控制器栈顶。对于这种情况，UIKit 自动替我们恢复了，不需要我们操心(可能你都没有意识到这回事)；
 
    另外一种就是，转场发生的过程中，你可能想实现某些效果，一般是在下面的事件中执行，转场中途取消的话可能需要取消这些效果。
         func viewWillAppear(_ animated: Bool)
         func viewDidAppear(_ animated: Bool)
         func viewWillDisappear(_ animated: Bool)
         func viewDidDisappear(_ animated: Bool)
    交互转场介入后，视图在这些状态间的转换变得复杂，WWDC 上苹果的工程师还表示转场过程中 view 的Will系方法和Did系方法的执行顺序并不能得到保证，虽然几率很小，但如果你依赖于这些方法执行的顺序的话就可能需要注意这点。而且，Did系方法调用时并不意味着转场过程真的结束了。
 */

#import <UIKit/UIKit.h>

//手势的方向（暂时没用）
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
