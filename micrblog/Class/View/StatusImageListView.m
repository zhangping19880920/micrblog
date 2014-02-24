//
//  StatusImageListView.m
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "StatusImageListView.h"
#import "StatusImageView.h"

#define kStatusOneImageWidth 120
#define kStatusOneImageHeight 120

#define kStatusImageWidth 80
#define kStatusImageHeight 80

#define kStatusImageMargin 10

#define kStatusImageListViewSubViewCount 9

@implementation StatusImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加9个StatusImageView
        for (int i = 0; i < kStatusImageListViewSubViewCount; i++) {
            StatusImageView *imageView = [[StatusImageView alloc] init];
            [self addSubview:imageView];
        }
    }
    return self;
}

-(void)setImageUrls:(NSArray *)imageUrls{
    _imageUrls = imageUrls;
    
    int imageCount = imageUrls.count;
    int subCount = self.subviews.count;
    
    // 遍历所有的ImageView
    for (int i = 0; i<subCount;  i++) {
        // 1.取出i位置对应的图片控件
        StatusImageView *child = self.subviews[i];
        
        // 2.i位置对应的图片控件 没有 图片
        if (i >= imageCount) {
            child.hidden = YES;
        } else {
            child.hidden = NO;
            
            // 只有一张配图
            if (imageCount == 1) {
                child.frame = CGRectMake(0, 0, kStatusOneImageWidth, kStatusOneImageHeight);
                
                child.contentMode = UIViewContentModeScaleAspectFit;
            } else {
                // 3.设置frame
                int divide = (imageCount == 4) ? 2 : 3;
                
                // 列数
                int column = i%divide;
                // 行数
                int row = i/divide;
                // 很据列数和行数算出x、y
                int childX = column * (kStatusImageWidth + kStatusImageMargin);
                int childY = row * (kStatusImageHeight + kStatusImageMargin);
                child.frame = CGRectMake(childX, childY, kStatusImageWidth, kStatusImageHeight);
                
                child.contentMode = UIViewContentModeScaleToFill;
            }
            
            // 4.设置图片url
            child.url = imageUrls[i][@"thumbnail_pic"];
        }
    }
}

+ (CGSize)imageSizeWithCount:(int)count{
    if (count == 1) return CGSizeMake(kStatusOneImageWidth, kStatusOneImageHeight);
    
    // 1.总行数
    int rows = (count + 2)/3;
    
    // 2.总高度
    CGFloat height = rows * kStatusImageHeight + (rows - 1) * kStatusImageMargin;
    
    // 3.总列数
    int columns = (count>=3) ? 3 : count;
    
    // 4.总宽度
    CGFloat width = columns * kStatusImageWidth + (columns - 1) * kStatusImageMargin;
    
    return CGSizeMake(width, height);
}
@end
