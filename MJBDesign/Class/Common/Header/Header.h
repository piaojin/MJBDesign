//
//  Header.h
//
//
//  Created by piaojin on 16-12-6.
//  Copyright (c) 2016年 piaojin. All rights reserved.
//

#ifndef X_____Header_h
#define X_____Header_h

/*********************
 *       头文件       *
 *********************/

#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "PJConst.h"
#import "MJBHTTPManager.h"
#import "MJExtension.h"
#import "MJBColor.h"
#import "SVProgressHUD.h"
#import "NSString+PJ.h"
#import "Masonry.h"
#import "PJMobClickConst.h"
#import "UMMobClick/MobClick.h"
#import "PJHtmlConst.h"
#import "UIView+DXProgress.h"
#import "UIFont+Style.h"

//********************************************************
//********************************************************

#define WeakSelf __weak typeof(self) weakSelf = self;

//屏幕尺寸比例
#define ADAPTIVEIPHPONEWIDTH(x)  (((float)(x) / 320.0) * SCREENWITH)
#define ADAPTIVEIPHPONEHEIGHT(y) (SCREENHEIGHT == 480 ? (((float)(y) / 480.0) * SCREENHEIGHT) : (((float)(y) / 568.0) * SCREENHEIGHT))

//屏幕物理高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕物理宽度
#define SCREENWITH   [UIScreen mainScreen].bounds.size.width

#define UIScale SCREENHEIGHT / 568.0

//定义一个define函数
#define TT_RELEASE_CF_SAFELY(__REF) { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }

//NavBar高度
#define NavigationBar_HEIGHT 44

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define PJKeyWindow [[[UIApplication sharedApplication] delegate] window]

//导航栏6.7的高度
#define STATUS_HEIGHT ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0 ? 44.0 : 64.0)

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
#endif
