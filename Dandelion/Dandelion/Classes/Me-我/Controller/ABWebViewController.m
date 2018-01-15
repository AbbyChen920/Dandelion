//
//  ABWebViewController.m
//  Dandelion
//
//  Created by 陈芬 on 18/1/15.
//  Copyright © 2018年 陈芬. All rights reserved.
//

#import "ABWebViewController.h"

@interface ABWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ABWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


@end
