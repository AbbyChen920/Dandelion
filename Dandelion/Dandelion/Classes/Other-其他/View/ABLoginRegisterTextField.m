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
    
    // 设置占位文字的颜色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
    
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    attributes[NSBackgroundColorAttributeName] = [UIColor redColor];
//    attributes[NSUnderlineStyleAttributeName] = @YES;
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
//    // 设置属性
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    [string setAttributes:attributes range:NSMakeRange(0, 1)];
//    
//    NSMutableDictionary *attributes2 = [NSMutableDictionary dictionary];
//    attributes2[NSBackgroundColorAttributeName] = [UIColor redColor];
//    attributes2[NSUnderlineStyleAttributeName] = @1;
//    [string setAttributes:attributes2 range:NSMakeRange(1, 1)];
//    
//    self.attributedPlaceholder = string;
    
}

@end
