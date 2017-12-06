//
//  ABTabBarController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/3.
//  Copyright © 2017年 陈芬. All rights reserved.
//
#import "ABTabBarController.h"
#import "UIImage+ABImage.h"
#import "ABTestViewController.h"

@interface ABTabBarController ()
@property (nonatomic,strong) UIButton *publishButton;

@end

@implementation ABTabBarController
#pragma mark - 懒加载
-(UIButton *)publishButton
{
    if (!_publishButton) {
        // 增加一个发布按钮
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishButton.backgroundColor = ABRandomColor;
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        _publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height);
        _publishButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

#pragma mark - 初始化
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

    // 中间用来占位的子控制器
    [self setUpOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    // 中间的发布按钮
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:nil image:nil selectedImage:nil];
  
    
    [self setUpOneChildViewController:[[UITableViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    ABLog(@"%@",self.tabBar.subviews);
    
   
}

// 为什么要在viewWillAppear方法中添加发布按钮?
// 当viewWillAppear方法被调用的时候, tabbar 内部已经添加了5个 UITabBarButton
// 就可以实现一个效果:[发布按钮]盖在其他UITabBarButton上面
// 注意:viewWillAppear可能会被调用多次,这样按钮就会被加载多次,会创建很多按钮
// 解决方法: 1> dispatch_once       2>懒加载
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBar addSubview:self.publishButton];
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        // 增加一个发布按钮
//        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        publishButton.backgroundColor = ABRandomColor;
//        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
//        publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height);
//        publishButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
//        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:publishButton];
//    });
   

}



/* 初始化一个子控制器
 vc:子控制器
 title:标题
 image:图标
 selectedImage:选中的图标
 */

- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor = ABRandomColor;
    vc.tabBarItem.title = title;
    if (image.length) { //图片名有具体值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName :selectedImage];
    }
    [self addChildViewController:vc];

}

#pragma mark - 监听
- (void)publishClick
{
    ABLogFunc;
    ABTestViewController *testVc = [[ABTestViewController alloc] init];
    [self presentViewController:testVc animated:YES completion:nil];

}

@end
