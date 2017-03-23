//
//  PJDesignMainPageViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/15.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJDesignMainPageViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ShareManager.h"
#import "PJDesignDetailModel.h"

@interface PJDesignMainPageViewController ()

@property (weak, nonatomic)UIView *backBg;
@property (weak, nonatomic)UIView *shareBg;
@property (weak, nonatomic)UIButton *back;
@property (weak, nonatomic)UIButton *share;

@end

@implementation PJDesignMainPageViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    if(self.navBarAlpha >= 1){
        return UIStatusBarStyleDefault;
    }else{
        return UIStatusBarStyleLightContent;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImageView *navBarImageView = self.navigationController.navigationBar.subviews.firstObject;
    navBarImageView.alpha = 0;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    
    UIView *navBarLeftBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 65, 30)];
    
    UIView *backBg = [[UIView alloc] init];
    backBg.backgroundColor = [UIColor blackColor];
    backBg.alpha = 0.6;
    backBg.frame = CGRectMake(0, 0, 30, 30);
    backBg.layer.cornerRadius = backBg.height / 2.0;
    backBg.layer.masksToBounds = YES;
    
    [navBarLeftBgView addSubview:backBg];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"backWhite"] forState:(UIControlStateNormal)];
    backButton.frame = CGRectMake(0, 0, 30, 30);
    self.backBg = backBg;
    [backButton addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
    [navBarLeftBgView addSubview:backButton];
    self.back = backButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navBarLeftBgView];
    
    UIView *navBarRightBgView = [[UIView alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.width - 10, 10, 65, 30)];
    
    UIView *shareBg = [[UIView alloc] init];
    shareBg.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:1];
    shareBg.alpha = 0.6;
    shareBg.frame = CGRectMake(navBarRightBgView.width - 30, 0, 30, 30);
    shareBg.layer.cornerRadius = shareBg.height / 2.0;
    shareBg.layer.masksToBounds = YES;
    
    [navBarRightBgView addSubview:shareBg];
    self.shareBg = shareBg;
    
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"shareWhite"] forState:(UIControlStateNormal)];
    shareButton.frame = CGRectMake(navBarRightBgView.width - 30, 0, 30, 30);
    [shareButton addTarget:self action:@selector(shareClick) forControlEvents:(UIControlEventTouchUpInside)];
    [navBarRightBgView addSubview:shareButton];
    self.share = shareButton;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navBarRightBgView];
}

- (void)shareClick{
    [ShareManager showShareWithTitle:DesignShareTitle descr:DesignShareContent shareUrl:self.shareUrl shareIcon:[UIImage imageNamed:@"logo"] showView:PJKeyWindow completion:^(id result, NSError *error) {
        
    }];
    [MobClick event:MobClickDesignShare];
}

- (void)backView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UIWebView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(navigationType == UIWebViewNavigationTypeLinkClicked){
        
        NSString *urlStr = request.URL.absoluteString;
        NSString *suffix = @"?channel=app_mjb";
        NSString *reqStr = request.URL.absoluteString;
        if(![reqStr containsString:suffix]){
            
            urlStr=[urlStr stringByAppendingString:suffix];
            NSURLRequest *newRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
            [webView loadRequest:newRequest];
            
            return NO;
        }
    }
    return YES;
}

#pragma ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.isGradualNavBarColor && !self.isViewWillDisappear){
        CGFloat minAlphaOffset = - 64;
        CGFloat maxAlphaOffset = 200;
        CGFloat tempAlpha;
        CGFloat offset = scrollView.contentOffset.y;
        CGFloat alpha = (offset - minAlphaOffset) / maxAlphaOffset;
        tempAlpha = 1 - ((offset - minAlphaOffset) / maxAlphaOffset);
        if(alpha >= 1){
            alpha = 1;
            [self setNeedsStatusBarAppearanceUpdate];
            [self.back setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
            [self.share setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
        }else if(alpha <= 0){
            alpha= 0;
            [self setNeedsStatusBarAppearanceUpdate];
            [self.back setImage:[UIImage imageNamed:@"backWhite"] forState:(UIControlStateNormal)];
            [self.share setImage:[UIImage imageNamed:@"shareWhite"] forState:(UIControlStateNormal)];
        }
        self.navBarAlpha = alpha;
        self.navBarImageView.alpha = self.navBarAlpha;
        UIColor *color = [[UIColor alloc] initWithWhite:0 alpha:self.navBarAlpha];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : color};
        if(tempAlpha >= 0.6){
            tempAlpha = 0.6;
        }else if(tempAlpha <= 0){
            tempAlpha = 0;
        }
        self.shareBg.alpha = tempAlpha;
        self.backBg.alpha = tempAlpha;
    }
}

- (void)pjWebViewDidFinishLoad:(UIWebView *)webView{
    //定义好JS要调用的方法, back就是调用的back方法名
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"designMessage"] = ^() {
        /**
         *   这边调用OC的方法
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[designMessage]");
        });
    };
    
    context[@"appointmentDesign"] = ^() {
        /**
         *   这边调用OC的方法
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[appointmentDesign]");
        });
    };
}

- (void)designMessage{
    [MobClick event:MobClickDesignInfo];
}

- (void)appointmentDesign{
    [MobClick event:MobClickDesignAppointment];
}

@end
