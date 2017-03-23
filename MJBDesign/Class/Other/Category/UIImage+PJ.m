//
//  UIImage+PJ.m
//  yule
//
//  Created by SSCedric on 14/11/14.
//  Copyright (c) 2014年 com.feibo. All rights reserved.
//

#import "UIImage+PJ.h"

@implementation UIImage (PJ)

- (UIImage *)compressImageWith:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:CGRectMake(rect.origin.x,
                                rect.origin.y,
                                rect.size.width,
                                rect.size.height)];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)compressImageToSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    return [self compressImageWith:rect];
}

- (UIImage *)compressImageToWitdh:(CGFloat)width
{
    CGFloat scale = width / self.size.width;
    CGFloat distinationHgt = self.size.height * scale;
    CGSize distinationSize = CGSizeMake(width, distinationHgt);
    
    return [self compressImageToSize:distinationSize];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
