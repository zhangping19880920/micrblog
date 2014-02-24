//
//  IconView.h
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

typedef enum {
    IconViewTypeSmall = 0,
    IconViewTypeDefault,
    IconViewTypeBig
} IconViewType;

@interface IconView : UIView

@property (nonatomic, strong) User *user;

@property (nonatomic, assign) IconViewType iconViewType;

// 返回头像的尺寸
+ (CGSize)iconViewSizeWithType:(IconViewType)type;

@end
