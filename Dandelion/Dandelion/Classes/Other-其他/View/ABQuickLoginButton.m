//
//  ABQuickLoginButton.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/23.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABQuickLoginButton.h"

@implementation ABQuickLoginButton

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.ab_centerX = self.ab_width * 0.5;
    self.imageView.ab_y = 0;
    
    self.titleLabel.ab_x = 0;
    self.titleLabel.ab_y = self.imageView.ab_bottom;
    self.titleLabel.ab_width = self.ab_width;
    self.titleLabel.ab_height = self.ab_height - self.titleLabel.ab_y;
    
    
}


@end
