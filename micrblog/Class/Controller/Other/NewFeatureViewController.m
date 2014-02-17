//
//  NewFeatureViewController.m
//  micrblog
//
//  Created by zhangping on 14-2-16.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "NewFeatureViewController.h"

#define kPageCount 4

@interface NewFeatureViewController (){
    UIPageControl *_pageControl;
    UIButton *_share;
}

@end

@implementation NewFeatureViewController

- (void)loadView{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.image = [UIImage fullscreenImageWithName:@"new_feature_background.png"];
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGSize viewSize = self.view.bounds.size;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = true;
    scrollView.contentSize = CGSizeMake(viewSize.width * kPageCount, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < kPageCount; i++) {
        [self addImageViewAtIndex:i inView:scrollView];
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.center = CGPointMake(viewSize.width / 2, viewSize.height * 0.9);
    
    _pageControl.bounds = CGRectMake(0, 0, 100, 0);
    _pageControl.numberOfPages = kPageCount;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
}

- (void)addImageViewAtIndex:(int)index inView:(UIView *)view{
    CGSize viewSize = self.view.frame.size;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = (CGRect){{index * viewSize.width}, viewSize};
    NSString *name = [NSString stringWithFormat:@"new_feature_%d.png", index + 1];
    imageView.image = [UIImage fullscreenImageWithName:name];
    [view addSubview:imageView];
    
    if (index == kPageCount - 1) {
        [self addButtonInView:imageView];
    }
}

- (void)addButtonInView:(UIView *)view{
    CGSize viewSize = self.view.frame.size;
    view.userInteractionEnabled = YES;
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:startButton];
    
    CGSize startSize = [startButton setAllStateBg:@"new_feature_finish_button.png"];
    startButton.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.83);
    
    startButton.bounds = (CGRect){CGPointZero, startSize};
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *share = [[UIButton alloc] init];
    [view addSubview:share];
    
    UIImage *normal = [UIImage imageNamed:@"new_feature_share_false.png"];
    [share setBackgroundImage:normal forState:UIControlStateNormal];
    [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
    
    share.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.75);
    share.bounds = (CGRect){CGPointZero, normal.size};
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    share.selected = YES;
    share.adjustsImageWhenHighlighted = NO;
    _share = share;
}

- (void)start{
    if (_startBlock) {
        _startBlock(_share.isSelected);
    }
}

- (void)share:(UIButton *)button{
    _share.selected = !_share.selected;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
