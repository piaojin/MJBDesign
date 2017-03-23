//
//  PJBaseWebViewController.m
//  MJBangProject
//
//  Created by piaojin on 16/11/8.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "MJBBaseWebViewController.h"
#import "ShareManager.h"

@interface MJBBaseWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic)NSURLRequest *request;
@property (weak, nonatomic) UIImage *shareImage;
@property (strong, nonatomic)UIButton *backButton;
/**
 *   是否成功加载过一次，webView如果第一次加载失败，直接调用reload方法会无效
 */
@property (assign, nonatomic)BOOL hasLoadSuccess;

@end

@implementation MJBBaseWebViewController

#pragma mark - 初始化

- (instancetype)initWithUrl:(NSString *)urlStr{
    if(self = [super init]){
        self.urlStr = urlStr;
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isViewWillDisappear = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isViewWillDisappear = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.webViewTitle;
    NSLog(@"%@",self.urlStr);
    if(self.isShare){
        //分享按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }

    //webView
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    
    if(self.isGradualNavBarColor){
        self.webView.frame = CGRectMake(0, -64, self.view.width, self.view.height + 64);
    }else{
        self.webView.frame = CGRectMake(0, 0, SCREENWITH, SCREENHEIGHT);
    }
    
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
    
    //页面背景色
//    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#ffffff'"];
    
    MJRefreshNormalHeader *freshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginPullDownRefreshing)];
    self.webView.scrollView.mj_header = freshHeader;
    
    [freshHeader setTitle:@"下拉刷新" forState:(MJRefreshStateIdle)];
    [freshHeader setTitle:@"松开刷新" forState:(MJRefreshStatePulling)];
    [freshHeader setTitle:@"刷新中..." forState:(MJRefreshStateRefreshing)];
    freshHeader.lastUpdatedTimeLabel.hidden = YES;
    freshHeader.stateLabel.font = [UIFont systemFontOfSizeAndSetStyle:12.0];
    freshHeader.stateLabel.textColor = RGBCOLOR(178, 178, 178);
    freshHeader.arrowView.alpha = 0;
    
    //加载网页
    NSString *channel = @"channel=app_mjb";
    NSRange rangeOfChannel = [self.urlStr rangeOfString:channel];
    NSString *tempUrl;
    if(rangeOfChannel.location == NSNotFound){
        if([self.urlStr rangeOfString:@"?"].location == NSNotFound){
            tempUrl = [NSString stringWithFormat:@"%@?channel=app_mjb",self.urlStr];
        }else{
            tempUrl = [NSString stringWithFormat:@"%@&channel=app_mjb",self.urlStr];
        }
    }
    self.urlStr = tempUrl;
    NSLog(@"UIWebView请求地址:%@",self.urlStr);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    self.request = request;
    [self.webView loadRequest:request];
    
    if(self.isShowBack){
        [self.view addSubview:self.backButton];
        _backButton.hidden = YES;
    }else{
        _backButton.hidden = YES;
    }
}
                               
- (void)shareClick {
    if([NSString isBlankString:self.shareUrl]){
        [SVProgressHUD showErrorWithStatus:@"分享的url不能为空!"];
        return;
    }
    [ShareManager showShareWithTitle:self.shareTitle descr:self.shareContent shareUrl:self.shareUrl shareIcon:self.shareIcon showView:PJKeyWindow completion:^(id result, NSError *error) {
        
    }];
}

/**
 *   返回上一网页
 */
- (void)goBackPage{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }
}

- (void)beginPullDownRefreshing{
    [self showError:NO];
    if(_hasLoadSuccess){
        [self.webView reload];
    }else{
        NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        self.request = rq;
        [self.webView loadRequest:rq];
    }
}
                               
- (void)backView:(BOOL)animated{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }else{
        [super backView:YES];
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    switch (self.loadType) {
        case LineProgress:
            [self.view showProgressBar];
            break;
        case RoundProgress:
            [self.view showLoading];
            break;
        default:
            [self.view showProgressBar];
            break;
    }
    [self showError:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView.scrollView.mj_header endRefreshing];
    [self dismissLoading];
    [self showError:NO];
    _hasLoadSuccess = YES;
    [self pjWebViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.webView.scrollView.mj_header endRefreshing];
    [self dismissLoading];
    [self showError:YES];
    NSLog(@"UIWebView错误:%@",error);
    if([error code] == NSURLErrorCancelled){
        return;
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败,下拉刷新试试!"];
    }
}

- (void)pjWebViewDidFinishLoad:(UIWebView *)webView{
    
}

#pragma ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.isGradualNavBarColor && !self.isViewWillDisappear){
        CGFloat minAlphaOffset = - 64;
        CGFloat maxAlphaOffset = 200;
        CGFloat offset = scrollView.contentOffset.y;
        CGFloat alpha = (offset - minAlphaOffset) / maxAlphaOffset;
        if(alpha >= 1){
            alpha = 1;
            [self setNeedsStatusBarAppearanceUpdate];
        }else if(alpha <= 0){
            alpha= 0;
        }
        self.navBarAlpha = alpha;
        self.navBarImageView.alpha = self.navBarAlpha;
        UIColor *color = [[UIColor alloc] initWithWhite:0 alpha:self.navBarAlpha];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : color,NSFontAttributeName : [self getTitleFont]};
        if(self.isShare && !self.shareBtn.hidden){
            self.shareBtn.alpha = self.navBarAlpha;
        }
    }
}

- (void)dismissLoading{
    switch (self.loadType) {
        case LineProgress:
            [self.view dismissProgressBar];
            break;
        case RoundProgress:
            [self.view dismissLoading];
            break;
        default:
            [self.view dismissProgressBar];
            break;
    }
}

- (void)showError:(BOOL)show{
    WeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        if(show){
            if(!weakSelf.hasLoadSuccess && weakSelf.isShowBack){
                weakSelf.backButton.hidden = YES;
            }
        }else{
            weakSelf.backButton.hidden = NO;
        }
    }];
    
    if(![self.webView canGoBack]){
        self.backButton.hidden = YES;
    }
}

- (UIButton *)backButton{
    if(!_backButton){
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"backWhite"] forState:(UIControlStateNormal)];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
        _backButton.frame = CGRectMake(10, 10 + 64, 30, 30);
        _backButton.layer.cornerRadius = _backButton.height / 2.0;
        _backButton.layer.masksToBounds = YES;
        [_backButton addTarget:self action:@selector(goBackPage) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backButton;
}

- (UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shareBtn;
}

@end
