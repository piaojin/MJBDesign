//
//  PJCacheManager.h
//  MJBDesign
//
//  Created by piaojin on 16/12/14.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
//清除缓存成功通知
#define ClearCacheSuccess @"ClearCacheSuccess"

@interface PJCacheManager : NSObject

+ (void)cacheData:(id)data Key:(NSString *)key;

+ (id)getCancheDataForKey:(NSString *)key;

// 显示缓存大小
+(NSString *)cacheSize;

// 清理缓存
+ (void)clearCacheFile;

@end
