//
//  Dock.h
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dock : UIView
// 添加一个选项卡（图标、文字标题）
- (void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title;

@property (nonatomic, copy) void (^itemClickBlock)(int index);

// 不要求掌握
@property (nonatomic, assign) int selectedIndex;
@end
