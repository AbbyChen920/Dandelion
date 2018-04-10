//
//  ABUser.h
//  Dandelion
//
//  Created by 陈芬 on 18/3/7.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABUser : NSObject

// 用户名
@property (nonatomic,copy) NSString *username;
// 头像
@property (nonatomic,copy) NSString *profile_image;
// 性别 m(male)  f(female)
@property (nonatomic,copy) NSString *sex;

@end
