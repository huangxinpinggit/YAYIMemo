//
//  YALiabilityViewController.m
//  YAYIMemo
//
//  Created by hxp on 2017/10/16.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YALiabilityViewController.h"

@interface YALiabilityViewController ()

@property (nonatomic, weak) UIWebView *webView;
@end

@implementation YALiabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免责声明";
    [self setupSubView];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (void)setupSubView
{
    CGFloat navH = YANavBarHeight;
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - navH);
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @ "YAHtml" ofType :@"bundle"];
    NSString *htmlPath= [bundlePath stringByAppendingPathComponent :@"disclaimer.html"];
    NSURL *url= [NSURL fileURLWithPath:htmlPath];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}


@end
