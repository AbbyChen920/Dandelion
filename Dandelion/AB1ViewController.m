//
//  AB1ViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/2.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "AB1ViewController.h"

@interface AB1ViewController ()

@end

@implementation AB1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tab = [[UITableView alloc] init];
    tab.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:tab];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
