//
//  MainViewController.m
//  micrblog
//
//  Created by zhangping on 14-2-16.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "MoreViewController.h"
#import "Dock.h"

#define kDockHeight 44

@interface MainViewController (){
    // 选中的控制器
    UIViewController *_selectedViewController;
}

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self addDock];
}

- (void)addDock{
    CGSize rootSize = self.view.frame.size;
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, rootSize.height - kDockHeight, rootSize.width, kDockHeight);
    [self.view addSubview:dock];
    
    // 2.添加dock里面的item
    [dock addDockItemWithIcon:@"tabbar_home.png" title:@"首页"];
    [dock addDockItemWithIcon:@"tabbar_message_center.png" title:@"消息"];
    [dock addDockItemWithIcon:@"tabbar_profile.png" title:@"我"];
    [dock addDockItemWithIcon:@"tabbar_discover.png" title:@"广场"];
    [dock addDockItemWithIcon:@"tabbar_more.png" title:@"更多"];
    
    dock.itemClickBlock = ^(int intex){
        Loger(@"itemClickBlock = %d", intex);
    };
    dock.selectedIndex = 0;
}

@end
