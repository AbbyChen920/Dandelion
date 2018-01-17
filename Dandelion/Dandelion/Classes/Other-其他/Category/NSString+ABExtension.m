//
//  NSString+ABExtension.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/17.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "NSString+ABExtension.h"

@implementation NSString (ABExtension)

- (unsigned long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 是否为文件夹
    BOOL isDirectory = NO;
   
    
    // 路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
        
    if (isDirectory) { // 文件夹
        
        // 获得文件夹的大小 == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        for (NSString *subPath in enumerator) {
            // 全路径
            NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubPath error:nil].fileSize;
        }

    }else{
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    

    return size;
}


//- (unsigned long long)fileSize
//{
//    // 总大小
//    unsigned long long size = 0;
//    
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    
//    // 文件属性
//    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
//    
//    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
//        
//        // 获得文件夹的大小 == 获得文件夹中所有文件的总大小
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//        
//        for (NSString *subPath in enumerator) {
//            // 全路径
//            NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
//            // 累加文件大小
//            size += [mgr attributesOfItemAtPath:fullSubPath error:nil].fileSize;
//        }
//        
//    }else{
//        size = attrs.fileSize;
//    }
//    
//    
//    return size;
//}
@end
