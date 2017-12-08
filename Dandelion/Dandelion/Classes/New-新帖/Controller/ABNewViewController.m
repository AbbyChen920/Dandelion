//
//  ABNewViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABNewViewController.h"

@interface ABNewViewController ()

@end

@implementation ABNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor = ABCommonBgColor;
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 左边
    self.navigationItem.leftBarButtonItem = [ABItemManager itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

- (void)tagClick
{
    ABLogFunc
}


@end
