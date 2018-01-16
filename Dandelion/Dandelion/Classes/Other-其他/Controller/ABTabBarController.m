//
//  ABTabBarController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/3.
//  Copyright © 2017年 陈芬. All rights reserved.
//
#import "ABTabBarController.h"
#import "UIImage+ABImage.h"
#import "ABTabBar.h"
#import "ABEssenceViewController.h"
#import "ABNewViewController.h"
#import "ABFollowViewController.h"
#import "ABMeViewController.h"
#import "ABNavigationController.h"


@interface ABTabBarController ()

@end

@implementation ABTabBarController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**  设置所有 UITabBarItem 的文字属性    **/
    [self setupItemTitleTextAttributes];
    
    // 添加子控制器
    [self setupChildViewControllers];
 
    // 更换TabBar
    [self setupTabBar];
}


/**  设置所有 UITabBarItem 的文字属性    **/
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 设置普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 设置选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

// 添加子控制器
- (void)setupChildViewControllers
{
    [self setUpOneChildViewController:[[ABNavigationController alloc] initWithRootViewController:[[ABMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setUpOneChildViewController:[[ABNavigationController alloc] initWithRootViewController:[[ABFollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpOneChildViewController:[[ABNavigationController alloc] initWithRootViewController:[[ABEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpOneChildViewController:[[ABNavigationController alloc] initWithRootViewController:[[ABNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];

}

// 更换TabBar
- (void)setupTabBar
{
    [self setValue:[[ABTabBar alloc] init] forKeyPath:@"tabBar"];
 }

// 为什么要在viewWillAppear方法中添加发布按钮?
// 当viewWillAppear方法被调用的时候, tabbar 内部已经添加了5个 UITabBarButton
// 就可以实现一个效果:[发布按钮]盖在其他UITabBarButton上面
// 注意:viewWillAppear可能会被调用多次,这样按钮就会被加载多次,会创建很多按钮
// 解决方法: 1> dispatch_once       2>懒加载
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [self.tabBar addSubview:self.publishButton];
//}



/* 初始化一个子控制器
 vc:子控制器
 title:标题
 image:图标
 selectedImage:选中的图标
 */

- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    vc.tabBarItem.title = title;
    if (image.length) { //图片名有具体值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName :selectedImage];
    }
    [self addChildViewController:vc];

}



@end
