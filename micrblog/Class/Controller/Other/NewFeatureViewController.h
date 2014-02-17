//
//  NewFeatureViewController.h
//  micrblog
//
//  Created by zhangping on 14-2-16.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, copy) void (^startBlock)(BOOL shared);
@end
