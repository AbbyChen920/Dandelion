//
//  ABTopic.m
//  Dandelion
//
//  Created by 陈芬 on 18/2/8.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTopic.h"
#import <MJExtension.h>
#import "ABComment.h"

@implementation ABTopic

#pragma mark - MJExtension
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : [ABComment class]};
}

#pragma mark - 其他
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

// 在第一次使用ABTopic类时调用1次, 使得下面这两个对象只创建一次
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

-(NSString *)created_at
{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) {  // 今年
          
        if (createdAtDate.isToday) { // 今天
            
            // 手机当前的时间
            NSDate *nowDate = [NSDate date];
            
            // 获得日期之间的间隔
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if(cmps.minute >= 1){ // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else{  // 1分钟 > 时间间隔
                return @"刚刚";
            }
        
            } else if(createdAtDate.isYesterday) // 昨天
            {
                fmt_.dateFormat = @"昨天 HH:mm:ss";
                return [fmt_ stringFromDate:createdAtDate];
            } else{ // 非昨天的其他时间
                fmt_.dateFormat = @"MM-dd HH:mm:ss";
                return [fmt_ stringFromDate:createdAtDate];
            }
      
        } else { // 非今年
            return _created_at;
        }
    
}

@end


/*

 // _created_at = @"2018-03-05 12:22:02";
 // _created_at -> @"刚刚" \ @"10分钟前" \@"5小时前" \@"昨天 12:22:02" \@"03-05 12:22:02" \@"2018-03-05 12:22:02"
 
 今年
    今天
       时间间隔 >= 1小时  -  @"5小时前"
       1小时 > 时间间隔 > 1分钟  -  @"10分钟前"
       1分钟 > 时间间隔  -  @"刚刚"
    昨天 - @"昨天 12:22:02"
    其他 - @"03-05 12:22:02"
 
 非今年 - @"2018-03-05 12:22:02"
 
*/
