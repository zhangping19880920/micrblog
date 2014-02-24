//
//  StatusImageListView.h
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusImageListView : UIView

@property (nonatomic, strong) NSArray *imageUrls;

+ (CGSize)imageSizeWithCount:(int)count;

@end
