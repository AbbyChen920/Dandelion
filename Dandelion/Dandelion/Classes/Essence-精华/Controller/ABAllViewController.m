//
//  ABAllViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/30.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABAllViewController.h"
#import <AFNetworking.h>
#import "ABTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>


@interface ABAllViewController ()
// 所有的帖子数据
@property (nonatomic,strong) NSArray <ABTopic *> *topics;
@end

@implementation ABAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self setUpRefresh];
}

- (void)setUpRefresh
{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        ABLogFunc
//    }];
    
   MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    mj_header.automaticallyChangeAlpha = YES;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    mj_header.stateLabel.hidden = YES;
    mj_header.arrowView.hidden = YES;
    [mj_header addSubview:[[UISwitch alloc] init]];
    self.tableView.mj_header = mj_header;
    
}


#pragma mark - 数据加载
- (void)loadNewTopics
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/Abby/Desktop/new_topics.plist" atomically:YES];
        // 字典数组转模型数组
        self.topics = [ABTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ABLog(@"请求失败 - %@",error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];

    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    // 1.确定重用标识
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果是空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = ABRandomColor;
    }
    
    // 4.显示数据
    ABTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
   
}

@end
