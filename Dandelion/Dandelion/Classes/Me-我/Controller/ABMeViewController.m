
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABMeViewController.h"
#import "ABSettingViewController.h"
#import "ABMeCell.h"
#import "ABMeFooterView.h"


@interface ABMeViewController ()

@end

@implementation ABMeViewController
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTable];
    
    [self setUpNav];
}

- (void)setUpTable
{
    self.view.backgroundColor = ABCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = ABMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(ABMargin - 35, 0, 0, 0);
    
    // 设置 footer
    self.tableView.tableFooterView = [[ABMeFooterView alloc] init];
    
}

- (void)setUpNav
{
    // 标题
    self.navigationItem.title = @"我的";
    
    // 右边-设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    // 右边-月亮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingClick
{
    ABLogFunc
    ABSettingViewController *test = [[ABSettingViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
    
}

- (void)moonClick
{
    ABLogFunc
}


#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标识
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    ABMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果空就手动创建
    if (!cell) {
        cell =  [[ABMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil; // 只要有其他cell设置过 imageview.image,其他不显示图片的 cell 都需要设置 imageview.image = nil
    }
      
    return cell;
}

@end
