//
//  ABTopicVideoView.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/18.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTopicVideoView.h"
#import "ABTopic.h"
#import <UIImageView+WebCache.h>


@interface ABTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end

@implementation ABTopicVideoView

- (void)awakeFromNib
{
    // 从 xib 中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(ABTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    // %02zd -> 占据2位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
