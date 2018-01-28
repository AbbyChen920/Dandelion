//
//  ABClearCacheCell.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/21.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define ABCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

@implementation ABClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 设置 cell 右边的指示器(用来说明正在出来一些事情)
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        // 设置 cell 默认的文字(如果设置文字之前self.userInteractionEnabled = NO;,那么文字会自动变成浅灰色)
        self.textLabel.text = @"正在计算缓存大小...";        
        
        // 禁止点击
        self.userInteractionEnabled = NO;

//         __weak ABClearCacheCell * weakSelf = self;
        __weak typeof(self) weakSelf = self;
        
        // 4.设置数据
        // 在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
#warning 睡眠
            [NSThread sleepForTimeInterval:5.0];
            
            // 获得缓存文件夹路径 (一点击去设置界面,就已经来到这个方法了,计算缓存的大小)
            unsigned long long size = ABCustomCacheFile.fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            ABLog(@"1111");
            
            // 如果 cell 已经销毁了,就直接返回
            if (weakSelf == nil) return;
            
            ABLog(@"2222");

            NSString *sizeText = nil;
            
            if (size >= pow(10, 9)) { // size>= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB",size / pow(10, 9)];
                
            } else if (size >= pow(10, 6)){ //1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB",size / pow(10, 6)];
                
            } else if (size >= pow(10, 3) ){  // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB",size / pow(10, 3)];
                
            } else{ // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB",size];
            }
            
            // 生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            // 回到主线程设置文字
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                weakSelf.textLabel.text = text;
                
                // 注意:accessoryView的优先级是高于accessoryType的
                // 清空右边的指示器
                weakSelf.accessoryView = nil;
                
                // 显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                // 添加手势监听器
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                
                // 恢复点击事件
                weakSelf.userInteractionEnabled = YES  ;
                
                ABLog(@"%@",weakSelf);
                ABLogFunc
            });
        });
    }
    return self;
}


- (void)dealloc
{
    ABLogFunc
}

// 清除缓存
- (void)clearCache
{
    // 弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存..." maskType:SVProgressHUDMaskTypeBlack];
    
    // 删除 SDWebimage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:ABCustomCacheFile error:nil];
            
            [mgr createDirectoryAtPath:ABCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
#warning 睡眠
            //            [NSThread sleepForTimeInterval:2.0];
            
            // 所有的缓存都清除完毕
            dispatch_sync(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [SVProgressHUD dismiss];
                
                // 设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
            
        });
        
        
    }];
}
@end






