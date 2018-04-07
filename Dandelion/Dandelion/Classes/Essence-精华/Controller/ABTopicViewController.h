
//
//  ABTopicViewController.h
//  Dandelion
//
//  Created by 陈芬 on 18/3/21.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTopic.h"

@interface ABTopicViewController : UITableViewController

// 帖子类型
//@property (nonatomic, assign) ABTopicType type;

- (ABTopicType)type;

// 这个属性会生成一个 type 的 get 方法和 _type 的成员变量
//@property (nonatomic, assign, readonly) ABTopicType type;

@end


// 父类中的某个内容,只允许由子类来修改\提供; 不能由外界来修改\提供
