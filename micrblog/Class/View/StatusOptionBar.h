//
//  StatusOptionBar.h
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;
@interface StatusOptionBar : UIImageView
@property (nonatomic, strong) Status *status;
@end
