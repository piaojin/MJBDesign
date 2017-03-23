//
//  UIView+DXProgress.h
//  MJBangProject
//
//  Created by DavidWang on 16/8/26.
//  Copyright © 2016年 X团. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DXProgress)

/**
 *  显示网络请求加载视图
 */
- (void)showLoading;
- (void)dismissLoading;

/**
 *  显示网页加载进度条
 */
- (void)showProgressBar;

- (void)showProgressBarTop;

- (void)dismissProgressBar;

@end
