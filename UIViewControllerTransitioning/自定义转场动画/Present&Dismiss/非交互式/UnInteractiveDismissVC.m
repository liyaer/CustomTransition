//
//  ViewController.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/11.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UnInteractiveDismissVC.h"
#import "CustomTransitionAnimation.h"




@interface UnInteractiveDismissVC ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) CustomTransitionAnimation *customTransition;

@end




@implementation UnInteractiveDismissVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //自定义转场方式
    self.transitioningDelegate = self;
    
#warning 关于modalPresentationStyle属性的设置，在交互式里面详细说明。因为如果转场设置写在dismissVC中，这个属性无论设置成UIModalPresentationCustom还是默认值UIModalPresentationFullScreen,动画都可以正常进行。（注意自定义转场该属性只有这两个值有实际意义，不设置默认值是UIModalPresentationFullScreen）而转场设置如果写在presentVC中，这两个值将会有差异，详见交互式里的说明。
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    //系统提供4中简单转场动画，但是当我们设置了transitioningDelegate，代表不使用系统转场方式，使用自定义转场方式，此时modalTransitionStyle会失效
    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    
    self.customTransition = [[CustomTransitionAnimation alloc] init];
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - UIViewControllerTransitioningDelegate 

//present时的动画效果
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.customTransition.type = kPresent;
    return self.customTransition;
}

//dismiss时的动画效果
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.customTransition.type = kDismiss;
    return self.customTransition;
}


@end
