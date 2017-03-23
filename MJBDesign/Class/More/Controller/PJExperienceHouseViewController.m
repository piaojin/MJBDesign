//
//  PJBoloniViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/12.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJExperienceHouseViewController.h"
#import "PJExperienceModel.h"
#import "PJExperienceCell.h"
#import "PJCacheManager.h"


@implementation PJExperienceHouseDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object{
    if(object){
        return [PJExperienceCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}

@end

@interface PJExperienceHouseViewController ()

@property (strong, nonatomic)PJExperienceHouseDataSource *experienceHouseDataSource;
/**
 *   缓存的数据只在第一次网络请求完成之前加载，数据请求成功需要把显示的缓存数据移除，才能保证数据的正确
 */
@property (assign, nonatomic)BOOL isRemoveCacheData;
@property (strong, nonatomic)NSArray *cacheArr;
//每次保存一次缓存数据
@property(nonatomic,assign)BOOL isCache;

@end

@implementation PJExperienceHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家居体验馆";
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.tableView.backgroundColor = RGBCOLOR(246, 246, 246);
    self.isLoadFromXIB = YES;
    [self loadCache];
    [self doRequest:MJBGET];
}

/**
 *   每次先从缓存中加载数据
 */
- (void)loadCache{
    id cacheData = [PJCacheManager getCancheDataForKey:ExperienceHouseCache];
    if(cacheData){
        NSArray *arr = [PJExperienceModel mj_objectArrayWithKeyValuesArray:cacheData];
        self.cacheArr = arr;
        if(arr.count > 0){
            [self addItems:arr];
            self.experienceHouseDataSource.items = self.items;
            [self createDataSource];
        }
    }else{
        [self.view showLoading];
    }
}

#pragma 网络请求
- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure{
    if(success){
        if(success && !self.isCache){
            /**
             *   缓存数据
             */
            [PJCacheManager cacheData:success Key:ExperienceHouseCache];
            self.isCache = YES;
        }
        NSArray<PJExperienceModel *> *arr = [PJExperienceModel mj_objectArrayWithKeyValuesArray:success];
        /**
         *   缓存的数据只在第一次网络请求完成之前加载，数据请求成功需要把显示的缓存数据移除，才能保证数据的正确
         */
        if(!_isRemoveCacheData){
            [self.items removeObjectsInArray:self.cacheArr];
            _isRemoveCacheData = YES;
        }
        [self addItems:arr];
        self.experienceHouseDataSource.items = self.items;
        [self createDataSource];
    }
}

- (void)createDataSource{
    self.dataSource = self.experienceHouseDataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 显示加载失败页面
 */
- (void)showError:(BOOL)show{
    
}

- (NSString *)requestUrl{
    return @"/api/gallery/get_experience_house";
}

- (PJExperienceHouseDataSource *)experienceHouseDataSource{
    if(!_experienceHouseDataSource){
        _experienceHouseDataSource = [[PJExperienceHouseDataSource alloc] init];
        _experienceHouseDataSource.controller = self;
    }
    return _experienceHouseDataSource;
}

- (NSMutableDictionary *)params{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.page) forKey:@"page"];
    [params setObject:@(self.limit) forKey:@"limit"];
    return params;
}

@end
