//
//  UIFont+Style.m
//  MJBangProject
//
//  Created by X团 on 16/5/13.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "UIFont+Style.h"

@implementation UIFont (Style)

+(UIFont *)systemFontOfSizeAndSetStyle:(CGFloat)fontSize {

    UIFont * font = nil;
    if (IOS_VERSION >= 8.2) {
        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    } else {
        font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    }
    return font;
}

@end
