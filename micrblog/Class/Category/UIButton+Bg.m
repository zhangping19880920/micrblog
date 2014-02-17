//
//  UIButton+bg.m
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIButton+Bg.h"

@implementation UIButton (Bg)
- (CGSize)setAllStateBg:(NSString *)icon
{
    UIImage *normal = [UIImage stretchImageWithName:icon];
    UIImage *highlighted = [UIImage stretchImageWithName:[icon filenameAppend:@"_highlighted"]];
    
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    return normal.size;
}
@end
