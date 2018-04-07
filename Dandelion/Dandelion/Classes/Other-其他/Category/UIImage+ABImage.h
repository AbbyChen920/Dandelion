//
//  UIImage+ABImage.h
//  Dandelion
//
//  Created by 陈芬 on 17/12/3.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ABImage)
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName;

// 将图片改为圆形图片
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

@end
