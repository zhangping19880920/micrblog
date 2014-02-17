//
//  UIBarButtonItem+create.h
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Create)
+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithBg:(NSString *)bg title:(NSString *)title size:(CGSize)size target:(id)target action:(SEL)action;
@end
