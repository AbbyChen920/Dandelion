//
//  ABMeFooterView.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/11.
//  Copyright © 2018年 陈芬. All rights reserved.
//
 
#import "ABMeFooterView.h"
#import <AFNetworking.h>
#import "ABMeSquare.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import <SDWebImageDownloader.h>
#import <UIButton+WebCache.h>


@implementation ABMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        self.ab_height = 100;
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//            ABLog(@"请求成功- %@ %@", [responseObject class],responseObject);
            // 字典数据->模型数组
            NSArray *squares = [ABMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];

            // 根据模型数据创建对应的控件
            [self creatSquares:squares];
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ABLog(@"请求失败 - %@",error);
        }];
        
    }
    return self;
}


// 根据模型数据创建对应的控件
- (void)creatSquares:(NSArray *)squares
{
    // 方块个数
    NSUInteger count = squares.count;
    
    // 方块的尺寸
    int maxColsCount = 4;  //一行的最大列数
    CGFloat buttonW = self.ab_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        
        // i 位置对应的模型数据
        ABMeSquare *square = squares[i];
        
        // 创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置 frame
        button.ab_x = (i % maxColsCount) *buttonW;
        button.ab_y = (i / maxColsCount) *buttonH;
        button.ab_width = buttonW;
        button.ab_height = buttonH;
        
        
        // 设置数据
//        button.backgroundColor = ABRandomColor;
        [button setTitle:square.name forState:UIControlStateNormal];
       
//        [button.imageView sd_setImageWithURL:[NSURL URLWithString:square.icon] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
        // 手动设置占位图片
//        [button setImage:[UIImage imageNamed:@"setup-head-default"] forState:UIControlStateNormal];
        
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
    }
}


- (void)buttonClick:(UIButton *)button
{
    ABLogFunc
}
@end
