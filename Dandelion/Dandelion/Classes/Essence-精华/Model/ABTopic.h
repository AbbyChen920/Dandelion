//
//  ABTopic.h
//  Dandelion
//
//  Created by 陈芬 on 18/2/8.
//  Copyright © 2018年 陈芬. All rights reserved.
// 帖子模型 (视频,声音,图片,段子)

#import <Foundation/Foundation.h>

//typedef enum {
//    // 图片
//    ABTopicTypePicture = 10,
//    // 段子
//    ABTopicTypeWord = 29,
//    // 声音
//    ABTopicTypeVoice = 31,
//    // 视频
//    ABTopicTypeVideo = 41,
//
//}ABTopicType;

typedef NS_ENUM(NSUInteger, ABTopicType) {
    
    // 图片
    ABTopicTypePicture = 10,
    // 段子
    ABTopicTypeWord = 29,
    // 声音
    ABTopicTypeVoice = 31,
    // 视频
    ABTopicTypeVideo = 41,
};

@class ABComment;

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

// 最热评论
@property (nonatomic,strong) ABComment *top_cmt;

// 帖子类型
@property (nonatomic, assign) ABTopicType type;

@end
