//
//  ABTopicPictureView.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/18.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "ABTopic.h"

@interface ABTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation ABTopicPictureView

- (void)awakeFromNib
{
    // 从 xib 中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight
    self.autoresizingMask = UIViewAutoresizingNone;
}


-(void)setTopic:(ABTopic *)topic
{
    _topic = topic;
    
    // 由于是模拟器 (直接显示大图)
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // gif
    self.gifView.hidden = !topic.is_gif;
    
    // 查看大图
    if (topic.isBigPicture) {// 超长图片
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
    
    // gif
//    if ([topic.large_image.lowercaseString hasSuffix:@"gif"]) {
//    if ([topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]) {
//    if (topic.is_gif) {
//        self.gifView.hidden = NO;
//    }else{
//        self.gifView.hidden = YES;
//    }
}

@end
