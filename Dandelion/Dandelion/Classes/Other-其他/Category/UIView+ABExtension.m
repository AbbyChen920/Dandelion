//
//  UIView+ABExtension.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/7.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "UIView+ABExtension.h"

@implementation UIView (ABExtension)

-(CGFloat)ab_width
{
    return self.frame.size.width;
}

-(CGFloat)ab_height
{
    return self.frame.size.height;
}


-(void)setAb_width:(CGFloat)ab_width
{
    CGRect frame = self.frame;
    frame.size.width = ab_width;
    self.frame = frame;
}

-(void)setAb_height:(CGFloat)ab_height
{
    CGRect frame = self.frame;
    frame.size.height = ab_height ;
    self.frame = frame;
}

-(CGFloat)ab_x
{
    return self.frame.origin.x;
}
-(void)setAb_x:(CGFloat)ab_x
{
    CGRect frame = self.frame;
    frame.origin.x = ab_x;
    self.frame = frame;
}


-(CGFloat)ab_y
{
    return self.frame.origin.y;
}

-(void)setAb_y:(CGFloat)ab_y
{
    CGRect frame = self.frame;
    frame.origin.y = ab_y;
    self.frame = frame;
    
}

- (CGFloat)ab_centerX
{
    return self.center.x;
}

-(void)setAb_centerX:(CGFloat)ab_centerX
{
    CGPoint center = self.center;
    center.x = ab_centerX;
    self.center = center;
}

-(CGFloat)ab_centerY
{
    return self.center.y;
}
-(void)setAb_centerY:(CGFloat)ab_centerY
{
    CGPoint center = self.center;
    center.y = ab_centerY;
    self.center = center;
}

- (CGFloat)ab_right
{
//    return self.ab_x + self.ab_width;
    return CGRectGetMaxX(self.frame);
    
}

- (void)setAb_right:(CGFloat)ab_right
{
    self.ab_x = ab_right - self.ab_width;
}

- (CGFloat)ab_bottom
{
//    return self.ab_y + self.ab_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setAb_bottom:(CGFloat)ab_bottom
{
    self.ab_y = ab_bottom - self.ab_height;
}

+ (instancetype)viewFromXib;
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
@end
