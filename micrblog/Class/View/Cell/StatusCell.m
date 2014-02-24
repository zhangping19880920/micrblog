//
//  StatusCell.m
//  micrblog
//
//  Created by zhangping on 14-2-23.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "IconView.h"
#import "StatusImageListView.h"
#import "StatusOptionBar.h"

@interface StatusCell (){
    /*
     操作条
     */
    StatusOptionBar *_option;
}

@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addOtherSubviews];
    }
    return self;
}

#pragma mark 添加其他
- (void)addOtherSubviews
{
    // 1.操作条
    CGFloat height = kStatusOptionBarHeight;
    CGFloat y = self.frame.size.height - height;
    CGRect frame = CGRectMake(0, y, self.frame.size.width, height);
    _option = [[StatusOptionBar alloc] initWithFrame:frame];
    // 伸缩跟父控件顶部的距离，其他间距都是固定
    _option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_option];
    
    // 2.更多
    CGFloat btnWidth = 40;
    CGFloat btnHeight = 40;
    CGFloat btnX = self.frame.size.width - btnWidth;
    CGFloat btnY = 0;
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more.png"] forState:UIControlStateNormal];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted.png"] forState:UIControlStateHighlighted];
    more.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self.contentView addSubview:more];
}

- (void)unHighlightSubviews:(UIView *)parent
{
    NSArray *views = parent.subviews;
    
    for (UIButton *child in views) {
        if ([child respondsToSelector:@selector(setHighlighted:)]) {
            child.highlighted = NO;
        }
        
        [self unHighlightSubviews:child];
    }
}

#pragma mark 覆盖高亮显示的方法
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    // 调用super是为了让cell保持高亮状态
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        [self unHighlightSubviews:self.contentView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // 调用super是为了让cell保持高亮状态
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self unHighlightSubviews:self.contentView];
    }
}

- (void)setBaseFrame:(BaseFrame *)baseFrame
{
    [super setBaseFrame:baseFrame];
    
    /*
     操作条
     */
    _option.status = baseFrame.status;
}
@end
