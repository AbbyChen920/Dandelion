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

    [self setupNav];

    [self setupScrollView];
    
    [self setupTitlesView];
    
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = ABRandomColor;
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
}

- (void)setupTitlesView
{
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    titlesView.frame = CGRectMake(0, 64, self.view.ab_width, 35);
    [self.view addSubview:titlesView];
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.ab_width / count;
    CGFloat titleButtonH = titlesView.ab_height;
    for (NSUInteger i = 0; i <count; i++) {
        // 创建
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置 frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
}

- (void)setupNav
{
    self.view.backgroundColor = ABCommonBgColor;
    
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}


- (void)titleClick:(UIButton *)titleButton
{
    ABLogFunc
}

- (void)tagClick
{
    ABLogFunc 
}



@end
