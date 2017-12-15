//
//  InteractivePushVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractivePushVC.h"
#import "InteractivePopVC.h"
#import "GestureInteractiveTransition.h"//相比非交互式，增加


@interface InteractivePushVC ()<UINavigationControllerDelegate>

@property (nonatomic,strong) GestureInteractiveTransition *interactiveTransition;//相比非交互式，增加

@end


@implementation InteractivePushVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.interactiveTransition = [GestureInteractiveTransition new];//相比非交互式，增加
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回yiya" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

-(void)backAction
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushAction:(id)sender
{
    InteractivePopVC *vc = [InteractivePopVC new];
    self.navigationController.delegate = self;
    [self.interactiveTransition setGestureForToVC:vc];//相比非交互式，增加
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [NSClassFromString(@"InteractiveCustonTransition") new];
}

//----------//相比非交互式，增加
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
{
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}

@end
