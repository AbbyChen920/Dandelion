//
//  ABCommentViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/3.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABCommentViewController.h"
#import "ABHTTPSessionManager.h"
#import "ABRefreshHeader.h"
#import "ABRefreshFooter.h"
#import "ABTopic.h"
#import "ABComment.h"
#import <MJExtension.h>

@interface ABCommentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 任务管理者
@property (nonatomic,strong)  ABHTTPSessionManager *manager;

// 最热评论数据
@property (nonatomic,strong) NSArray<ABComment *> *hotestComments;
// 最新评论数据
@property (nonatomic,strong) NSMutableArray<ABComment *> *latestComments;

// 对象属性名不能以 new 开头
//@property (nonatomic,strong) NSMutableArray<ABComment *> *newComments;

@end

@implementation ABCommentViewController


static NSString * const ABCommentCellID = @"comment";

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
    
    [self setupBase];
    
    [self setupTabled];

    [self setUpRefresh];

}

- (void)setupTabled
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ABCommentCellID];

    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    headerView.ab_height = 200;
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.backgroundColor = ABCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setUpRefresh
{
    self.tableView.mj_header = [ABRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [ABRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
}

- (void)setupBase
{
    self.navigationItem.title = @"评论";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 数据加载
- (void)loadNewComments
{
    // 取消其他请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;  // @"1"
  
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:ABCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }

        // 字典数组->模型数组
        weakSelf.latestComments = [ABComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [ABComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)  {
     
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];

}

- (void)loadMoreComments
{
    
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    // 修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH -keyboardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.latestComments.count && self.hotestComments.count) return 2;
//    if (self.latestComments.count && self.hotestComments.count == 0) return 1;
//    return 0;
    
    // 有最热评论 + 最新评论数据 (有最热评论,就一定有最新评论)
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论数据, 有最新评论数据
    if (self.latestComments.count) return 1;
    
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 第0组
//    if (section == 0) {
//        if (self.hotestComments.count) {
//            return self.hotestComments.count;
//        } else {
//            return self.latestComments.count;
//        }
//    }
//
//    // 其他组- section == 1
//    return self.latestComments.count;
    
    // 第0组 && 有最热评论
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    // 其他情况
    return self.latestComments.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ABCommentCellID];
        cell.textLabel.text = [NSString stringWithFormat:@"评论数据-%zd-%zd",indexPath.section,indexPath.row];
        return cell;
  
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 第0组 && 有最热评论
    if (section == 0 && self.hotestComments.count) {
        return @"最热评论";
    }
    // 其他情况
    return @"最新评论";
    
}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

//当用户开始拖拽 scrollview 就会调用一 次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
