#import <UIKit/UIKit.h>

// 通用的间距值
CGFloat const ABMargin = 10;
// 通用的小间距值
CGFloat const ABSmallMargin = ABMargin * 0.5;

// 公共的 url
NSString * const ABCommonURL = @"http://api.budejie.com/api/api_open.php";

NSString * const ABUserSexMale = @"m";

NSString * const ABUserSexFemale = @"f";


// 通知
// TabBar 按钮被重复点击的通知
NSString * const ABTabBarButtonDidRepeatClickNotification = @"ABTabBarButtonDidRepeatClickNotification";
// TitleButyon 按钮被重复点击的通知
NSString * const ABTitleButtonDidRepeatClickNotification = @"ABTitleButtonDidRepeatClickNotification";
