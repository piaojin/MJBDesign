//
//  PJBaseModelViewController.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseModelViewController.h"
#import "NSString+PJ.h"

@implementation MJBBaseModelViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.isLoading = NO;
}

/**
 *  请求地址，需要子类重写
 */
- (NSString *)requestUrl{
    return nil;
}

/**
 *  请求参数，子类需重写
 */
- (NSMutableDictionary *)params{
    _params = [NSMutableDictionary dictionary];
    return _params;
}

/**
 *  缓存时间
 */
- (NSUInteger)cacheTime{
    return 0;
}

/**
 *  发起请求数据
 */
- (void)doRequest:(MJBRequestMethod)requestWay{
    self.requestWay = requestWay;
    if (![NSString isBlankString:[self requestUrl]]) {
        __block __weak typeof(self) tmpSelf = self;
        [self.params setObject:@(self.page) forKey:@"page"];
        [self.params setObject:@(self.limit) forKey:@"limit"];
        [MJBHTTPManager request:requestWay URLString:self.requestUrl parameters:self.params success:^(id response) {
            [tmpSelf didFinishLoad:response failure:nil];
            [tmpSelf.view dismissLoading];
        } failure:^(NSError *error) {
            [tmpSelf didFailLoadWithError:error];
            [tmpSelf.view dismissLoading];
            if(![MJBHTTPManager isConnectionAvailable]){
                [self showNoNetWorkPrompt];
            }
        }];
    }else{
        [self emptyUrl];
    }
    [self requestDidStartLoad];
}

/**
 *  请求完成
 */
- (void)didFinishLoad:(id)success failure:(NSError *)failure {
    [SVProgressHUD dismiss];
    [self requestDidFinishLoad:success failure:failure];
    [self onDataUpdated];
}

/**
 *  请求失败
 */
- (void)didFailLoadWithError:(NSError *)failure {
    [SVProgressHUD dismiss];
    [self requestDidFailLoadWithError:failure];
    [self onLoadFailed];
}

/**
 *  请求完成后数据传递给子类，子类需要重写
 */
- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure {
    
}

/**
 *  请求失败后数据传递给子类，子类需要重写
 */
- (void)requestDidFailLoadWithError:(NSError *)failure {
}

/**
 *  加载失败
 */
- (void)onLoadFailed {
    [self showLoading:NO];
    [self showError:YES];
    self.isLoading = NO;
}

- (void)emptyUrl{
    NSLog(@"url不能为空!");
}

#pragma 空页面点击事件
- (void)emptyClick{
    [self.view showLoading];
    self.isLoading = YES;
    [self showLoading:YES];
    [self showEmpty:NO];
    [self doRequest:self.requestWay];
}

#pragma error页面点击事件
- (void)errorClick{
    [self.view showLoading];
    self.isLoading = YES;
    [self showLoading:YES];
    [self showError:NO];
    [self doRequest:self.requestWay];
}

/**
 *  数据开始更新
 */
- (void)onDataUpdated {
    [self showLoading:NO];
    [self showError:NO];
    self.isLoading = NO;
}

/**
 *  开始请求，子类需要重写
 */
- (void)requestDidStartLoad {
    
    //不是在下拉刷新
    if (!self.isPullingUp) {
        [self showLoading:YES];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //如果现在加载中而且不是在下拉刷新
            if (self.isLoading && !self.isPullingUp) {
                [self showLoading:YES];
            }
        });
    }
    [self showError:NO];
    self.isLoading = YES;
}

- (NSMutableArray *)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

//添加数据，每次请求完数据调用,item即是model的集合
- (void)addItems:(NSArray *)item{
    if(item && item.count > 0){
        [self.items addObjectsFromArray:item];
        _newItemsCount = item.count;
    }else{
        _newItemsCount = 0;
    }
}

//添加数据，每次请求完数据调用,item即是一个model
- (void)addItem:(id)item{
    if(item){
        [self.items addObject:item];
        _newItemsCount = 1;
    }else{
        _newItemsCount = 0;
    }
}

- (int)limit{
    return 6;
}

@end
