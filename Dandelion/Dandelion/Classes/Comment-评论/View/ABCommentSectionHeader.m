//
//  ABCommentSectionHeader.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/8.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABCommentSectionHeader.h"

@implementation ABCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor redColor];
    
//        UISwitch *s = [[UISwitch alloc] init];
//        s.ab_x = 200;
//        [self.contentView addSubview:s];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 在 layoutSubviews 方法中覆盖对子控件的一些设置
    self.textLabel.font = ABCommentSectionHeaderFont;
}

@end
