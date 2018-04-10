//
//  ABCommentCell.h
//  Dandelion
//
//  Created by 陈芬 on 18/4/9.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABComment;

@interface ABCommentCell : UITableViewCell

// 评论模型数据
@property (nonatomic,strong) ABComment *comment;

@end
