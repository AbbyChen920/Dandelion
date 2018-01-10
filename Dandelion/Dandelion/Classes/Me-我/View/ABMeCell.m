//
//  ABMeCell.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/10.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABMeCell.h"

@implementation ABMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
                               
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    // imageView
    self.imageView.ab_y = ABSmallMargin;
    self.imageView.ab_height = self.contentView.ab_height - 2 *ABSmallMargin;
    self.imageView.ab_width = self.imageView.ab_height;
    
    // label
    self.textLabel.ab_x = self.imageView.ab_right + ABMargin;
}
@end
