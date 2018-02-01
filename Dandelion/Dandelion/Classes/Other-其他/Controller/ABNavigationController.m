//
//  ABNavigationController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/9.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABNavigationController.h"

@interface ABNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation ABNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

/*
 重写push方法的目的:拦截所有push进来的子控制器
 viewController: 刚刚push进来的子控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {//如果viewController不是最早 push 进来的控制器
        // 左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        // 这句代码写在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 所有设置搞定之后,再 push 控制器
    [super pushViewController:viewController animated:YES];

}


//-(UIViewController *)popViewControllerAnimated:(BOOL)animated
//{
//    return [super popViewControllerAnimated:NO];
//}
//
//// 如果想全世界的pop 都没有动画,那在下面的几个方法中也设置下Animated:NO
//- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    return [super popToViewController:viewController animated:NO];
//    
//}
//-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
//{
//    return [super popToRootViewControllerAnimated:NO];
//}
//
- (void)back
{
    [self popViewControllerAnimated:YES];
}


#pragma mark - UIGestureRecognizerDelegate
/*
 手势识别器对象会调用这个代理方法来决定是否有效
 
 @return YES:手势有效;  NO: 手势无效
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//    if (self.childViewControllers.count == 1) { //导航控制器中只有1个子控制器
//        return NO;
//    }
//    return YES;
    
    // 手势何时有效:当导航控制器的子控制器个数>1时候有效
    return self.childViewControllers.count > 1;
}

@end
