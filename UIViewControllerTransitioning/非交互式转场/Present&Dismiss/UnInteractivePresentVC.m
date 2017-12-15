//
//  MainVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/11.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UnInteractivePresentVC.h"
#import "UnInteractiveDismissVC.h"
//#import "VCTransitioningDelegate.h"




@interface UnInteractivePresentVC ()

//@property (nonatomic,strong) VCTransitioningDelegate *vcTransitioningDelegate;

@end




@implementation UnInteractivePresentVC

#warning 关于转场的这些设置写在DissmissVC或者PresentVC中都可以达到效果。这里在PresentVC中使用解耦方式，在DismissVC中使用一般方式，运行时请注释掉任意一个VC中的关于转场的设置，以用来证明都可以达到效果。（下面的几个例子不在演示一般方式，和这里完全类似，统一使用解耦的方式。但是如果业务逻辑复杂，难于分离，直接用一般方式也可以）

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.vcTransitioningDelegate = [VCTransitioningDelegate new];
}

- (IBAction)customPresent:(id)sender
{
    UnInteractiveDismissVC *vc = [[UnInteractiveDismissVC alloc] init];
//    vc.transitioningDelegate = self.vcTransitioningDelegate;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)backToBaseVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
