//
//  Dock.m
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"
@interface Dock(){
    // 当前选中了哪个item
    DockItem *_currentItem;
}
@end


@implementation Dock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    }
    return self;
}

-(void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title{
    DockItem *item = [DockItem buttonWithType:UIButtonTypeCustom];
    [self addSubview:item];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:[icon filenameAppend:@"_selected"]] forState:UIControlStateSelected];
    
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    [self adjustDockItemsFrame];
}

- (void)itemClick:(DockItem *)item{
    _currentItem.selected = NO;
    item.selected = YES;
    _currentItem = item;
    if (_itemClickBlock) {
        _itemClickBlock(item.tag);
    }
}

- (void)adjustDockItemsFrame{
    int subViewCount = self.subviews.count;
    CGFloat itemWidth = self.frame.size.width / subViewCount;
    CGFloat itemHeight = self.frame.size.height;
    
    for (int i = 0; i < subViewCount; i++) {
        DockItem *item = self.subviews[i];
        item.frame = CGRectMake(i * itemWidth, 0, itemWidth, itemHeight);
        item.tag = i;
    }
}

-(void)setSelectedIndex:(int)selectedIndex{
    if (selectedIndex < 0 || selectedIndex >= self.subviews.count) return;
    _selectedIndex = selectedIndex;
    DockItem *item = self.subviews[_selectedIndex];
    [self itemClick:item];
}

@end
