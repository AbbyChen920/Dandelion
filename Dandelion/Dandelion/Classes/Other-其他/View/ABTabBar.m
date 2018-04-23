//
//  ABTabBar.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/7.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABTabBar.h"

@interface ABTabBar ()
@property (nonatomic,weak) UIButton *publishButton;
@end

@implementation ABTabBar

#pragma mark - 懒加载
-(UIButton *)publishButton
{
    if (!_publishButton) {
        // 增加一个发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        publishButton.backgroundColor = ABRandomColor;
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}


#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    
    return self;
}


// 布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];

    // 按钮的尺寸
    CGFloat buttonW = self.ab_width / 5;
    CGFloat buttonH = self.ab_height;
    
    
    /** 设置所有 UITabBarButton 的 frame */
    CGFloat tabBarButtonY = 0;
    // 按钮索引
    int  tabBarButtonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        
        //    NSClassFromString(@"UITabBarButton") == [UITabBarButton Class];
        //    NSClassFromString(@"UIButton") == [UIButton Class];
        
        // 过滤掉非UITabBarButton
        // if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)]) continue;
        
        // 设置 frame
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 2) { // 右边的2个UITabBarButton
            tabBarButtonX += buttonW;
        }
        
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        
        // 增加索引
        tabBarButtonIndex++;
    }
    
    
//    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    
    self.publishButton.ab_width = buttonW;
    self.publishButton.ab_height = buttonH;
    self.publishButton.center = CGPointMake(self.ab_width * 0.5, self.ab_height * 0.5);

}

#pragma mark - 监听

- (void)publishClick
{
    ABLogFunc;
    

    
}
@end
