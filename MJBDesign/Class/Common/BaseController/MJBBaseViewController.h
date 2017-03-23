//
//  PJBaseViewController.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBEmptyView.h"
#import "MJBErrorView.h"
#import "SVProgressHUD.h"
@class MJBBaseViewModel,MJBBaseModel,MJBEmptyView,MJBErrorView;



@interface MJBBaseViewController : UIViewController<MJBEmptyViewDelegate,MJBErrorViewDelegate,UIViewControllerPreviewingDelegate>

//空视图
@property (strong, nonatomic)MJBEmptyView *emptyView;
//出错视图
@property (strong, nonatomic)MJBErrorView *errorView;
//用于各个控制器之间传值
@property (strong, nonatomic)NSDictionary *query;
//数据模型
@property (strong, nonatomic)MJBBaseModel *pjBaseModel;
//是否为根视图
@property (nonatomic, assign) BOOL isRootViewController;
#pragma 导航栏渐变导致的问题:多个地方如果都有渐变的效果，则在这些导航栏切换的时候上个的控制器的渐变值会带到下一个，导致渐变错乱，因为这些控制器用的都是同一个导航栏，故改变的是同一个导航栏的渐变值
/**
 *   导航栏是否渐变
 */
@property (assign, nonatomic)BOOL isGradualNavBarColor;
/**
 *   导航栏背景视图
 */
@property (weak, nonatomic)UIImageView *navBarImageView;
/**
 *   导航栏渐变透明度
 */
@property (assign, nonatomic)CGFloat navBarAlpha;
@property (assign, nonatomic)BOOL isViewWillDisappear;
/*
 * 控制器传值
 *
 */
- (id)initWithQuery:(NSDictionary *)query;

/**
 *   初始化UI
 */
- (void)initView;

/**
 *   初始化导航栏
 */
- (void)initNavigationController;

/**
 * 返回方法,可自定义重写,可以控制动画效果
 */
- (void)backView:(BOOL)animated;
/**
 * 显示正在加载
 */
- (void)showLoading:(BOOL)show;

/**
 * 显示空页面
 */
- (void)showEmpty:(BOOL)show;

/**
 * 自定义返回按钮 文字设置 若需要则重载
 */
- (NSString *)backButtonTilte;

/**
 * 显示加载失败页面
 */
- (void)showError:(BOOL)show;

/**
 * 加载失败页面frame
 */
- (CGRect)getErrorViewFrame;

/**
 * 空页面frame
 */
- (CGRect)getEmptyFrame;

/**
 *   设置为空时的提示文字
 */
- (void)setEmptyText:(NSString *)text;

/**
 *   设置导航栏字体大小
 *
 */
- (UIFont *)getTitleFont;

/**
 *   设置导航栏标题颜色
 *
 */
- (UIColor *)getTitleTextColor;

/**
 *   没有网络提示
 */
- (void)showNoNetWorkPrompt;

@end
