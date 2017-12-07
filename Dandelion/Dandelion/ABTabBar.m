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

// 布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];

    
    //    NSClassFromString(@"UITabBarButton") == [UITabBarButton Class];
    //    NSClassFromString(@"UIButton") == [UIButton Class];
    
    /** 设置所有 UITabBarButton 的 frame */
    // 按钮的尺寸
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    // 按钮索引
    int buttonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        
        // 过滤掉非UITabBarButton
        // if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)]) continue;
        
        // 设置 frame
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) { // 右边的2个UITabBarButton
            buttonX += buttonW;
        }
        
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        buttonIndex++;
    }
    
    
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);

}



#pragma mark - 监听
- (void)publishClick
{
    ABLogFunc;

    
}
@end
