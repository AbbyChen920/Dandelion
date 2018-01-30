//
//  ABEssenceViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABEssenceViewController.h"
#import "ABTitleButton.h"


@interface ABEssenceViewController ()
// 当前选中的标题按钮
@property (nonatomic,weak) ABTitleButton *selectedTitleButton;

// 标题按钮底部的指示器的
@property (nonatomic,weak) UIView *indicatorView;

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
        ABTitleButton *titleButton = [ABTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置 frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
         
    }
    
    // 按钮的选中颜色
    ABTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.ab_height = 1;
    indicatorView.ab_y = titlesView.ab_height - indicatorView.ab_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
  
    // 立刻根据文字内容计算 label 的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.ab_width = firstTitleButton.titleLabel.ab_width;
    indicatorView.ab_centerX = firstTitleButton.ab_centerX;

    // 默认情况:选中最前面的标题按钮
//    [self titleClick:firstTitleButton];
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
    
}

- (void)setupNav
{
    self.view.backgroundColor = ABCommonBgColor;
    
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

#pragma mark - 监听点击
- (void)titleClick:(ABTitleButton *)titleButton
{
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;

    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        
        // 计算文字宽度
//        CGFloat titleW = [titleButton.currentTitle sizeWithFont:titleButton.titleLabel.font].width;
//        CGFloat titleW = [titleButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleButton.titleLabel.font}].width;
        
        
        self.indicatorView.ab_width = titleButton.titleLabel.ab_width;
        self.indicatorView.ab_centerX = titleButton.ab_centerX;

        ABLog(@"%f",self.indicatorView.ab_width);
    }];
}

- (void)tagClick
{
    ABLogFunc 
}

@end
