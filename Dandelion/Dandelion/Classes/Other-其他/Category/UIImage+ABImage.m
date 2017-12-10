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
@end
