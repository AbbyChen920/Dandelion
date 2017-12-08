//
//  ABFollowViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABFollowViewController.h"

@interface ABFollowViewController ()

@end

@implementation ABFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ABCommonBgColor;
    
    // 标题(不建议使用 self.title 属性)
    self.navigationItem.title = @"关注";
    // 左边
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)followClick
{
    ABLogFunc
}

@end
