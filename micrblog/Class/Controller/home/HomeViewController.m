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
    UILabel *label = [[UILabel alloc] init];
    label.text = @"HomeViewController";
}

@end
