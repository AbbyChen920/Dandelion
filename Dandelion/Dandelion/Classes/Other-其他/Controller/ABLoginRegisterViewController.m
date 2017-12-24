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

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
