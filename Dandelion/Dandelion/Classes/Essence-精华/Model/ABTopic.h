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
    // 全部
    ABTopicTypeAll = 1,
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

// id
@property (nonatomic,copy) NSString *ID;
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

// 图片的真实宽度
@property (nonatomic, assign) CGFloat width;

// 图片的真实高度
@property (nonatomic, assign) CGFloat height;

// 音频时长
@property (nonatomic, assign) NSInteger voicetime;
// 视频时长
@property (nonatomic, assign) NSInteger videotime;
// 音频/视频的播放次数
@property (nonatomic, assign) NSInteger playcount;


// 额外增加的属性 - 方便开发
// cell 的高度 
@property (nonatomic, assign) CGFloat cellHeight;

// 中间内容的 frame
@property (nonatomic, assign) CGRect contentF;

// 小图
@property (nonatomic,copy) NSString *small_image;
// 大图
@property (nonatomic,copy) NSString *large_image;
// 中图
@property (nonatomic,copy) NSString *middle_image;
// 是否为动态图
@property (nonatomic, assign) BOOL is_gif;
// 是否为超长图片
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;


@end
