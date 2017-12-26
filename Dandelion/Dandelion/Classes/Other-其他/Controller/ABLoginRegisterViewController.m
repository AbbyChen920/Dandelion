//
//  ABLoginRegisterViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/23.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABLoginRegisterViewController.h"

@interface ABLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation ABLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // 设置圆角
    self.loginButton.layer.cornerRadius = 5;
//    [self.loginButton setValue:@5 forKeyPath:@"layer.cornerRadius"];
//    
    self.loginButton.layer.masksToBounds = YES;
//   [self.loginButton setValue:@YES forKeyPath:@"layer.masksToBounds"];

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// 关闭当前界面
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//显示登录/注册界面
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
    // 退出键盘
    [self.view endEditing:YES];

    // 设置约束和按钮状态
    if (self.leftMargin.constant) { //目前显示的是注册界面,点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        sender.selected = NO;
//        [sender setTitle:@"注册账号" forState: UIControlStateNormal];
    }else{ //目前显示的是登录界面,点击按钮后要切换为注册界面
    
        self.leftMargin.constant = - self.view.ab_width;
        sender.selected = YES;
//        [sender setTitle:@"已有账号" forState: UIControlStateNormal];
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新:让最新设置的约束值马上应用到 UI 控件上
        // 会刷新到 self.view 内部的所有子控件
        [self.view layoutIfNeeded];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view endEditing:YES];
}

@end
