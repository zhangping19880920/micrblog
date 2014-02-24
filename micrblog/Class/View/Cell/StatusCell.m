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

@interface StatusCell (){
    /*
     本身的子控件
     */
    // 1.头像
    UIImageView *_icon;
    
    // 2.昵称
    UILabel *_screenName;
    
    // 3.会员图标
    UIImageView *_mbIcon;
    
    // 4.时间
    UILabel *_time;
    
    // 5.来源
    UILabel *_source;
    
    // 6.正文
    UILabel *_content;
    
    // 7.配图
    UIImageView *_image;
    
    /*
     转发的子控件
     */
    // 1.转发的整体结构
    UIImageView *_retweet;
    
    // 2.昵称
    UILabel *_retweetScreenName;
    
    // 3.正文
    UILabel *_retweetContent;
    
    // 4.配图
    UIImageView *_retweetImage;
}

@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBg];
        [self addStatusSubviews];
        [self addRetweetStatusSubviews];
        [self addOtherSubviews];
    }
    return self;
}

- (void)setBg{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage stretchImageWithName:@"common_card_background.png"];
    self.backgroundView = bg;
    
    UIImageView *sBg = [[UIImageView alloc] init];
    sBg.image = [UIImage imageNamed:@"common_card_background_highlighted.png"];
    self.selectedBackgroundView = sBg;
}

- (void)addStatusSubviews{
    _icon = [[UIImageView alloc] init];
    _icon.layer.cornerRadius = 5;
    _icon.layer.masksToBounds = YES;
    [self.contentView addSubview:_icon];
    
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    _mbIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_mbIcon];
    
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kTimeColor;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont;
    _source.textColor = kSourceColor;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    _content = [[UILabel alloc] init];
    _content.font = kContentFont;
    _content.textColor = kContentColor;
    _content.numberOfLines = 0;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];
    
}

- (void)addRetweetStatusSubviews{
    _retweet = [[UIImageView alloc] init];
    [self.contentView addSubview:_retweet];
    
    _retweetScreenName = [[UILabel alloc] init];
    _retweetScreenName.font = kRetweetScreenNameFont;
    _retweetScreenName.textColor = kRetweetScreenNameColor;
    _retweetScreenName.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetScreenName];
    
    _retweetContent = [[UILabel alloc] init];
    _retweetContent.font = kRetweetContentFont;
    _retweetContent.textColor = kRetweetContentColor;
    _retweetContent.numberOfLines = 0;
    _retweetContent.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetContent];
    
    _retweetImage = [[UIImageView alloc] init];
    [_retweet addSubview:_retweetImage];
}

- (void)addOtherSubviews{
    
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame{
    _statusCellFrame = statusCellFrame;
    Status * status = statusCellFrame.status;
    User *user = status.user;
    
    _icon.frame = statusCellFrame.icon;
    [_icon setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    _screenName.frame = statusCellFrame.screenName;
    _screenName.text = user.screenName;
    
    if (user.mbtype == MBTypeNone) {
        _mbIcon.hidden = YES;
        
    } else {
        _mbIcon.hidden = NO;
    }
    _screenName.textColor = kScreenNameColor;
    
    _mbIcon.frame = statusCellFrame.mbIcon;
    _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    
    _time.frame = statusCellFrame.time;
    _time.text = status.createdAt;
    
    _source.frame = statusCellFrame.source;
    _source.text = status.source;
    
    _content.frame = statusCellFrame.content;
    _content.text = status.text;
    
    _image.frame = statusCellFrame.image;
    
    _retweet.frame = statusCellFrame.retweet;
    UIImage *retweetImage = [UIImage imageNamed:@"timeline_retweet_background.png"];
    retweetImage = [retweetImage stretchableImageWithLeftCapWidth:retweetImage.size.width * 0.9 topCapHeight:retweetImage.size.height * 0.5];
    _retweet.image = retweetImage;
    
    // 2.昵称
    _retweetScreenName.frame = statusCellFrame.retweetScreenName;
    _retweetScreenName.text = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
    
    // 3.正文
    _retweetContent.frame = statusCellFrame.retweetContent;
    _retweetContent.text = status.retweetedStatus.text;
    
    // 4.配图
    _retweetImage.frame = statusCellFrame.retweetImage;
}
@end
