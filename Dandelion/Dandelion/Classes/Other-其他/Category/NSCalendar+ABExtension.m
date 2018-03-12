//
//  NSCalendar+ABExtension.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/6.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "NSCalendar+ABExtension.h"

@implementation NSCalendar (ABExtension)

+ (instancetype)calendar
{
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else{
        return [NSCalendar currentCalendar];
    }
}


@end
