//
//  UITextField+ABExtension.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/5.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "UITextField+ABExtension.h"

static NSString * const ABPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (ABExtension)

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    

    NSString *oldPlaceHolder = self.placeholder;
    self.placeholder = @" ";// 提前设置占位文字,目的:让它提前创建placeholderLabel
    self.placeholder = oldPlaceHolder;
   
    if (placeholderColor == nil) { //恢复到默认的占位文字颜色
    
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:ABPlaceholderColorKey];
}

//
//-(void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    // 提前设置占位文字,目的:让它提前创建placeholderLabel
//    if (self.placeholder.length == 0) {
//        self.placeholder = @" ";
//    }
//    
//    [self setValue:placeholderColor forKeyPath:ABPlaceholderColorKey];
//}

-(UIColor *)placeholderColor
{
    return [self valueForKeyPath:ABPlaceholderColorKey];
}

@end
