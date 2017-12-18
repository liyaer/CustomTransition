
//
//  InteractiveDismissVC.m
//  UIViewControllerTransitioning
//
//  Created by 杜文亮 on 2017/12/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "InteractiveDismissVC.h"

@interface InteractiveDismissVC ()

@end

@implementation InteractiveDismissVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
