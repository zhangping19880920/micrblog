//
//  HomeViewController.m
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "SendStatusViewController.h"
#import "Status.h"
#import "StatusTool.h"
#import "MJRefresh.h"
#import "StatusCell.h"
#import "StatusCellFrame.h"

@interface HomeViewController () <MJRefreshBaseViewDelegate> {
    NSMutableArray *_statuses;
    NSMutableArray *_statusCellFrames;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = self.tableView;
    [_header beginRefreshing];
    
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = self.tableView;
    
    
    // 1.标题
    self.title = @"首页";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" target:self action:@selector(sendStatus)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" target:self action:@selector(popMenu)];
    
    _statuses = [NSMutableArray array];
    _statusCellFrames = [NSMutableArray array];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if (_header == refreshView) {
        // 下拉刷新
        [self refreshData];
    }else{
        [self loadMoreData];
    }
}

#pragma mark 下拉刷新要做的事情,更新最新的信息
- (void)refreshData{
    NSString *sinceId = nil;
    if (_statuses.count) {
        Status *first = _statuses[0];
        sinceId = first.idstr;
    }
    [StatusTool statusesWithSinceId:sinceId maxId:nil success:^(NSMutableArray *statuses) {
        // 0.告诉用户一共刷新了多少条新的微博
        [self showNewStatusCount:statuses.count];
        
        [statuses addObjectsFromArray:_statuses];
        _statuses = statuses;
        
        [self.tableView reloadData];
        
        [_header endRefreshing];
    } fail:^{
        [_header endRefreshing];
    }];
}

- (void)showNewStatusCount:(int) count{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    [button setBackgroundImage:[UIImage stretchImageWithName:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat buttonWidth = self.view.frame.size.width;
    CGFloat buttonHeight = 44;
    button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    [self.navigationController.view insertSubview:button belowSubview:self.navigationController.navigationBar];
    
    NSString *title = @"没有新的micrblog";
    if (count) {
        title = [NSString stringWithFormat:@"共有%d条micrbolg", count ];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        button.transform = CGAffineTransformMakeTranslation(0, buttonHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [button removeFromSuperview];
        }];
    }];
}

- (void)loadMoreData{
    NSString *maxId = nil;
    if (_statuses.count) {
        Status *last = [_statuses lastObject];
        long long lasVal = [last.idstr longLongValue];
        lasVal --;
        maxId = [NSString stringWithFormat:@"%lld", lasVal];
    }
    
    [StatusTool statusesWithSinceId:nil maxId:maxId success:^(NSMutableArray *statuses) {
        [_statuses addObjectsFromArray:statuses];
        [self.tableView reloadData];
        
        [_footer endRefreshing];
    } fail:^{
        [_footer endRefreshing];
    }];
}

- (void)popMenu{
    Loger(@"popMenu");
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Loger(@"_statuses.count = %d", _statuses.count);
    return _statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.statusCellFrame = _statusCellFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusCellFrame *frame = [[StatusCellFrame alloc] init];
    frame.status = _statuses[indexPath.row];
    [_statusCellFrames addObject:frame];
    return frame.cellHeight;
}

- (void)sendStatus{
    SendStatusViewController *send = [[SendStatusViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:send];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
