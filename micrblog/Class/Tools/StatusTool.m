//
//  StatusTool.m
//  micrblog
//
//  Created by zhangping on 14-2-18.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "StatusTool.h"
#import "Status.h"

#define kStatusesPath @"statuses/friends_timeline.json"

@implementation StatusTool
+ (void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail{
    sinceId = sinceId == nil? @"0": sinceId;
    maxId = maxId == nil? @"0": maxId;
    
    NSURLRequest *request = [NSURLRequest requestWithPath:kStatusesPath params:@{@"since_id" : sinceId, @"max_id" : maxId}];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSArray *array = JSON[@"statuses"];
        
        NSMutableArray *statuses = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            Status *st = [[Status alloc] initWithDict:dict];
            [statuses addObject:st];
        }

        if (success) {
            success(statuses);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [operation start];
}
@end
