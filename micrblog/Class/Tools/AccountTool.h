//
//  AccountTool.h
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class Account;

@interface AccountTool : NSObject
singleton_interface(AccountTool)
@property (nonatomic, strong) Account *currentAccount;
- (void)addAccount:(Account *)account;
@end
