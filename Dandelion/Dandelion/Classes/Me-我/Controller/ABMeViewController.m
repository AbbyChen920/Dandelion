//
//  ABMeViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABMeViewController.h"
#import "ABTestViewController.h"


@interface ABMeViewController ()

@end

@implementation ABMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ABCommonBgColor;

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
    ABTestViewController *test = [[ABTestViewController alloc] init];
    test.view.backgroundColor = ABRandomColor;
    [self.navigationController pushViewController:test animated:YES];
    
}

- (void)moonClick
{
    ABLogFunc
}
@end
