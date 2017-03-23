//
//  PJBaseButton.m
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseButton.h"

@implementation MJBBaseButton

+ (MJBBaseButton *)defaultButton:(NSString *)title font:(UIFont *)font frame:(CGRect)frame{
    MJBBaseButton *defaultButton = [[MJBBaseButton alloc]initWithFrame:frame];
    CGFloat radius = frame.size.height / 2.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                          byRoundingCorners:(UIRectCornerAllCorners)
                                cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = defaultButton.bounds;
    layer.path = path.CGPath;
    defaultButton.layer.mask = layer;
    defaultButton.backgroundColor = MainColor;
    [defaultButton setTitle:title forState:UIControlStateNormal];
    defaultButton.titleLabel.font = font;
    return defaultButton;
}

@end
