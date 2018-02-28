//
//  ABRefreshHeader.m
//  Dandelion
//
//  Created by 陈芬 on 18/2/28.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABRefreshHeader.h"

@interface ABRefreshHeader ()

@property (nonatomic,weak) UIImageView *logo;

@end

@implementation ABRefreshHeader

/*
   初始化
 */
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor blueColor];
    
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    
    
    //    mj_header.lastUpdatedTimeLabel.hidden = YES;
    //    mj_header.stateLabel.hidden = YES;
    //    mj_header.arrowView.hidden = YES;
    //    [mj_header addSubview:[[UISwitch alloc] init]];

    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"bd_logo1"];
    [self addSubview:logo];
    self.logo = logo;
}

// 摆放子控件
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.ab_width = self.ab_width;
    self.logo.ab_height = 50;
    self.logo.ab_x = 0;
    self.logo.ab_y = -50;
    
}


@end
