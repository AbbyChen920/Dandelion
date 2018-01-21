//
//  ABClearCacheCell.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/21.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABClearCacheCell.h"
#import <SDImageCache.h>

@implementation ABClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置 cell 右边的指示器(用来说明正在出来一些事情)
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        // 设置 cell 默认的文字
        self.textLabel.text = @"正在计算缓存大小...";
        
        // 4.设置数据
        // 在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 获得缓存文件夹路径
            //        unsigned long long size = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"].fileSize;
            unsigned long long size = @"/Users/Abby/Desktop/敲代码".fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            
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
                self.textLabel.text = text;
                
                // 注意:accessoryView的优先级是高于accessoryType的
                // 清空右边的指示器
                self.accessoryView = nil;
                
                // 显示右边的箭头
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            });
            
        });
    
    }
    return self;
}

@end
