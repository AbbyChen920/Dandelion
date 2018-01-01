//
//  ABLoginRegisterTextField.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/26.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABLoginRegisterTextField.h"
#import <objc/runtime.h>

static NSString * const ABPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation ABLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 设置占位文字的颜色
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];

//    
//    unsigned int count;
//    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = ivarList[i];
//        NSLog(@"%s", ivar_getName(ivar));
//    }
//    free(ivarList);
    
    
//    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
//    label.textColor = [UIColor whiteColor];
    
    // 设置默认的占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
    
    // 直接打印subviews 为空,可能因为刚从 xib 加载过来还没来得及显示子控件. 延迟打印就有了
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        UILabel *label = self.subviews.lastObject;
//        label.textColor = [UIColor whiteColor];
//        
//    });
    

    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    // 监听文字改变
//    [self addTarget:self action:@selector(editingChange) forControlEvents:UIControlEventEditingChanged];
}

// 开始编辑
- (void)editingDidBegin
{
    [self setValue:[UIColor whiteColor] forKeyPath:ABPlaceholderColorKey];
}

// 结束编辑
- (void)editingDidEnd
{
    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
}

//- (void)editingChange
//{
//    ABLogFunc
//}
@end
