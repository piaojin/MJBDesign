//
//  UIImage+PJ.h
//  yule
//
//  Created by SSCedric on 14/11/14.
//  Copyright (c) 2014年 com.feibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PJ)

//根据指定大小压缩图片
- (UIImage *)compressImageToSize:(CGSize)size;

//根据指定宽度等比压缩图片
- (UIImage *)compressImageToWitdh:(CGFloat)width;

- (UIImage *)compressImageWith:(CGRect)rect;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
