//
//  ABAllViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/30.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABAllViewController.h"
#import "ABHTTPSessionManager.h"
#import "ABTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "ABRefreshHeader.h"
#import "ABRefreshFooter.h"
#import "ABTopicCell.h"


@interface ABAllViewController ()
// 所有的帖子数据
@property (nonatomic,strong) NSMutableArray <ABTopic *> *topics;

// maxtime: 用来加载下一页数据
@property (nonatomic,copy) NSString *maxtime;

// 任务管理者
@property (nonatomic,strong)  ABHTTPSessionManager *manager;

@end


@implementation ABAllViewController

static NSString * const ABTopicCellId = @"topic";

#pragma mark - 懒加载
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [ABHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpTable];

    [self setUpRefresh];
}


- (void)setUpTable
{
    self.tableView.backgroundColor = ABCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABTopicCell class]) bundle:nil] forCellReuseIdentifier:ABTopicCellId];
    self.tableView.rowHeight = 200;
}


- (void)setUpRefresh
{
    self.tableView.mj_header = [ABRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [ABRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}


#pragma mark - 数据加载
- (void)loadNewTopics
{
    // 取消其他请求
//    for (NSURLSessionTask *task in self.manager.tasks) {
//        [task cancel];
//    }
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 关闭NSURLSession + 取消所有请求  ;
    // 关闭NSURLSession就再也不能发送请求了
//    [self.manager invalidateSessionCancelingTasks:YES];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    // 发送请求
    [self.manager GET:ABCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/Abby/Desktop/new_topics.plist" atomically:YES];
        
        // 存储 maxtime( 方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组转模型数组
        self.topics = [ABTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        ABWriteToPlist(responseObject, @"new_topics");
        for (NSUInteger i = 0; i < self.topics.count; i++) {
            if (self.topics[i].top_cmt.count) { //最热评论
                ABLog(@"下拉刷新-%zd", i);
            }
        }
        
        
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)  {
        ABLog(@"请求失败 - %@",error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];

    }];
}

// 一个请求任务被取消了( cancel), 会自动调用 AFN 请求的 failure 这个 block


- (void)loadMoreTopics
{
    // 取消其他请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [self.manager GET:ABCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        ABWriteToPlist(responseObject,@"more_topics");
        
        // 存储折页对应的 maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数->模型数组
        NSArray<ABTopic *> *moreTopics = [ABTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        
        ABWriteToPlist(responseObject, @"more_topics");
        for (NSUInteger i = 0; i < moreTopics.count; i++) {
            if (moreTopics[i].top_cmt.count) { //最热评论
                ABLog(@"上拉刷新-%zd", i);
            }
        }
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ABLog(@"请求失败 - %@",error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ABTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ABTopicCellId];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
   
}


#pragma mark -  delegate


@end
