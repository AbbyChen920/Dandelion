//
//  ABTopic.h
//  Dandelion
//
//  Created by 陈芬 on 18/2/8.
//  Copyright © 2018年 陈芬. All rights reserved.
// 帖子模型 (视频,声音,图片,段子)

#import <Foundation/Foundation.h>

@interface ABTopic : NSObject

// 用户的名字
@property (nonatomic,copy) NSString *name;
// 用户的头像
@property (nonatomic,copy) NSString *profile_image;
// 帖子的文字内容
@property (nonatomic,copy) NSString *text;
// 帖子审核通过的时间
@property (nonatomic,copy) NSString *created_at;
// 顶数量
@property (nonatomic, assign) NSInteger ding;
// 踩数量
@property (nonatomic, assign) NSInteger cai;
// 转发/分享数量
@property (nonatomic, assign) NSInteger repost;
//评论数量
@property (nonatomic, assign) NSInteger comment;

@end
