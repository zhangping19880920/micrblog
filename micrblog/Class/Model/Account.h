//
//  Account.h
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>
// accessToken
@property (nonatomic, copy) NSString *accessToken;

// 用户ID
@property (nonatomic, copy) NSString *uid;

// 昵称
@property (nonatomic, copy) NSString *screenName;
@end
