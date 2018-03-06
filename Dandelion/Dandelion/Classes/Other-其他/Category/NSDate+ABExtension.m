//
//  NSDate+ABExtension.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/6.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "NSDate+ABExtension.h"

@implementation NSDate (ABExtension)

//-(BOOL)isThisYear
//{
//    // 判断 self 这个日期是否为今年
//    NSCalendar *calendar = [NSCalendar calendar];
//    
//    // 年
//    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
//    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
//    
//    return  selfYear == nowYear;
//    
//}

-(BOOL)isThisYear
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy";
    
    // 年
    NSString *selfYear = [fmt stringFromDate:self];
    NSString *nowYear = [fmt stringFromDate:[NSDate date]];
    
    return [selfYear isEqualToString:nowYear];
}

@end
