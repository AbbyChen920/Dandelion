//
//  ABTitleButton.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/29.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTitleButton.h"

@implementation ABTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置按钮颜色
        // titleButton.selected = NO;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        // titleButton.selected = YES;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
