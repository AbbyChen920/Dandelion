//
//  ABTopicCell.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/3.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTopicCell.h"
#import "ABTopic.h"
#import <UIImageView+WebCache.h>
#import "ABComment.h"
#import "ABUser.h"

@interface ABTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

// 最热评论 - 整体
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

@end


@implementation ABTopicCell

- (IBAction)more {
    
    // UIAlertControllerStyleAlert == UIAlertView
    // UIAlertControllerStyleActionSheet == UIActionSheet
    // UIAlertController == UIAlertView + UIActionSheet
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 没有按钮,可以自己加
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ABLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        ABLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ABLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setTopic:(ABTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;   // 调用 get 方法  [topic created_at]
    self.text_label.text = topic.text;
    
    
    // 发帖时间: NSString *created_at = @"2018-03-05 12:22:02"
    // 手机的当前时间: 12:51    (两个时间格式不同,没办法比较;一般会把 nsstring 类型的转成 nsdate,再通过 nsdate 里面的方法把两个时间进行比较)
    
    // 发帖时间: NSDate *created_at = ....
    // 手机的当前时间: NSDate *now = [NSDate date]
    
    
    // 用来测试的数据
//    topic.ding = 10000 + arc4random_uniform(5000);
//    topic.cai = arc4random_uniform(8000) + arc4random_uniform(5000);
//    topic.repost = arc4r andom_uniform(8000) + arc4random_uniform(5000);
//    topic.comment = 0;

    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];

    // 最热评论
    if (topic.top_cmt) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        
        NSString *username = topic.top_cmt.user.username; // 用户名
        NSString *content = topic.top_cmt.content;  // 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
        
    } else{ // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    // 中间内容
#pragma mark - 根据ABTopic模型数据的情况来决定中间添加什么控件(内 容)
    if (topic.type == ABTopicTypeVideo) { // 视频
        
    } else if (topic.type == ABTopicTypeVoice) // 音频
    {
        
    } else if (topic.type == ABTopicTypeWord) // 段子
    {
        
    } else if (topic.type == ABTopicTypePicture) // 图片
    {
        
    }
   
}

// 设置按钮的数字( placeholder 是一个中文参数,故意留到最后,前面的参数就可以使用点语法等智能提示)
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    } else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}



// 重写这个方法的目的:能够拦截所有设置 cell frame 的操作
- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= ABMargin;
    frame.origin.y += ABMargin;

//    frame.origin.x += ABMargin;
//    frame.size.width -= 2 * ABMargin;
    
    [super setFrame:frame];
}


@end
