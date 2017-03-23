//
//  PJHTTPManager.m
//  MJBangProject
//
//  Created by DavidWang on 16/8/5.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "MJBHTTPManager.h"
#import "MJExtension.h"
#import "MJBHttpModel.h"
#import "SVProgressHUD.h"
#import "Reachability.h"

@implementation MJBHTTPManager

+ (instancetype)sharedTool {
    
    NSString *baseURLStr = MJBBaseURL;
    MJBHTTPManager *tool = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLStr]];
    tool.requestSerializer.timeoutInterval = 10;
    [tool.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return tool;
}

+  (void)request:(MJBRequestMethod)method URLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure {
    
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    
    NSLog(@"请求的地址:%@%@\n请求的参数parameters:%@",MJBBaseURL,URLString,parameters);
    
    //请求成功的回调
    void(^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id response){
        MJBHttpModel *model = [MJBHttpModel mj_objectWithKeyValues:response];
        
        if (model.status != 200) { //错误提示
            [SVProgressHUD showErrorWithStatus:@"哎哟，网络不行哟!"];
        } else {
            
            if (success) {
                success(model.data);
            }
        }
        
    };
    
    //请求失败的回调
    void(^failureBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"%@", URLString);
        
        NSDictionary *errorDic = error.userInfo;
        NSString *errorMesssage = [errorDic objectForKey:NSLocalizedFailureReasonErrorKey];
        NSLog(@"错误原因:%@", errorMesssage);
        
        if (failure) {
            failure(error);
        }
    };
    
    NSString *baseURLStr = MJBBaseURL;
    MJBHTTPManager *manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLStr]];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //发送网络请求
    if (method == MJBGET) {
        [manager GET:URLString parameters:parameters success:successBlock failure:failureBlock];
    } else {
        [manager POST:URLString parameters:parameters success:successBlock failure:failureBlock];
    }
}

/**
 *   获取最新设计案例
 */
+ (void)getNewCase:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBPOST URLString:@"/api/gallery/new_cases" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   获取最新方案详情
 */
+ (void)getNewCaseInfo:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBGET URLString:@"/api/gallery/new_case_info" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   获取轮播数据
 */
+ (void)getAd:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBPOST URLString:@"/api/package/getads" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   获取家居体验馆
 */
+ (void)getExperienceHouse:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBGET URLString:@"/api/gallery/get_experience_house" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   获取最新方案图片详情
 */
+ (void)getPics:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBGET URLString:@"/api/gallery/get_pics" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   体验家
 */
+ (void)getUsershow:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBGET URLString:@"/api/gallery/get_usershow" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   体验家详情
 */
+ (void)getUsershowInfo:(NSMutableDictionary *)params success:(MJBResponseSuccess)success failure:(MJBResponseFailure)failure{
    [self request:MJBGET URLString:@"/api/gallery/get_usershow_info" parameters:params success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *   判断网络是否可用
 *
 */
+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    
    return isExistenceNetwork;
}

@end
