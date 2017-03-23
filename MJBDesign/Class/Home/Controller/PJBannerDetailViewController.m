//
//  PJBannerDetailViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/21.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBannerDetailViewController.h"

@implementation PJBannerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)backView:(BOOL)animated{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }else{
        [super backView:YES];
    }
}

#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.webView.scrollView.mj_header endRefreshing];
    [self showError:YES];
    NSLog(@"UIWebView错误:%@",error);
    if([error code] == NSURLErrorCancelled){
        [webView stopLoading];
        return;
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败,下拉刷新试试!"];
    }
}

@end
