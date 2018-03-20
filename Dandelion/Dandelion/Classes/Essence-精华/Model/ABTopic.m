//
//  ABTopic.m
//  Dandelion
//
//  Created by 陈芬 on 18/2/8.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABTopic.h"
#import "ABUser.h"
#import "ABComment.h"


@implementation ABTopic


#pragma mark - 其他
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

// 在第一次使用ABTopic类时调用1次, 使得下面这两个对象只创建一次
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

-(NSString *)created_at
{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) {  // 今年
          
        if (createdAtDate.isToday) { // 今天
            
            // 手机当前的时间
            NSDate *nowDate = [NSDate date];
            
            // 获得日期之间的间隔
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if(cmps.minute >= 1){ // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else{  // 1分钟 > 时间间隔
                return @"刚刚";
            }
        
            } else if(createdAtDate.isYesterday) // 昨天
            {
                fmt_.dateFormat = @"昨天 HH:mm:ss";
                return [fmt_ stringFromDate:createdAtDate];
            } else{ // 非昨天的其他时间
                fmt_.dateFormat = @"MM-dd HH:mm:ss";
                return [fmt_ stringFromDate:createdAtDate];
            }
      
        } else { // 非今年
            return _created_at;
        }
    
}

// 屏幕宽度 == 375
// 图片显示出来的宽度 == 355 (减去两边的 marge)
// 图片显示出来的高度 == 355 * 300 / 710 -> 真实的宽度,高度 跟显示出来的图片宽度,高度成一个比例

// 服务器返回的图片真实宽度 == 710
// 服务器返回的图片的真实高度 == 300

- (CGFloat)cellHeight
{
    
    // 如果 cell 的高度已经计算过,就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 1.头像
    _cellHeight = 55;
    
    // 2.文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * ABMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
//    CGSize textSize = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize];
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight += textSize.height + ABMargin;
    
    // 3.中间的内容
    if (self.type != ABTopicTypeWord) { // 如果是图片\声音\视频帖子,才需要计算中间内容的高度
        // 中间内容的高度 == 中间内容宽度 * 图片的真实高度 / 图片的真实宽度
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= [UIScreen mainScreen].bounds.size.height) { //超长图片
            // 将超长图片的高度变为200
            contentH = 200;
            self.bigPicture = YES;
        }
        // 这里的 cellHeight 就是中间内容的 y 值
        self.contentF = CGRectMake(ABMargin, _cellHeight, textMaxW, contentH);
        
        // 累加中间内容的高度
        _cellHeight += contentH + ABMargin;
    }
    
    // 4.最热评论
    if (self.top_cmt) { // 如果有最热评论
    
        // 最热评论-标题
        _cellHeight += 20;
        // 最热评论-内容
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
//        CGSize topCmtContentSize = [topCmtContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textMaxSize];
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height + ABMargin;
    }
    
    
    // 5.底部工具条
    _cellHeight += 35 + ABMargin;
    
    
    return _cellHeight;
}
@end


/*

 // _created_at = @"2018-03-05  12:22:02";
 // _created_at -> @"刚刚" \ @"10分钟前" \@"5小时前" \@"昨天 12:22:02" \@"03-05 12:22:02" \@"2018-03-05 12:22:02"
 
 今年
    今天
       时间间隔 >= 1小时  -  @"5小时前"
       1小时 > 时间间隔 > 1分钟  -  @"10分钟前"
       1分钟 > 时间间隔  -  @"刚刚"
    昨天 - @"昨天 12:22:02"
    其他 - @"03-05 12:22:02"
 
 非今年 - @"2018-03-05 12:22:02"
 
*/
