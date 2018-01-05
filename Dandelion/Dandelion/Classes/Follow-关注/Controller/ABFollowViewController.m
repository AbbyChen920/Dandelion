//
//  ABFollowViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABFollowViewController.h"
#import "ABRecommendFollowViewController.h"
#import "ABLoginRegisterViewController.h"

@interface ABFollowViewController ()

@property (nonatomic,weak) UITextField *textField;

@end

@implementation ABFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ABCommonBgColor;
    
    // 标题(不建议使用 self.title 属性)
    self.navigationItem.title = @"关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];

    UITextField *textField = [[UITextField alloc] init];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    textField.frame = CGRectMake(100, 100, 150, 25);
//    [textField setValue:[UIColor redColor] forKeyPath:@"placeholderLabel.textColor"];
    
    textField.placeholder = @"请输入手机号";
    
    textField.placeholderColor = [UIColor orangeColor];

    // 打印出来的是默认的灰色的颜色
//    NSLog(@"%@ %@",[UIColor colorWithRed:0.5 green:0.1 blue:0.2 alpha:0.4], textField.placeholderColor);

    [self.view addSubview:textField];
    self.textField = textField;


    // 做对比 (对比灰色是否一致)
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.backgroundColor = [UIColor whiteColor];
    textField2.frame = CGRectMake(100, 300, 150, 25);
    textField2.placeholder = @"请输入手机号";
    [self.view addSubview:textField2];
    
}

- (IBAction)loginRegister {
    
    self.textField.placeholderColor = nil;
    
    NSLog(@"%@",self.textField.placeholderColor); //本来是 nil,但打印出来是有值的,因为在调用方法的时候,判断如果是 nil,就会给其赋值/懒加载.
    
//    ABLoginRegisterViewController *loginRegister = [[ABLoginRegisterViewController alloc] init];
//    
//    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)followClick
{
    ABLogFunc
    
    ABRecommendFollowViewController *test = [[ABRecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
}

@end
