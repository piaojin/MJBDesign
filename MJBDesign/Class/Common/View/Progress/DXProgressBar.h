//
//  DXProgressBar.h
//  MJBangProject
//
//  Created by DavidWang on 16/7/25.
//  Copyright © 2016年 X团. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXProgressBar : UIProgressView

+ (instancetype)sharedProgressBar;

/**
 *  展示进度条
 */
- (void)starProgressDisplay;

/**
 *  停止展示进度条
 */
- (void)stopProgressDisplay;

@end
