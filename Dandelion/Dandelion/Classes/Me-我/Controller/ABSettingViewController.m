//
//  ABSettingViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/16.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABSettingViewController.h"
#import "ABTest1ViewController.h"
#import <SDImageCache.h>
#import "ABClearCacheCell.h"
#import "ABSettingCell.h"
#import "ABOtherCell.h"

@interface ABSettingViewController ()

@end

@implementation ABSettingViewController

static NSString * const ABClearCacheCellId = @"ABClearCacheCell";
static NSString * const ABSettingCellId = @"ABSettingCell";
static NSString * const ABOtherCellId = @"other";


- (instancetype)init
{
        return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = ABCommonBgColor;
    
    [self.tableView registerClass:[ABClearCacheCell class] forCellReuseIdentifier:ABClearCacheCellId];
    [self.tableView registerClass:[ABSettingCell class] forCellReuseIdentifier:ABSettingCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABOtherCell class]) bundle:nil] forCellReuseIdentifier:ABOtherCellId];

    
//    ABLog(@"%zd",[NSString fileSizeForFile:@"/Users/Abby/Desktop/敲代码"]);
    // 更简单的写法
//    ABLog(@"%zd",@"/Users/Abby/Desktop/敲代码".fileSize);
    
//    ABLog(@"%zd", [SDImageCache sharedImageCache].getSize);
//    [self getCacheSize];
//    [self getCacheSize2];
}

- (void)dealloc
{
    ABLogFunc
}




- (void)getCacheSize
{
    // 总大小
    unsigned long long size = 0;
    
    // 获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获得文件夹的大小 == 获得文件夹中所有文件的总大小
    NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:dirPath];
//    NSArray *subPaths = [mgr subpathsAtPath:dirPath];
    
    for (NSString *subPath in enumerator) {
        // 全路径
        NSString *fullSubPath = [dirPath stringByAppendingPathComponent:subPath];
        // 累加文件大小
        size += [mgr attributesOfItemAtPath:fullSubPath error:nil].fileSize;
    }
    
    ABLog(@"%zd",size);
}

- (void)getCacheSize2
{
    // 总大小
    unsigned long long size = 0;
    
    // 获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获得文件夹的大小 == 获得文件夹中所有文件的总大小
    NSArray *subPaths = [mgr subpathsAtPath:dirPath];
    for (NSString *subPath in subPaths) {
        // 全路径
        NSString *fullSubPath = [dirPath stringByAppendingPathComponent:subPath];
        // 累加文件大小
        size += [mgr attributesOfItemAtPath:fullSubPath error:nil].fileSize;
    }
    
    ABLog(@"%zd",size);
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ABTest1ViewController *test1 = [[ABTest1ViewController alloc] init];
    
    [self.navigationController pushViewController:test1 animated:YES];
    
}

#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        
      if (indexPath.row == 0) { // 清除缓存
//         ABClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:ABClearCacheCellId];
          
//          // cell 重新显示的时候,继续转圈圈
//          UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)cell.accessoryView;
//          [loadingView startAnimating];
          
//          return cell;
          return [tableView dequeueReusableCellWithIdentifier:ABClearCacheCellId];
          
    } else{ // ABSettingCell
        ABSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ABSettingCellId];
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"检查更新";
            
        } else if (indexPath.row == 2){
            cell.textLabel.text = @"给我们评分";

        } else if (indexPath.row == 3){
            cell.textLabel.text = @"推送设置";

        } else{
            cell.textLabel.text = @"关于我们";

        }
        
        return cell;
       }
    }else {// ABOtherCell
        return [tableView dequeueReusableCellWithIdentifier:ABOtherCellId];
    }
}

#pragma mark - delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABLogFunc
}


@end
