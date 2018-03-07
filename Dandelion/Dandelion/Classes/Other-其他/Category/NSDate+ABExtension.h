//
//  NSDate+ABExtension.h
//  Dandelion
//
//  Created by 陈芬 on 18/3/6.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ABExtension)

// 是否为今年
- (BOOL)isThisYear;

// 是否为今天
- (BOOL)isToday;

// 是否为昨天
- (BOOL)isYesterday;


// 是否为明天
- (BOOL)isTmorrow;

@end
