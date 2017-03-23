//
//  PJBaseViewController.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseViewController.h"
#import "MJBBaseModel.h"
#import "Reachability.h"

@interface MJBBaseViewController ()
@property (strong, nonatomic)Reachability *hostReach;
@end

@implementation MJBBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isViewWillDisappear = NO;
    [MobClick beginLogPageView:MobClickHome];//("PageOne"为页面名称，可自定义)
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isViewWillDisappear = YES;
    [SVProgressHUD dismiss];
}

- (void)dealloc{
    [SVProgressHUD dismiss];
}

/*
 * 控制器传值
 *
 */
- (id)initWithQuery:(NSDictionary *)query {
    self = [super init];
    if (self) {
        if (query) {
            self.query = query;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_isRootViewController){
        [self initNavigationController];
    }
    [self initView];
    if(self.isGradualNavBarColor){
        self.navBarAlpha = 0;
    }else{
        self.navBarAlpha = 1;
    }
    
    self.navBarImageView = self.navigationController.navigationBar.subviews.firstObject;
    self.navBarImageView.alpha = self.navBarAlpha;
    UIColor *color = [[UIColor alloc] initWithWhite:0 alpha:self.navBarAlpha];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[self getTitleFont],NSForegroundColorAttributeName : color};
    
    [self initNotification];
}

- (void)initNotification{
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];//可以以多种形式初始化
    [self.hostReach startNotifier];  //开始监听,会启动一个run loop
    
    [self updateInterfaceWithReachability: self.hostReach];
}

//监听到网络状态改变
- (void) reachabilityChanged: (NSNotification* )note

{
    
    Reachability* curReach = [note object];
    
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    [self updateInterfaceWithReachability: curReach];
    
}

//处理连接改变后的情况
- (void) updateInterfaceWithReachability: (Reachability*) curReach

{   //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
            NSLog(@"\n无网络\n");
            [self showNoNetWorkPrompt];
            break;
        case ReachableViaWiFi:
            NSLog(@"\n网络类型:wifi\n");
            break;
        case ReachableViaWWAN:
            NSLog(@"\n网络类型:4G/3G/2G\n");
            break;
        default:
            
            break;
    }
}

/**
 *   初始化UI
 */
- (void)initView{
    
}

/**
 *   初始化导航栏
 */
- (void)initNavigationController{
    if(self.navigationController){
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.navigationBarHidden = NO;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backView:)];
    }
}

/**
 * 返回方法,可自定义重写,可以控制动画效果
 */
- (void)backView:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma setter,getter

/**
 *   设置导航栏字体大小
 *
 */
- (UIFont *)getTitleFont{
    return [UIFont systemFontOfSizeAndSetStyle:18.0];
}

/**
 *   设置导航栏标题颜色
 *
 */
- (UIColor *)getTitleTextColor{
    return [UIColor blackColor];
}

/**
 * 自定义返回按钮 文字设置 若需要则重载
 */
- (NSString *)backButtonTilte{
    return nil;
}

#pragma 空页面点击事件
- (void)emptyClick{
    
}

#pragma error页面点击事件
- (void)errorClick{
    
}

- (UIImageView *)navBarImageView{
    if(!_navBarImageView){
        _navBarImageView = self.navigationController.navigationBar.subviews.firstObject;
    }
    return _navBarImageView;
}

/**
 * 显示空页面
 */
- (void)showEmpty:(BOOL)show{
    if (show) {
        if(!_emptyView){
             [self.view addSubview:self.emptyView];
        }
        [self.view bringSubviewToFront:_emptyView];
        _emptyView.backgroundColor = [self.view backgroundColor];
        self.emptyView.hidden = NO;
    } else {
        self.emptyView.hidden = YES;
    }
}

//空视图子类可以重写
- (MJBEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[MJBEmptyView alloc] initEmptyView:[self getEmptyFrame]];
        _emptyView.hidden = YES;
        _emptyView.delegate = self;
    }
    
    return _emptyView;
}

- (CGRect)getEmptyFrame{
    return self.view.bounds;
}

/**
 *   设置为空时的提示文字
 *
 */
- (void)setEmptyText:(NSString *)text{
    [self.emptyView setEmptyText:text];
}

/**
 *   设置出错时的提示文字
 *
 */
- (void)setErrorText:(NSString *)text{
    [self.errorView setErrorText:text];
}

/**
 * 显示加载失败页面
 */
- (void)showError:(BOOL)show{
    if (show) {
        if (!_errorView) {
            [self.view addSubview:self.errorView];
        }
        [self.view bringSubviewToFront:_errorView];
        _errorView.backgroundColor = [self.view backgroundColor];
        _errorView.hidden = NO;
    }
    else{
        _errorView.hidden = YES;
    }
}

//出错页面子类可以重写
- (MJBErrorView *)errorView{
    if(!_errorView){
        _errorView = [[MJBErrorView alloc] initErrorView:[self getErrorViewFrame]];
        _errorView.delegate = self;
    }
    return _errorView;
}

- (CGRect)getErrorViewFrame{
    return self.view.bounds;
}

- (void)showLoading:(BOOL)show{
    if(show){
        [self.view showLoading];
    }else{
        [self.view dismissLoading];
    }
}

- (void)showNoNetWorkPrompt
{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"网络不稳";
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBCOLOR(129, 0, 128);
    [label sizeToFit];
    
    CGFloat labelx=0;
    CGFloat labelw=SCREENWITH;
    CGFloat labelh=64;
    CGFloat labely=-labelh;
    
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    visualEffectView.frame = CGRectMake(labelx, labely, labelw, labelh);
    [visualEffectView addSubview:label];
    
    label.frame=CGRectMake((visualEffectView.width - label.width) / 2.0, (visualEffectView.height - label.height) / 2.0, label.width, label.height);
    label.alpha = 0.6;
    
    [PJKeyWindow addSubview:visualEffectView];
    
    // 6.动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        visualEffectView.transform = CGAffineTransformMakeTranslation(0, visualEffectView.frame.size.height);
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复到原来的位置
            visualEffectView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            // 删除控件
            [visualEffectView removeFromSuperview];
        }];
    }];
}

#pragma 3D Touch
//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    return nil;
}

//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

@end
