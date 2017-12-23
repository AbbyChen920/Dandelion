//
//  ABLoginRegisterViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/23.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABLoginRegisterViewController.h"

@interface ABLoginRegisterViewController ()

@end

@implementation ABLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
