//
//  ABComment.h
//  Dandelion
//
//  Created by 陈芬 on 18/3/7.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ABUser;

@interface ABComment : NSObject
// 内容
@property (nonatomic,copy) NSString *content;
// 用户 (发表评论的人)
@property (nonatomic,strong) ABUser *user;

@end
