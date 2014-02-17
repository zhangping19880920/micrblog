//
//  UIImage+image.m
//  weibo
//
//  Created by apple on 13-8-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
#pragma mark 根据屏幕尺寸返回全屏的图片
+ (UIImage *)fullscreenImageWithName:(NSString *)name
{
    if (iPhone5) {
        name = [name filenameAppend:@"-568h@2x"];
    }
    return [UIImage imageNamed:name];
}

+ (UIImage *)stretchImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
