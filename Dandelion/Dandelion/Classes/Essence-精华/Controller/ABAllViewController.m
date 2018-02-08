//
//  ABAllViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/30.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABAllViewController.h"

@interface ABAllViewController ()

@end

@implementation ABAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    ABLogFunc
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    // 1.确定重用标识
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果是空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = ABRandomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd",[self class], indexPath.row];
    
    return cell;
   
}

@end
