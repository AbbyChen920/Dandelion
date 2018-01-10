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

    
}

- (IBAction)loginRegister {
    
    
    
//    NSLog(@"%@",self.textField.placeholderColor); //本来是 nil,但打印出来是有值的,因为在调用方法的时候,判断如果是 nil,就会给其赋值/懒加载.
    
    ABLoginRegisterViewController *loginRegister = [[ABLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)followClick
{
    ABLogFunc
    
    ABRecommendFollowViewController *test = [[ABRecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
}

@end
