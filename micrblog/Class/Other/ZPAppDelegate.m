//
//  ZPAppDelegate.m
//  micrblog
//
//  Created by zhangping on 14-2-16.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "ZPAppDelegate.h"
#import "NewFeatureViewController.h"
#import "MainViewController.h"

@implementation ZPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    NSString *lastVersion = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        //used
        [self startWeibo:NO];
    }else{
        //not use
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NewFeatureViewController *new= [[NewFeatureViewController alloc] init];
        new.startBlock = ^(BOOL shared){
            [self startWeibo:shared];
        };
        self.window.rootViewController = new;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)startWeibo:(BOOL)shared{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    MainViewController *main = [[MainViewController alloc] init];
    self.window.rootViewController = main;
}

@end
