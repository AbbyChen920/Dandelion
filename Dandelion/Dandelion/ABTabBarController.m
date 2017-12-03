//
//  ABTabBarController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/3.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABTabBarController.h"
#import "UIImage+ABImage.h"
@interface ABTabBarController ()

@end

@implementation ABTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**  TabBarItem文字属性    **/
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

    // 添加子控制器
    [self setUpOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpOneChildViewController:[[UITableViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

}

/* 初始化一个子控制器
 vc:子控制器
 title:标题
 image:图标
 selectedImage:选中的图标
 */

- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    vc.view.backgroundColor = [UIColor grayColor];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName :selectedImage];
    [self addChildViewController:vc];
 
}

@end
