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
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
 
}

#pragma mark - 重写
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(0, 0, 40, 10);
//}


-(void)drawPlaceholderInRect:(CGRect)rect
{
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = self.font;
    
    
    // 方法中的rect参数就是文本框的 rect
    // NSLog(@"%@", NSStringFromCGRect(rect));
    // 2017-12-29 17:59:35.956 Dandelion[8928:1190527] {{0, 0}, {246, 45.5}}

    // 画出占位文字
    // 画到 rect, 具体位置尺寸
    CGRect placeholderRect;
    placeholderRect.origin.x = 0;
    placeholderRect.origin.y = (rect.size.height - self.font.lineHeight) * 0.5;
    placeholderRect.size.width = rect.size.width;
    placeholderRect.size.height = self.font.lineHeight;
//    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
    // 画到一个点上, 只用起点就可以,宽高会自动设置
    CGPoint placeholderPoint;
    placeholderPoint.x = 0;
    placeholderPoint.y = (rect.size.height - self.font.lineHeight) * 0.5;
    [self.placeholder drawAtPoint:placeholderPoint withAttributes:attrs];
    
}


@end
