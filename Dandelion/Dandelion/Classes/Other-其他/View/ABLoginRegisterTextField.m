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

@interface ABLoginRegisterTextField()
@property (nonatomic,strong) id observer;
@end

@implementation ABLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 设置默认的占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
    
    // object一定要设置为self,不然所有的文本框都会接受通知执行方法. 要规定只接受自己的文本框发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextFieldTextDidEndEditingNotification object:self];
   
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextFieldTextDidEndEditingNotification object:self];
//    });
    

    // object对象发了名字为 name 的通知,就在queue队列中执行 block
    // 这个方法的返回值是监听器
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidBeginEditingNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        // 移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
    
}
-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

- (void)beginEditing
{
    //    ABLog(@"%@ beginEditing",[note.object placeholder]);
    [self setValue:[UIColor whiteColor] forKeyPath:ABPlaceholderColorKey];
}

- (void)endEditing
{
//    ABLog(@"%@ beginEditing",[note.object placeholder]);
    [self setValue:[UIColor grayColor] forKeyPath:ABPlaceholderColorKey];
}
@end
