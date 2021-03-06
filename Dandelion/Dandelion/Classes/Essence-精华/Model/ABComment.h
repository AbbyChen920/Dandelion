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
// id
@property (nonatomic,copy) NSString *ID;

// 内容
@property (nonatomic,copy) NSString *content;
// 用户 (发表评论的人)
@property (nonatomic,strong) ABUser *user;
// 被点赞数
@property (nonatomic,assign) NSInteger like_count;
// 音频文件的时长
@property (nonatomic, assign) NSInteger voicetime;
// 音频文件的路径
@property (nonatomic, copy) NSString *voiceuri;

@end
