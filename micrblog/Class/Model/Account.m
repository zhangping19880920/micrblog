//
//  Account.m
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "Account.h"

@implementation Account

- (id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.accessToken = [decoder decodeObjectForKey:kAccessToken];
        self.uid = [decoder decodeObjectForKey:KUid];
        self.screenName = [decoder decodeObjectForKey:kScreenName];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder{
    [enCoder encodeObject:self.accessToken forKey:kAccessToken];
    [enCoder encodeObject:self.uid forKey:KUid];
    [enCoder encodeObject:self.screenName forKey:kScreenName];
}
@end
