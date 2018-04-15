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
#import "ABCommentSectionHeader.h"
#import "ABCommentCell.h"
#import "ABTopicCell.h"

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
static NSString * const ABSectionHeaderID = @"header";

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
    
    [self setupTable];

    [self setUpRefresh];
    
    [self setupHeader];

}

- (void)setupHeader
{
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 添加 cell 到 header
    ABTopicCell *cell = [ABTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [header addSubview:cell];
    
    // 设置 header 的高度
    header.ab_height = cell.ab_height + ABMargin * 2;
    
    // 设置 header
    self.tableView.tableHeaderView = header;
    
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABCommentCell class]) bundle:nil] forCellReuseIdentifier:ABCommentCellID];
    [self.tableView registerClass:[ABCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:ABSectionHeaderID];

    self.tableView.backgroundColor = ABCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 每一组头部header的高度
    self.tableView.sectionHeaderHeight = ABCommentSectionHeaderFont.lineHeight;
    
    // 设置 cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
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
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) {// 全部加载完毕
            // 隐藏
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)  {
     
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];

}

- (void)loadMoreComments
{
    // 取消其他请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:ABCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        // 字典数组->模型数组
        NSArray *moreComments = [ABComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) {// 全部加载完毕
            // 提示用户:没有更多数据
//            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.tableView.mj_footer.hidden = YES;
        } else {  // 还没有加载完全
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)  {
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_footer   endRefreshing];
        
    }];
    

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
    ABCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ABCommentCellID];
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    } else{
        cell.comment = self.latestComments[indexPath.row];
    }
    
    return cell;

}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // 第0组 && 有最热评论
//    if (section == 0 && self.hotestComments.count) {
//        return @"最热评论";
//    }
//    // 其他情况
//    return @"最新评论";
//    
//}

#pragma mark -UITableViewDelegate
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = tableView.backgroundColor;
//    
//    label.font = ABCommentSectionHeaderFont;
//    label.textColor = [UIColor darkGrayColor];
//    
//    
//    // 第0组 && 有最热评论
//    if (section == 0 && self.hotestComments.count) {
//        label.text = @"最热评论";
//    }else{ // 其他情况
//        label.text = @"最新评论";
//    }
//    
//    return label;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIButton *btn = [[UIButton alloc] init];
//    btn.backgroundColor = tableView.backgroundColor;
//    
//
//    // 内边距
////    btn.contentEdgeInsets = UIEdgeInsetsMake(0, ABMargin, 0, 0);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, ABMargin, 0, 0);
//    
//    // 让按钮内部的内容, 在按钮中左对齐
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    
//    btn.titleLabel.font = ABCommentSectionHeaderFont;
//    
//    // 让 label 的文字在 label 内容左对齐
////    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    
//    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    
//    // 第0组 && 有最热评论
//    if (section == 0 && self.hotestComments.count) {
//        [btn setTitle:@"最热评论" forState:UIControlStateNormal];
//    }else{ // 其他情况
//        [btn setTitle:@"最新评论" forState:UIControlStateNormal];
//    }
//    
//    return btn;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //    if (header == nil) {
//    //        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
//    ////        header.textLabel.textColor = [UIColor redColor];
//    //    }
//    
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ABSectionHeaderID];
//    
//    header.textLabel.textColor = [UIColor redColor];
//
//    // 第0组 && 有最热评论
//    if (section == 0 && self.hotestComments.count) {
//        header.textLabel.text = @"最热评论";
//        
//    }else{ // 其他情况
//        header.textLabel.text = @"最新评论";
//    }
//    
//    return header;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    ABCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ABSectionHeaderID];
    
    // 第0组 && 有最热评论
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    }else{ // 其他情况
        header.textLabel.text = @"最新评论";
    }
    
    return header;
}

//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}

//当用户开始拖拽 scrollview 就会调用一 次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
//    ABLog(@"%@", NSStringFromCGRect(self.tableView.tableHeaderView.frame));
}
@end
