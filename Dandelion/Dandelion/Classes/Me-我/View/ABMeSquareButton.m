//
//  ABMeSquareButton.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/13.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABMeSquareButton.h"
#import "ABMeSquare.h"
#import <UIButton+WebCache.h>

@implementation ABMeSquareButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];

    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.ab_y = self.ab_height * 0.15;
    self.imageView.ab_height = self.ab_height * 0.5;
    self.imageView.ab_width = self.imageView.ab_height;
    self.imageView.ab_centerX = self.ab_width * 0.5;
    
    self.titleLabel.ab_x = 0;
    self.titleLabel.ab_y = self.imageView.ab_bottom;
    self.titleLabel.ab_width = self.ab_width;
    self.titleLabel.ab_height = self.ab_height - self.titleLabel.ab_y;
    
}

-(void)setSquare:(ABMeSquare *)square{
    
    _square = square;
    // 设置数据
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}
@end
