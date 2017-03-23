//
//  PJSetterViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/9.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJSetterViewController.h"
#import "PJSetterCell.h"
#import "PJCacheManager.h"
#import "SetterModel.h"
#import "ShareManager.h"
#define Recommend 0 //推荐
#define ClearCache 0
@implementation PJSetterDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object{
    if(object && [object isKindOfClass:[SetterModel class]]){
        return [PJSetterCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionsItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section < self.sectionsItems.count){
        if(indexPath.section == 0){
            id object = self.sectionsItems[indexPath.section];
            return object;
        }else{
            NSArray *arr = self.sectionsItems[indexPath.section];
            if(indexPath.row < arr.count){
                return arr[indexPath.row];
            }
            return nil;
        }
    }else{
        return nil;
    }
}

@end

@interface PJSetterViewController ()

@end

@implementation PJSetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    [self setForbidLoadMore:YES];
    [self setForbidRefresh:YES];
    self.isLoadFromXIB = YES;
    self.tableView.backgroundColor = RGBCOLOR(246, 246, 246);
    self.tableView.sectionFooterHeight = 0;
    [self createDataSource];
    [self initCache];
}

/**
 *  获取缓存大小
 */
- (void)initCache{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCacheSuccess) name:ClearCacheSuccess object:nil];
    
    WeakSelf;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *cache = [PJCacheManager cacheSize];
        NSLog(@"缓存:%@",cache);
        [weakSelf updateCache:cache];

    });
}

/**
 *  更新显示缓存大小
 *
 */
- (void)updateCache:(NSString *)cache{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        if(indexPath.section < self.items.count){
            NSMutableArray *rowArr = [self.items objectAtIndex:indexPath.section];
            if(indexPath.row < rowArr.count){
                SetterModel *model = [rowArr objectAtIndex:indexPath.row];
                model.value = cache;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            }
        }
        
    });
}

/**
 *  清除缓存成功
 */
- (void)clearCacheSuccess{
    NSLog(@"clearCacheSuccess");
    [SVProgressHUD showSuccessWithStatus:@"清除缓存成功!"];
    [self updateCache:@"0.0M"];
}

- (void)createDataSource{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSMutableArray *rowArr = [NSMutableArray array];
    
    //推荐
    SetterModel *recommend = [[SetterModel alloc] init];
    recommend.title = @"推荐给好友";

    //清除缓存
    SetterModel *cache = [[SetterModel alloc] init];
    cache.title = @"清空缓存";
    cache.isCache = YES;
    [rowArr addObject:cache];
    
    [dataArr addObject:recommend];
    [dataArr addObject:rowArr];
    [self addItems:dataArr];
    self.dataSource = [PJSetterDataSource dataSourceWithSectionsItems:self.items controller:self];
}

#pragma tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBCOLOR(246, 246, 246);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == Recommend){
        [ShareManager showShareWithTitle:RecommendShareTitle descr:RecommendShareContent shareUrl:RecommendShareUrl shareIcon:[UIImage imageNamed:@"logo"] showView:nil completion:^(id result, NSError *error) {
            
        }];
        [MobClick event:MobClickRecommend];
    }else if(indexPath.section == 1 && indexPath.row == ClearCache){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil
 preferredStyle:(UIAlertControllerStyleAlert)];
        
        WeakSelf;
        [alertController addAction:([UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            PJSetterCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
            if(cell){
                [cell startAnimating];
            }
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [PJCacheManager clearCacheFile];
            });
            
        }])];
        
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil])];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewStyle)tableViewStyle{
    return UITableViewStyleGrouped;
}

@end
