//
//  ABRecommendTagCell.m
//  Dandelion
//
//  Created by 陈芬 on 18/4/2.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABRecommendTagCell.h"
#import "ABRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface ABRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation ABRecommendTagCell

-(void)setRecommendTag:(ABRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    // 头像
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 名字
    self.themeNameLabel.text = recommendTag.theme_name;
    
    // 订阅数
    if (recommendTag.sub_number >=10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
    } else{
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }
}

// 重写 setFrame: 的作用:监听设置 cell 的 frame的过程
- (void)setFrame:(CGRect)frame
{
    frame.size.height -=1;
    
    [super setFrame:frame];
}

@end
