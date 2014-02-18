//
//  AccountTool.m
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"

#define kFileName @"accounts.data"
#define kCurrentName @"currentAccount.data"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]

#define kCurrentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentName]


@interface AccountTool (){
    NSMutableArray *_accounts;
}

@end
@implementation AccountTool
singleton_implementation(AccountTool)

-(id)init{
    if (self = [super init]) {
        _accounts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kCurrentPath];
        if (!_accounts) {
            _accounts = [NSMutableArray array];
        }
    }
    return self;
}

-(void)addAccount:(id)account{
    [_accounts addObject:account];
    _currentAccount = account;
    
    [NSKeyedArchiver archiveRootObject:_accounts toFile:kFilePath];
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentPath];
}
@end
