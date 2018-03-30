//
//  ABSeeBigViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/3/29.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABSeeBigViewController.h"
#import "ABTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface ABSeeBigViewController () <UIScrollViewDelegate>
// 保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
// 图片控件
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation ABSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (imageView == nil) return; // 图片下载失败
        self.saveButton.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    
    imageView.ab_width = scrollView.ab_width;
    imageView.ab_height = self.topic.height * imageView.ab_width / self.topic.width;
    imageView.ab_x = 0;
    
    if (imageView.ab_height >= scrollView.ab_height) { // 图片高度超过整个屏幕
        imageView.ab_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.ab_height);
        
    } else{ // 居中显示
        imageView.ab_centerY = scrollView.ab_height * 0.5;
    }
    
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale = self.topic.width / imageView.ab_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
    
    
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIButton *)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    // @selector方法格式有要求, 但是名称可以自己定,下面的 a:b:c 也可以
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(a:b:c:), nil);
}

//- (void)a:(UIImage *)image b:(NSError *)error c:(void *)contextInfo
//{
//    ABLogFunc
//}


/*
 通过UIImageWriteToSavedPhotosAlbum函数写入图片完毕后会调用这个方法
    image: 写入的图片
    error: 错误信息
    contextInfo: UIImageWriteToSavedPhotosAlbum函数的最后一个参数
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
    } else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功!"];
    }
}

#pragma mark - <UIScrollViewDelegate>
// 返回一个 scrollview 的子控件进行缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
