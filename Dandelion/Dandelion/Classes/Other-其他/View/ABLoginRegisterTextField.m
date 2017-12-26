//
//  ABLoginRegisterTextField.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/26.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABLoginRegisterTextField.h"

@implementation ABLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    self.textColor = [UIColor redColor]; 
}

@end
