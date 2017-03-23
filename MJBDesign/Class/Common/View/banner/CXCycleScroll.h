//
//  CXCycleScroll.h
//  MJBangProject
//
//  Created by X团 on 15/11/19.
//  Copyright © 2015年 X团. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"

@protocol CXCycleScrollDelegate;

@interface CXCycleScroll : UIView

@property (assign, nonatomic) DDPageControlType pageType;
@property (strong, nonatomic) UIColor * onColor;
@property (strong, nonatomic) UIColor * offColor;
@property (assign, nonatomic) CGFloat   indicatorDiameter;
@property (assign, nonatomic) CGFloat   indicatorSpace;
@property (strong, nonatomic) UIImage * placeholderImage;

@property (strong, nonatomic) NSString * mark;
@property (nonatomic, strong) NSArray * bannerArray;
@property (weak, nonatomic) id<CXCycleScrollDelegate>delegate;

- (void)create;

@end

@protocol CXCycleScrollDelegate <NSObject>

@optional
- (void)CXCycleScrollView:(CXCycleScroll *)cycleScrollView withTouchIndex:(NSInteger )index object:(id)object;

@end