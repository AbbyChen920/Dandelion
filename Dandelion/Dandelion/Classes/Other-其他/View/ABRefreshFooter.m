//
//  ABRefreshFooter.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/2.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABRefreshFooter.h"

@implementation ABRefreshFooter

// 初始化
-(void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现多少的时候开始刷新(默认是1,全部出现的时候刷新; 越小表示离刷新控件越远就可以开始刷新
    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
    self.automaticallyRefresh = NO;
    
}

@end
