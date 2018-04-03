//
//  ABCommentViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/3.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABCommentViewController.h"

@interface ABCommentViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@end

@implementation ABCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
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

#pragma mark -监听
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


#pragma mark -UITableViewDelegate
//当用户开始拖拽 scrollview 就会调用一 次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
