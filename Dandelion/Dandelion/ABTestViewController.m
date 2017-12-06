//
//  ABTestViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/7.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABTestViewController.h"

@interface ABTestViewController ()

@end

@implementation ABTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ABRandomColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
