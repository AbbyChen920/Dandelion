//
//  ABRecommendTagViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/2.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABRecommendTagViewController.h"
#import "ABHTTPSessionManager.h"
#import <MJExtension.h>
#import "ABRecommendTag.h"
#import "ABRecommendTagCell.h"
#import <SVProgressHUD.h>

@interface ABRecommendTagViewController ()
// 所有的标签数据(数组中存放的都是ABRecommendTag模型
@property (nonatomic,strong) NSArray<ABRecommendTag *> *recommendTags;
//请求管理者
@property (nonatomic,weak) ABHTTPSessionManager *manager;

@end

@implementation ABRecommendTagViewController

// manager 属性的懒加载
- (ABHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [ABHTTPSessionManager manager];
    }
    return _manager;
}

// cell的重用标识
static NSString * const ABRecommendTagCellID = @"recommendTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    // 基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ABRecommendTagCellID];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = ABCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 加载标签数据
    [self loadNewRecommandTags];
}

//加载标签数据
- (void)loadNewRecommandTags
{
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];

    __weak typeof(self) weakSelf = self;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [self.manager GET:ABCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            // 字典数组 -> 模型数组
            weakSelf.recommendTags = [ABRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
            
            // 刷新
            [weakSelf.tableView reloadData];
            
            // 去除HUD
            [SVProgressHUD dismiss];
        
//            ABLog(@"1111");
//        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 如果是取消任务,就直接返回
        if (error.code == NSURLErrorCancelled) return;
            
        [SVProgressHUD dismiss];
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试 "];
    }];
}

// 当控制器的 view 即将消失的时候调用
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 隐藏 HUD
    [SVProgressHUD dismiss];
    
    // 取消请求
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - tableviewdatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendTags.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ABRecommendTagCellID];
    cell.recommendTag = self.recommendTags[indexPath.row];
    return cell;
}

@end
