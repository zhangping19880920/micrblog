//
//  StatusTool.h
//  micrblog
//
//  Created by zhangping on 14-2-18.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject
+ (void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId
                    success:(void (^)(NSMutableArray *statuses))success fail:(void (^)())fail;
@end
