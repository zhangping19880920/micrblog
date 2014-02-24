//
//  SendStatusViewController.m
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SendStatusViewController.h"

@interface SendStatusViewController ()

@end

@implementation SendStatusViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 0.设置标题
    self.title = @"发微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithBg:@"compose_emotion_table_send.png" title:@"发送" size:CGSizeMake(50, 30) target:self action:@selector(send)];
}

- (void)send{
    Loger(@"send");
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
