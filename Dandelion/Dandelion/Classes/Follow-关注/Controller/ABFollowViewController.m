//
//  ABFollowViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABFollowViewController.h"
#import "ABRecommendFollowViewController.h"

@interface ABFollowViewController ()

@end

@implementation ABFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ABCommonBgColor;
    
    // 标题(不建议使用 self.title 属性)
    self.navigationItem.title = @"关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
}

- (void)followClick
{
    ABLogFunc
    
    ABRecommendFollowViewController *test = [[ABRecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
}

@end
