//
//  ABItemManager.h
//  Dandelion
//
//  Created by 陈芬 on 17/12/9.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABItemManager : NSObject
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
