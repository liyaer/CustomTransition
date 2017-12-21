//
//  OtherVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/12.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UnInteractivePushVC.h"
#import "UnInteractivePopVC.h"
#import "NavControllerDelegate.h"




@interface UnInteractivePushVC ()

@property (nonatomic,strong) NavControllerDelegate *NavDelegate;

@end




@implementation UnInteractivePushVC

#warning 由于是对navigationController的操作，所以只要满足这两个条件的VC，1.VC在该Nav下 2.VC中设置了Nav的delegate，都会进行自定义转场动画。如果只想某两个VC使用自定义转场，请及时将navigationController.delegate置nil（另外，关于转场的设置只能写在PushVC中才能达到效果，这一点注意和上面的Present&Dismiss进行区别）

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.NavDelegate = [[NavControllerDelegate alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回yiya" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

-(void)backAction
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushAction:(id)sender
{
    UnInteractivePopVC *vc = [[UnInteractivePopVC alloc] init];
    self.navigationController.delegate = self.NavDelegate;//自定义转场设置
    [self.navigationController pushViewController:vc animated:YES];
}

@end
