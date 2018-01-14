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
#import <UIButton+WebCache.h>
#import "ABMeSquareButton.h"

@interface ABMeFooterView ()
// 存放所有模型的字典
//@property (nonatomic,strong) NSMutableDictionary<NSString *, ABMeSquare *> *allSquares;

@end

@implementation ABMeFooterView

//-(NSMutableDictionary<NSString *,ABMeSquare *> *)allSquares
//{
//    if (!_allSquares) {
//        _allSquares = [NSMutableDictionary dictionary];
//    }
//    return _allSquares;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {

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
        ABMeSquareButton *button = [ABMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置 frame
        button.ab_x = (i % maxColsCount) *buttonW;
        button.ab_y = (i / maxColsCount) *buttonH;
        button.ab_width = buttonW;
        button.ab_height = buttonH;
        
        // 设置数据
        button.square = square;
//            self.allSquares[button.currentTitle] = square;

    }
    
    // 设置 footer 的高度 == 最后一个按钮的 bottom(最大 Y 值)
    self.ab_height = self.subviews.lastObject.ab_bottom;
    
    // 设置tableview的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];  //重新刷新数据(会重新计算 contentSize)
 
}


- (void)buttonClick:(ABMeSquareButton *)button
{
//    ABMeSquare *square = self.allSquares[button.currentTitle];
//    ABLog(@"%@",square.url);
    
    ABMeSquare *square = button.square;
    
    // [@"mod://fsdhttpedasdsa" containsString:@"http"]  YES
    // [@"mod://fsdhttpedasdsa" hasSuffix:@"sa"]  YES
    // [@"mod://fsdhttpedasdsa" hasPrefix:@"http"]  NO
    
    // 如果location == 0; 说明以 http 开头
    // 如果location == NSNotFound; 或者 length == 0,说明没有找到对应的字符串
//    [@"5328://fsdfesadsf" rangeOfString:@"http"].location == NSNotFound;
    
    if ([square.url hasPrefix:@"http"]) { //利用 webview 加载 url 即可
        ABLog(@"利用 webview 加载 url");
    }else if ([square.url hasPrefix:@"mod"]){ // 另行处理
        
        if ([square.url hasSuffix:@"BDJ_To_Check"]) {
            ABLog(@"跳转到[审帖]界面");
        } else if ([square.url hasSuffix:@"BDJ_To_RecentHot"]){
            ABLog(@"跳转到[每日排行]界面");
        } else {
            ABLog(@"跳转到其他界面");
        }
                
    } else {
        ABLog(@"不是 http或者 mod 协议的");
    }
    
}
@end
