//
//  ABEssenceViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABEssenceViewController.h"

@interface ABEssenceViewController ()

@end

@implementation ABEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ABCommonBgColor;
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.image = [UIImage imageNamed:@"MainTitle"];
//    [imageView sizeToFit];
//    self.navigationItem.titleView = imageView;
    
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}
  
- (void)tagClick
{
    ABLogFunc
}



@end
