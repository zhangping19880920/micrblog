//
//  MoreViewController.m
//  weibo
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    NSArray *_data;
}
@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.标题
    self.title = @"更多";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"more" withExtension:@"plist"];
    _data = [NSDictionary dictionaryWithContentsOfURL:url][@"zh_CN"];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kGlobalBg;
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(10, 5, 300, 40);
    exitButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    NSString *text = [_data lastObject][0][@"name"];
    [exitButton setAllStateBg:@"common_button_red.png"];
    [exitButton setTitle:text forState:UIControlStateNormal];
    
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, 0, 70);
    [footer addSubview:exitButton];
    self.tableView.tableFooterView = footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _data[section];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        Loger(@"create");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.highlightedTextColor = cell.textLabel.textColor;
        UIImageView *bg = [[UIImageView alloc] init];
        cell.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        cell.selectedBackgroundView = selectedBg;
    }
    cell.textLabel.text = _data[indexPath.section][indexPath.row][@"name"];
    
    UIImageView *bg = (UIImageView *)cell.backgroundView;
    UIImageView *selectedBg = (UIImageView *)cell.selectedBackgroundView;
    
    NSArray *sectionArr = _data[indexPath.section];
    int count = sectionArr.count;
    NSString *name = nil;
    if (1 == count) {
        name = @"common_card_background.png";
    }else if (0 == indexPath.row){
        name = @"common_card_top_background.png";
    }else if (count - 1 == indexPath.row){
        name = @"common_card_bottom_background.png";
    }else{
        name = @"common_card_middle_background.png";
    }
    bg.image = [UIImage stretchImageWithName:name];
    selectedBg.image = [UIImage stretchImageWithName:[name filenameAppend:@"_highlighted"]];
    
    if (2 == indexPath.section) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.bounds = CGRectMake(0, 0, 100, 30);
        label.text = (0 == indexPath.row)? @"有图模式" : @"经典主题";
        cell.accessoryView = label;
    }else{
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
    }
    return cell;
}

- (void)exit{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定退出此账号" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"destructive" otherButtonTitles:@"123", @"456", nil];
    
    [sheet showInView:self.view.window];
}

- (void)setting{
    Loger(@"setting");
}

@end
