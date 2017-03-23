//
//  UIColor+PJ.h
//  edu
//
//  Created by ChenDaXin on 16/5/18.
//  Copyright © 2016年 cdx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PJ)

// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
