//
//  StatusCellFrame.m
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"

@implementation StatusCellFrame
- (void)setStatus:(Status *)status{
    [super setStatus:status];
    _cellHeight += kStatusOptionBarHeight;
}
@end
