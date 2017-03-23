//
//  DXLoading.m
//  MJBangProject
//
//  Created by DavidWang on 16/8/26.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "DXLoading.h"

@interface DXLoading ()

@property (weak, nonatomic) UIImageView *activityImgView;
@property (weak, nonatomic) UIImageView *bgImgView;
@property (weak, nonatomic)UIImageView *logoImageView;

@end

@implementation DXLoading

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    //背景图
//    UIImageView *bgImgView = [[UIImageView alloc] init];
//    [self addSubview:bgImgView];
//    
//    bgImgView.image = [UIImage imageNamed:@"DXProgressHUD.bundle/bg"];
//    self.bgImgView = bgImgView;
    
    //旋转图
    UIImageView *activityImgView = [[UIImageView alloc] init];
    activityImgView.image = [UIImage imageNamed:@"DXProgressHUD.bundle/PJLoading"];
    [self addSubview:activityImgView];
    self.activityImgView = activityImgView;
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    self.logoImageView = logoImageView;
    [self addSubview:logoImageView];
    
    //动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(2 * M_PI);
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1.0;
    anim.removedOnCompletion = NO;
    [activityImgView.layer addAnimation:anim forKey:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgImgView.frame = self.bounds;
    CGFloat margin = ADAPTIVEIPHPONEWIDTH(15);
    CGFloat wh = self.bounds.size.width - margin * 2;
    self.activityImgView.frame = CGRectMake(margin, margin, wh, wh);
    
    CGFloat W = ADAPTIVEIPHPONEWIDTH(30);
    self.logoImageView.frame = CGRectMake(0, 0, W, W);
    self.logoImageView.center = self.activityImgView.center;
}

+ (instancetype)loading {
    return [[self alloc] init];
}

//- (void)dealloc {
//    
//}

@end
