//
//  ABMeFooterView.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/11.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABMeFooterView.h"
#import <AFNetworking.h>

@implementation ABMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//            ABLog(@"请求成功- %@ %@", [responseObject class],responseObject);
            
            [responseObject writeToFile:@"/Users/Abby/Desktop/me.plist" atomically:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ABLog(@"请求失败 - %@",error);
        }];
        
        
    }
    return self;
}

@end
