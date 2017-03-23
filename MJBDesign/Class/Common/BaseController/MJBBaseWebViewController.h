//
//  PJBaseWebViewController.h
//  MJBangProject
//
//  Created by piaojin on 16/11/8.
//  Copyright © 2016年 X团. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBBaseViewController.h"
typedef enum{
    LineProgress,//直线进度条
    RoundProgress//圆圈进度条
} LoadType;
@interface MJBBaseWebViewController : MJBBaseViewController
@property (strong, nonatomic) UIWebView *webView;
/**
 *   是否开启进度条
 */
@property (assign, nonatomic)BOOL isShowLoading;
/**
 *   加载进度条类型
 */
@property (assign, nonatomic)LoadType loadType;
/**
 *   是否打开分享
 */
@property (assign, nonatomic)BOOL isShare;
@property (copy, nonatomic) NSString *urlStr;
@property (copy, nonatomic)NSString *webViewTitle;
@property (strong, nonatomic) UIButton *shareBtn;
/**
 *   分享图标,可以是UIImage或NSString
 *
 */
@property (copy, nonatomic)id shareIcon;
/**
 *   分享标题
 *
 */
@property (copy, nonatomic)NSString *shareTitle;
/**
 *   分享描述
 *
 */
@property (copy, nonatomic)NSString *shareContent;
/**
 *   分享url
 */
@property (copy, nonatomic)NSString *shareUrl;
- (instancetype)initWithUrl:(NSString *)urlStr;

/**
 *   是否显示返回上一网页按钮
 */
@property (assign, nonatomic)BOOL isShowBack;

/**
 *   返回上一网页
 */
- (void)goBackPage;
/**
 *   当请求完成时，供子类调用
 *
 */
- (void)pjWebViewDidFinishLoad:(UIWebView *)webView;

@end
