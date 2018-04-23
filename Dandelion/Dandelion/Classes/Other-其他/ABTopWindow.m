//
//  ABTopWindow.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/23.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTopWindow.h"

@implementation ABTopWindow

UIWindow *window_;

+ (void)show
{
    // 状态栏是有级别的,级别顺序如下, 同级别的话就看谁后添加就先显示谁
    // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        window_ = [[UIWindow alloc] init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        window_.backgroundColor = [UIColor orangeColor];
        window_.windowLevel = UIWindowLevelAlert;
        window_.hidden = NO;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}


+ (void)topWindowClick
{
    // 主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 查找主窗口中的所有 scrollView
    [self findScrollViewsInView: window];
}


// 查找 view 中的所有 scrollView
+ (void)findScrollViewsInView:(UIView *)view
{
    // 利用递归查找所有的子控件
    for (UIView *subview in view.subviews) {
        [self findScrollViewsInView:subview];
    }
    
    // 如果不是 scrollView
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    // 判断是否跟 window 有重叠
    if (![view intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    
    //    CGRect windowRect = [UIApplication sharedApplication].keyWindow.bounds;
    //    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    //    // 跟 window 不重叠
    //    if (!CGRectIntersectsRect(windowRect, viewRect)) return;
    
    // 如果是 scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    
    // 修改 offset
    CGPoint offset = scrollView.contentOffset;
    offset.y = - scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    
    
    //    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
}

@end
