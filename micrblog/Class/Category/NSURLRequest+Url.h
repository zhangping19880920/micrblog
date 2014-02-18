//
//  NSURLRequest+Url.h
//  micrblog
//
//  Created by zhangping on 14-2-18.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Url)
+ (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params;
@end
