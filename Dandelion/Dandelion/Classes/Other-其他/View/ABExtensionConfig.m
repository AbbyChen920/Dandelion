//
//  ABExtensionConfig.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/12.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABExtensionConfig.h"
#import "ABTopic.h" 
#import <MJExtension.h>
#import "ABComment.h"

@implementation ABExtensionConfig

+(void)load
{
//    [ABTopic mj_setupObj ectClassInArray:^NSDictionary *{
//        return @{@"top_cmt" : [ABComment class]};
//    }];
    
    [ABTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]"};
    }];
}
@end
