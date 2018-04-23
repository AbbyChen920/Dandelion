//
//  AppDelegate.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/2.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "AppDelegate.h"
#import "ABTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

UIWindow *window_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    self.window.rootViewController = [[ABTabBarController alloc] init];
  
    // 显示窗口
    [self.window makeKeyAndVisible];
    
//    UIView *topView = [[UIView alloc] init];
//    topView.frame = CGRectMake(0, 0, 375, 20);
//    topView.backgroundColor = [UIColor redColor];
//    [topView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(topViewClick)]];
//    [self.window addSubview:topView];
    
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

    return YES;
}

- (void)topWindowClick
{
    // 主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 查找主窗口中的所有 scrollView
    [self findScrollViewsInView: window];
}

// 查找 view 中的所有 scrollView
- (void)findScrollViewsInView:(UIView *)view
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
