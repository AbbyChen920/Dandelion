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

//#import <AssetsLibrary/AssetsLibrary.h>  // ios 9开始废弃
#import <Photos/Photos.h> // ios 9 开始推荐

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
    
    /*
     PHAuthorizationStatusNotDetermined , 用户还没有做出选择
     PHAuthorizationStatusRestricted, 用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusDenied,  用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusAuthorized,  因为家长控制, 导致应用无法访问相册 (跟用户的选择没关系)
     */
    
    // 0.判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted) {//因为家长控制, 导致应用无法访问相册 (跟用户的选择没关系)
        [SVProgressHUD showErrorWithStatus:@"因为系统原因,无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied){//用户拒绝当前应用访问相册(用户当初点击了"不允许")
        ABLog(@"提醒用户去[设置-隐私-照片-xxx] 打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized){//用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined){ //用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了"好"
                [self saveImage];
            }
        }];
    }
    
    
    
}

- (void)saveImage
{
    // PHAsset:一个资源,比如一张图片\一段视频
    // PHAssetCollection:一个相簿
    
    // 1.保存图片 A 到"相机胶卷"中
    
    // 2.创建"相簿" D
    
    // 3.添加"相机胶卷"中的图片 A 到新建的"相簿" D 中
    
    
}


#pragma mark - <UIScrollViewDelegate>
// 返回一个 scrollview 的子控件进行缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


//- (IBAction)save:(UIButton *)sender {
//
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//
//    // @selector方法格式有要求, 但是名称可以自己定,下面的 a:b:c 也可以
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(a:b:c:), nil);
//}

/*
 通过UIImageWriteToSavedPhotosAlbum函数写入图片完毕后会调用这个方法
 image: 写入的图片
 error: 错误信息
 contextInfo: UIImageWriteToSavedPhotosAlbum函数的最后一个参数
 */
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
//    } else{
//        [SVProgressHUD showSuccessWithStatus:@"图片保存成功!"];
//    }
//}

@end
