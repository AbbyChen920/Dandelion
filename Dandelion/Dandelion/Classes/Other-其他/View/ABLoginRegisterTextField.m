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

@interface ABLoginRegisterTextField() <UITextFieldDelegate>

@end

@implementation ABLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 设置默认的占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
    
    self.delegate = self;
   
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setValue:[UIColor whiteColor] forKeyPath:ABPlaceholderColorKey];

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];

}

@end
