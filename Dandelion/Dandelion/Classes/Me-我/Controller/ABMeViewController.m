//
//  ABMeViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABMeViewController.h"

@interface ABMeViewController ()

@end

@implementation ABMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ABCommonBgColor;

    // 标题
    self.navigationItem.title = @"我的";
    
    // 右边-设置
    UIBarButtonItem *settingItem = [ABItemManager itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];

    // 右边-月亮
    UIBarButtonItem *moonItem = [ABItemManager itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];

}

- (void)settingClick
{
    ABLogFunc
}

- (void)moonClick
{
    ABLogFunc
}
@end
