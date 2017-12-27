//
//  ABFollowViewController.m
//  Dandelion
//
//  Created by 陈芬 on 17/12/8.
//  Copyright © 2017年 陈芬. All rights reserved.
//

#import "ABFollowViewController.h"
#import "ABRecommendFollowViewController.h"
#import "ABLoginRegisterViewController.h"

@interface ABFollowViewController ()


@end

@implementation ABFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ABCommonBgColor;
    
    // 标题(不建议使用 self.title 属性)
    self.navigationItem.title = @"关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
   
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 100, 200, 25);
    label.backgroundColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    // 图文混排
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 1-你好
    NSAttributedString *first = [[NSAttributedString alloc] initWithString:@"你好"];
    [attributedText appendAttributedString:first];
    
    // 2-图片
    // 带有图片的附件对象
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"header_cry_icon"];
    CGFloat lineH = label.font.lineHeight;
    attachment.bounds = CGRectMake(0, -((label.ab_height -lineH)*0.5 - 1), lineH, lineH);
    // 将附件对象包装成一个属性文字
    NSAttributedString *second = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributedText appendAttributedString:second];
    
    // 3-哈哈哈
    NSAttributedString *third = [[NSAttributedString alloc] initWithString:@"哈哈哈"];
    [attributedText appendAttributedString:third];
    
    label.attributedText = attributedText;
    
    
    
    
//    UILabel *label = [[UILabel alloc] init];
//    
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"你好哈哈哈"];
//    [text addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, 3)];
//    [text addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 3)];
//    label.attributedText = text;
//    
//    label.frame = CGRectMake(100, 100, 100, 25);
//    [self.view addSubview:label];
    
    
//    UILabel *label = [[UILabel alloc] init];
//    // 设置属性文字
//    NSString *text = @"你好\n哈哈哈";
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
//    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, text.length)];
//    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, 3)];
//  
//    label.attributedText = attributedText;
//    
//    // 其他设置
//    label.numberOfLines = 0;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.frame = CGRectMake(0, 0, 100, 40);
//    
//    self.navigationItem.titleView = label;
}

- (IBAction)loginRegister {
    
    ABLoginRegisterViewController *loginRegister = [[ABLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)followClick
{
    ABLogFunc
    
    ABRecommendFollowViewController *test = [[ABRecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
}

@end
