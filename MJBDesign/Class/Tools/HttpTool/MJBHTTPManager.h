//
//  DXHttpTool.h
//  MJBangProject
//
//  Created by DavidWang on 16/8/5.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum : NSUInteger {
    MJBGET = 0,
    MJBPOST = 1
} MJBRequestMethod;

typedef void(^MJBResponse)(id response);
typedef void(^MJBResponseSuccess)(id response);
typedef void(^MJBResponseFailure)(NSError *error);

@interface MJBHTTPManager : AFHTTPSessionManager

+ (instancetype)sharedTool;

/**
 *   判断网络是否可用
 *
 */
+(BOOL) isConnectionAvailable;

/**
 *  发送网络请求
 *
 *  @param method     请求方式(GET/POST)
 *  @param URLString  接口地址
 *  @param parameters 参数
 */
+ (void)request:(MJBRequestMethod)method URLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters success:(MJBResponseSuccess) success failure:(MJBResponseFailure)failure;

/**
 *   获取最新设计案例
 */
+ (void)getNewCase:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;

/**
 *   获取轮播数据
 */
+ (void)getAd:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;

/**
 *   获取最新方案详情
 */
+ (void)getNewCaseInfo:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;

/**
 *   获取家居体验馆
 */
+ (void)getExperienceHouse:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;

/**
 *   获取最新方案图片详情
 */
+ (void)getPics:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;

/**
 *   体验家
 */
+ (void)getUsershow:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;

/**
 *   体验家详情
 */
+ (void)getUsershowInfo:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure;
@end
