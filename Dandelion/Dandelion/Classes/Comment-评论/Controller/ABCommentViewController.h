//
//  ABCommentViewController.h
//  Dandelion
//
//  Created by 陈芬 on 18/4/3.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABTopic;

@interface ABCommentViewController : UIViewController

// 帖子模型数据
@property (nonatomic,strong) ABTopic *topic;

@end
