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

//-(BOOL)isToday{
//  
//    // 判断 self 这个日期是否为今天
//    NSCalendar *calendar = [NSCalendar calendar];    
//    // 获得年月日元素
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    
//    return selfCmps.year == nowCmps.year
//    && selfCmps.month == nowCmps.month
//    && selfCmps.day == nowCmps.day;
//    
//}

-(BOOL)isToday
{
    // 判断 self 这个日期是否为今天
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfStirng = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    return [selfStirng isEqualToString:nowString];
}


- (BOOL)isYesterday{
    
    // 判断self 这个日期是否为昨天
    // self == 2015-10-31 23:07:08  ->   2015-10-31 00:00:00
    // now == 2015-11-01 14:39:20 ->     2015-11-01 00:00:00
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];  // 20151031
    NSString *nowString = [fmt stringFromDate:[NSDate date]];  // 20151101
    
    NSDate *selfDate = [fmt dateFromString:selfString];   // 2015-10-31   00:00:00
    NSDate *nowDate = [fmt dateFromString:nowString];     // 2015-11-01   00:00:00
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;

}


- (BOOL)isTmorrow
{
    // 判断self 这个日期是否为昨天
    // self == 2015-10-31 23:07:08  ->   2015-10-31 00:00:00
    // now == 2015-11-01 14:39:20 ->     2015-11-01 00:00:00
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];  // 20151031
    NSString *nowString = [fmt stringFromDate:[NSDate date]];  // 20151101
    
    NSDate *selfDate = [fmt dateFromString:selfString];   // 2015-10-31   00:00:00
    NSDate *nowDate = [fmt dateFromString:nowString];     // 2015-11-01   00:00:00
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

@end
