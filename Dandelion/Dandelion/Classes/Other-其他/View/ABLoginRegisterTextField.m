//
//  ABLoginRegisterTextField.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/26.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABLoginRegisterTextField.h"
#import <objc/runtime.h>

static NSString * const ABPlaceholderColorKey = @"placeholderLabel.textColor";

@interface ABLoginRegisterTextField()

@end

@implementation ABLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 设置默认的占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
    self.placeholderColor = [UIColor grayColor];

}


//调用时刻: 成为第一响应者: 开始编辑\弹出键盘\获得焦点
-(BOOL)becomeFirstResponder
{
//    [self setValue:[UIColor whiteColor] forKeyPath:ABPlaceholderColorKey];
    self.placeholderColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}

//调用时刻: 不做第一响应者: 结束编辑\退出键盘\失去焦点
-(BOOL)resignFirstResponder
{
//    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
}
@end
