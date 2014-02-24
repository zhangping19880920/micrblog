//
//  BaseCell.h
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseFrame;

@interface BaseCell : UITableViewCell{
    UIImageView *_retweet;
    BaseFrame *_baseFrame;
}

@property (nonatomic, strong) BaseFrame *baseFrame;

@end
