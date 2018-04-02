//
//  ABRecommendTag.h
//  Dandelion
//
//  Created by 陈芬 on 18/4/2.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABRecommendTag : NSObject
// 名字
@property (nonatomic,copy) NSString *theme_name;
// 图片
@property (nonatomic,copy) NSString *image_list;
//订阅数
@property (nonatomic, assign) NSInteger sub_number;
@end
