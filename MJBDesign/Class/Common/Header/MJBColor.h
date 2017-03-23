//
//  MJBColor.h
//  MJBangProject
//
//  Created by X团 on 15-3-31.
//  Copyright (c) 2015年 X团. All rights reserved.
//

#ifndef MJBangProject_MyColor_h
#define MJBangProject_MyColor_h

/*********************
 *      颜色宏定义     *
 *********************/

//for example : (248,248,248,1)
#define RGBCOLOR(R,G,B) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:1.0]
//for example : 0xeeeeee
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MainColor RGBCOLOR(127, 37, 102)

// 随机色
#define PJRandomColor RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif
