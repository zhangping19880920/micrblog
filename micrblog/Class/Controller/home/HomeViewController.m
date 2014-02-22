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

/*
 1.BarButtonItem需要显示图片
 initWithCustomView
 
 2.BarButtonItem只是显示文字
 initWithTitle
 */

@interface HomeViewController (){
    NSMutableArray *_statuses;
}

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.标题
    self.title = @"首页";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" target:self action:@selector(sendStatus)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" target:self action:@selector(popMenu)];
    
    _statuses = [NSMutableArray array];
    [StatusTool statusesWithSinceId:nil maxId:nil success:^(NSMutableArray *statuses) {
        [_statuses addObjectsFromArray:statuses];
        
        [self.tableView reloadData];
    } fail:nil];
    
}

- (void)popMenu{
    Loger(@"popMenu");
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Status *s = _statuses[indexPath.row];
    cell.textLabel.text = s.text;
    
    return cell;
}

- (void)sendStatus{
    SendStatusViewController *send = [[SendStatusViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:send];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
