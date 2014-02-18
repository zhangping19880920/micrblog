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
    [self createChildViewControllers];
	[self addDock];
    [self setNavigationTheme];
}

- (void)setNavigationTheme{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    [navBar setTitleTextAttributes:@{
       UITextAttributeTextColor : [UIColor darkGrayColor],
       UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
       UITextAttributeFont : [UIFont systemFontOfSize:22]
     }];
    
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable.png"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    NSDictionary *attr = @{
        UITextAttributeTextColor :[UIColor darkGrayColor],
        UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
        UITextAttributeFont : [UIFont systemFontOfSize:13]
    };
    [barItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:attr forState:UIControlStateHighlighted];
}

- (void)createChildViewControllers{
    // 1.首页
    HomeViewController *home = [[HomeViewController alloc] init];
    // 会将子控制器添加到childViewControllers中去
    [self addChildViewController:home];
    
    // 2.消息
    MessageViewController *message = [[MessageViewController alloc] init];
    [self addChildViewController:message];
    
    // 3.我
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addChildViewController:profile];
    
    // 4.广场
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addChildViewController:discover];
    
    // 5.更多
    MoreViewController *more = [[MoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:more];
}

- (void)addChildViewController:(UIViewController *)childController{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    
    [super addChildViewController:nav];
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
    
    dock.itemClickBlock = ^(int index){
        [self selecteControllerAtIndex:index];
    };
    dock.selectedIndex = 0;
}

- (void)selecteControllerAtIndex:(int)index{
    UIViewController *new = self.childViewControllers[index];
    if (new == _selectedViewController) return;
    
    [_selectedViewController.view removeFromSuperview];
    
    new.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kDockHeight);
    [self.view addSubview:new.view];
    
    _selectedViewController = new;
}

@end
