//
//  StatusCellFrame.h
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Status;
@interface StatusCellFrame : NSObject

@property (nonatomic, strong) Status *status;

/*
 cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/*
 本身所有子控件的frame
 */
// 1.头像
@property (nonatomic, assign, readonly) CGRect icon;
// 2.昵称
@property (nonatomic, assign, readonly) CGRect screenName;
// 3.会员图标
@property (nonatomic, assign, readonly) CGRect mbIcon;
// 4.时间
@property (nonatomic, assign, readonly) CGRect time;
// 5.来源
@property (nonatomic, assign, readonly) CGRect source;
// 6.正文
@property (nonatomic, assign, readonly) CGRect content;
// 7.配图
@property (nonatomic, assign, readonly) CGRect image;

/*
 转发的子控件
 */
// 1.转发的整体结构
@property (nonatomic, assign, readonly) CGRect retweet;
// 2.昵称
@property (nonatomic, assign, readonly) CGRect retweetScreenName;
// 3.正文
@property (nonatomic, assign, readonly) CGRect retweetContent;
// 4.配图
@property (nonatomic, assign, readonly) CGRect retweetImage;

@end
