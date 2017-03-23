//
//  UIView+DXProgress.m
//  MJBangProject
//
//  Created by DavidWang on 16/8/26.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "UIView+DXProgress.h"
#import "DXLoading.h"
#import "DXProgressBar.h"

@implementation UIView (DXProgress)

- (void)showLoading {
    DXLoading *loadingView = [DXLoading loading];
    [self addSubview:loadingView];
    
    CGFloat wh = ADAPTIVEIPHPONEWIDTH(65);
    CGFloat x = (SCREENWITH - wh) * 0.5;
    CGFloat y = (SCREENHEIGHT - wh) * 0.5;
    loadingView.frame = CGRectMake(x, y, wh, wh);
}

- (void)dismissLoading {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[DXLoading class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (void)showProgressBar {
    DXProgressBar *bar = [DXProgressBar sharedProgressBar];
    [self addSubview:bar];
    bar.frame = CGRectMake(0, 64, SCREENWITH, 5);
    [bar starProgressDisplay];
}

- (void)showProgressBarTop {
    DXProgressBar *bar = [DXProgressBar sharedProgressBar];
    [self addSubview:bar];
    bar.frame = CGRectMake(0, 0, SCREENWITH, 5);
    [bar starProgressDisplay];
}

- (void)dismissProgressBar {
    [[DXProgressBar sharedProgressBar] stopProgressDisplay];
}

@end
