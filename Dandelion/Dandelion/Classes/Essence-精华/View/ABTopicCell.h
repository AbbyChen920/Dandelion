//
//  ABTopicCell.h
//  Dandelion
//
//  Created by 陈芬 on 18/3/3.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABTopic;

@interface ABTopicCell : UITableViewCell

// 帖子模型数据
@property (nonatomic,strong) ABTopic *topic;

@end
