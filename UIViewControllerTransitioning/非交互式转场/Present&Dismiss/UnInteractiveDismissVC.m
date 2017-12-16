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
//    self.modalPresentationStyle = UIModalPresentationCustom;
    
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
