//
//  ABTestViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/9.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABTestViewController.h"
#import "ABTest1ViewController.h"

@interface ABTestViewController ()

@end

@implementation ABTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = ABCommonBgColor;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ABTest1ViewController *test1 = [[ABTest1ViewController alloc] init];
    
    [self.navigationController pushViewController:test1 animated:YES];
    
}

@end
