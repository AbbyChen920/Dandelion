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
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ABTest1ViewController *test1 = [[ABTest1ViewController alloc] init];
    test1.view.backgroundColor = ABRandomColor;
    [self.navigationController pushViewController:test1 animated:YES];
    
}

@end
