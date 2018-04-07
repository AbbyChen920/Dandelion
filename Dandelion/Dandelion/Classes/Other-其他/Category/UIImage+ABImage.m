//
//  UIImage+ABImage.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/3.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "UIImage+ABImage.h"

@implementation UIImage (ABImage)
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName
{
    // 加载图片
    // 取消渲染
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 将图片改为圆形图片
- (instancetype)circleImage
{
    // 开始图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 剪裁
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;

}

+ (instancetype)circleImage:(NSString *)name
{
    return [self imageNamed:name].circleImage;
}

@end
