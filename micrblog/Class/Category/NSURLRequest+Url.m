//
//  NSURLRequest+Url.m
//  micrblog
//
//  Created by zhangping on 14-2-18.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "NSURLRequest+Url.h"
#import "AccountTool.h"
#import "Account.h"

@implementation NSURLRequest (Url)
+ (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@", kBaseURL, path];
    
    if (params) {
        [urlStr appendString:@"?"];
        NSString *token = [AccountTool sharedAccountTool].currentAccount.accessToken;
        [urlStr appendFormat:@"%@=%@", kAccessToken, token];
        
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [urlStr appendFormat:@"&%@=%@", key, obj];
        }];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    return [NSURLRequest requestWithURL:url];
}
@end
