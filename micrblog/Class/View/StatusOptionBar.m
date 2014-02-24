//
//  StatusOptionBar.m
//  micrblog
//
//  Created by zhangping on 14-2-24.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "StatusOptionBar.h"
#import "Status.h"

#define kBtnTag 99
#define kBtnTextColor kGetColor(147, 147, 147)

@implementation StatusOptionBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.背景图片
        self.image = [UIImage stretchImageWithName:@"timeline_card_bottom.png"];
        
        // 2.添加子控件
        // 顶部的分隔线
        [self addDivider];
        // 转发
        [self addBtnWithTitle:@"转发" icon:@"timeline_icon_retweet.png" index:0 bg:@"timeline_card_leftbottom.png"];
        // 评论
        [self addBtnWithTitle:@"评论" icon:@"timeline_icon_comment.png" index:1 bg:@"timeline_card_middlebottom.png"];
        // 赞
        [self addBtnWithTitle:@"赞" icon:@"timeline_icon_unlike.png" index:2 bg:@"timeline_card_rightbottom.png"];
    }
    return self;
}

#pragma mark 添加分隔线
- (void)addDivider
{
    UIView *topDivider = [[UIView alloc] init];
    CGFloat topDividerX = 2;
    CGFloat topDividerHeight = 0.5;
    CGFloat topDividerWidth = self.frame.size.width - 2 * topDividerX;
    topDivider.frame = CGRectMake(topDividerX, -topDividerHeight * 0.5, topDividerWidth, topDividerHeight);
    topDivider.backgroundColor = kGetColor(200, 200, 200);
    [self addSubview:topDivider];
}

- (void)setStatus:(Status *)status
{
    _status = status;
    
    // 设置转发数
    [self setBntTitleAtIndex:0 placeholder:@"转发" count:status.repostsCount];
    // 设置评论数
    [self setBntTitleAtIndex:1 placeholder:@"评论" count:status.commentsCount];
    // 设置赞数
    [self setBntTitleAtIndex:2 placeholder:@"赞" count:status.attitudesCount];
}

#pragma mark 设置按钮的文字
- (void)setBntTitleAtIndex:(int)index placeholder:(NSString *)placeholder count:(int)count
{
    UIButton *btn = (UIButton *)[self viewWithTag:kBtnTag + index];
    if (count == 0) {
        [btn setTitle:placeholder forState:UIControlStateNormal];
    } else if (count%10000 == 0) { // 整万
        NSString *title = [NSString stringWithFormat:@"%d万", count/10000];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 非整万
        double result = (count / 1000) * 0.1;
        
        NSString *title = nil;
        if (((int)result) == 0) { // 不超过1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 超过1W
            title = [NSString stringWithFormat:@"%.1f万", result];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark 添加一个按钮
- (void)addBtnWithTitle:(NSString *)title icon:(NSString *)icon index:(int)index bg:(NSString *)bg;
{
    CGSize size = self.frame.size;
    CGFloat btnWidth = size.width / 3;
    CGFloat btnX = index * btnWidth;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setAllStateBg:bg];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitleColor:kBtnTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(btnX, 0, btnWidth, size.height);
    
    btn.tag = index + kBtnTag;
    
    // 设置标题的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 0, 0);
    
    [self addSubview:btn];
    
    
    // 后面两个按钮 前面 添加分隔线
    if (index > 0) {
        UIImage *image = [UIImage imageNamed:@"timeline_card_bottom_line.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:image];
        divider.center = CGPointMake(btnX, size.height * 0.5);
        [self addSubview:divider];
    }
}

@end
