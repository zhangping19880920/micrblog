//
//  HomeViewController.m
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "SendStatusViewController.h"

/*
 1.BarButtonItem需要显示图片
 initWithCustomView
 
 2.BarButtonItem只是显示文字
 initWithTitle
 */

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.标题
    self.title = @"首页";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" target:self action:@selector(sendStatus)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" target:self action:@selector(popMenu)];
}

- (void)popMenu{
    Loger(@"popMenu");
}

- (void)sendStatus{
    SendStatusViewController *send = [[SendStatusViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:send];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
