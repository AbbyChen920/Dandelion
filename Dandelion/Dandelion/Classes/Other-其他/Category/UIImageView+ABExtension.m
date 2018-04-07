//
//  UIImageView+ABExtension.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/3.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "UIImageView+ABExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (ABExtension)
- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}

// 设置圆形图片
- (void)setCircleHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image == nil) return;
        
        self.image = [image circleImage];
    }];
}

// 设置方形图片
- (void)setRectHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}
@end
