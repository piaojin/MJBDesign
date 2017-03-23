//
//  PJDesignViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/8.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJDesignViewController.h"
#import "PJDesignCell.h"
#import "PJDesignModel.h"
#import "PJAdModel.h"
#import "CXCycleScroll.h"
#import "PJDesignPhotoBrowserManager.h"
#import "PJDesignPreviewViewController.h"
#import "PreviewView.h"
#import "PJCacheManager.h"
#import "PJDesignMainPageViewController.h"
#import "PJBannerDetailViewController.h"

#define Preview @"Preview"//预览
@implementation PJDesignDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object{
    if([object isKindOfClass:[PJDesignModel class]]){
        return [PJDesignCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}

@end

@interface PJDesignViewController ()<CXCycleScrollDelegate,PreviewDelegate>

@property (strong, nonatomic)PJDesignDataSource *designDataSource;
@property (weak, nonatomic)CXCycleScroll *banner;
@property (strong, nonatomic)NSMutableArray *bannerArr;
@property (strong, nonatomic)PJDesignPhotoBrowserManager *designPhotoBrowserManager;
@property (strong, nonatomic)UIView *headerView;
@property (strong, nonatomic)UIBlurEffect *beffect;
@property (weak, nonatomic)UIVisualEffectView *visualEffectView;
@property (weak, nonatomic)PJDesignPreviewViewController *designPreviewViewController;
@property (weak, nonatomic)PreviewView *previewView;
/**
 *   缓存的数据只在第一次网络请求完成之前加载，数据请求成功需要把显示的缓存数据移除，才能保证数据的正确
 */
@property (assign, nonatomic)BOOL isRemoveCacheData;
@property (strong, nonatomic)NSArray *cacheArr;
@property (strong, nonatomic)NSArray *bannerCacheArr;
@property (assign, nonatomic)BOOL isRemoveBannerCacheData;
//每次保存一次缓存数据
@property(nonatomic,assign)BOOL isCache;

@end

@implementation PJDesignViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    if(self.navBarAlpha >= 1){
        return UIStatusBarStyleDefault;
    }else{
        return UIStatusBarStyleLightContent;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:MobClickHome];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:MobClickHome];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图库";
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSizeAndSetStyle:18.0],
    NSForegroundColorAttributeName:[UIColor redColor]}];
    [self doRequest:MJBPOST];
    [self loadCache];
    [self initBannerData];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.tableView.backgroundColor = RGBCOLOR(246, 246, 246);
    self.tableView.mj_header.backgroundColor = RGBCOLOR(246, 246, 246);
}

- (void)initBannerData {
    WeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"290" forKey:@"category"];
    [MJBHTTPManager getAd:params success:^(id response) {
        if(response){
            /**
             *   缓存数据
             */
            [PJCacheManager cacheData:response Key:BannerCache];
        }
        weakSelf.bannerArr = [PJAdModel mj_objectArrayWithKeyValuesArray:response];
        
        /**
         *   缓存的数据只在第一次网络请求完成之前加载，数据请求成功需要把显示的缓存数据移除，才能保证数据的正确
         */
        if(!_isRemoveBannerCacheData){
            if(weakSelf.bannerCacheArr.count > 0){
                [weakSelf.bannerArr removeObjectsInArray:weakSelf.bannerCacheArr];
            }
            _isRemoveBannerCacheData = YES;
        }
        
        [weakSelf.banner setBannerArray:weakSelf.bannerArr];
    } failure:^(NSError *error) {
        
    }];
}

/**
 *   每次先从缓存中加载数据
 */
- (void)loadCache{
    /**
     *  设计案例缓存
     */
    id cacheData = [PJCacheManager getCancheDataForKey:HomeCache];
    if(cacheData){
        NSArray *arr = [PJDesignModel mj_objectArrayWithKeyValuesArray:cacheData];
        self.cacheArr = arr;
        if(arr.count > 0){
            [self addItems:arr];
            self.designDataSource.items = self.items;
            [self createDataSource];
        }
    }else{
        [self.view showLoading];
    }
    
    /**
     *  轮播缓存
     *
     */
    id bannerCacheData = [PJCacheManager getCancheDataForKey:BannerCache];
    if(bannerCacheData){
        self.bannerCacheArr = [PJAdModel mj_objectArrayWithKeyValuesArray:bannerCacheData];
        if(self.bannerCacheArr.count > 0){
            [self.bannerArr addObjectsFromArray:self.bannerCacheArr];
            [self.banner setBannerArray:self.bannerArr];
        }
    }
}

#pragma 网络请求
- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure{
    if(success && !self.isCache){
        /**
         *   缓存数据
         */
        [PJCacheManager cacheData:success Key:HomeCache];
        self.isCache = YES;
    }
    NSArray *arr = [PJDesignModel mj_objectArrayWithKeyValuesArray:success];
    /**
     *   缓存的数据只在第一次网络请求完成之前加载，数据请求成功需要把显示的缓存数据移除，才能保证数据的正确
     */
    if(!_isRemoveCacheData){
        [self.items removeObjectsInArray:self.cacheArr];
        _isRemoveCacheData = YES;
    }
    [self addItems:arr];
    self.designDataSource.items = self.items;
    [self createDataSource];
}

- (void)createDataSource{
    self.dataSource = self.designDataSource;
}

- (void)beforePullDownRefreshing{
    [self initBannerData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 260 * UIScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

#pragma cell子控件点击事件
- (void)action:(id)sender withObject:(id)object{
    if(object){
        NSDictionary *dic = object;
        NSString *actionType = [dic valueForKey:@"ActionType"];
        if([actionType isEqualToString:Preview]){
            WeakSelf;
            UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:self.beffect];
            self.visualEffectView = visualEffectView;
            self.visualEffectView.frame = PJKeyWindow.bounds;
            [PJKeyWindow addSubview:visualEffectView];
            
            PJDesignModel *model = [dic valueForKey:@"Model"];
            PreviewView *previewView = [[PreviewView alloc] initWithModel:model];
            previewView.delegate = self;
            [self.visualEffectView addSubview:previewView];
            self.previewView = previewView;
            
            previewView.frame = CGRectZero;
            previewView.layer.cornerRadius = previewView.height / 2.0;
            previewView.layer.masksToBounds = YES;
            previewView.center = self.visualEffectView.center;
            
            [UIView animateWithDuration:0.3 animations:^{
                previewView.frame = CGRectMake(10, 65, weakSelf.visualEffectView.width - 20, weakSelf.visualEffectView.height - 130);
                previewView.layer.cornerRadius = 15.0;
                previewView.layer.masksToBounds = YES;
            }];
            [MobClick event:MobClickPreviewDesign];
        }
    }
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(object){
        PJDesignModel *tempModel = (PJDesignModel *)object;
        self.designPhotoBrowserManager.member_id = tempModel.member_id;
        self.designPhotoBrowserManager.controller = self;
        [self.designPhotoBrowserManager show];
    }
}

//轮播点击事件
- (void)CXCycleScrollView:(CXCycleScroll *)cycleScrollView withTouchIndex:(NSInteger)index object:(id)object{
    if(object){
        WeakSelf;
        PJAdModel *model = (PJAdModel *)object;
        PJBannerDetailViewController *bannerWebViewController = [[PJBannerDetailViewController alloc] initWithUrl:model.href];
        bannerWebViewController.webViewTitle = model.title;
        bannerWebViewController.hidesBottomBarWhenPushed = YES;
        bannerWebViewController.loadType = RoundProgress;
        [weakSelf.navigationController pushViewController:bannerWebViewController animated:YES];
    }
}

#pragma PJDesignPreviewDelegate
- (void)previewCancel{
    [self closePreview:YES];
}

- (void)previewDetail:(PJDesignModel *)designModel{
    NSString *url = [NSString stringWithFormat:@"%@%@%ld.html",MJBHtmlBase,DesignDetail,(long)designModel.member_id];
    PJDesignMainPageViewController *designMainPageViewController = [[PJDesignMainPageViewController alloc] initWithUrl:url];
    designMainPageViewController.isGradualNavBarColor = YES;
    designMainPageViewController.isShare = YES;
//    designMainPageViewController.isShowBack = YES;
    designMainPageViewController.hidesBottomBarWhenPushed = YES;
    designMainPageViewController.webViewTitle = [NSString stringWithFormat:@"设计师 %@",designModel.design];
    designMainPageViewController.loadType = RoundProgress;
    designMainPageViewController.shareUrl = url;
    [self.navigationController pushViewController:designMainPageViewController animated:YES];
    
    [self closePreview:NO];
}

- (void)closePreview:(BOOL)animated{
    if(animated){
        WeakSelf;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.previewView.frame = CGRectZero;
            weakSelf.previewView.center = weakSelf.visualEffectView.center;
        } completion:^(BOOL finished) {
            [weakSelf.previewView removeFromSuperview];
            [weakSelf.visualEffectView removeFromSuperview];
        }];
    }else{
        self.previewView.hidden = YES;
        self.visualEffectView.hidden = YES;
        [self.previewView removeFromSuperview];
        [self.visualEffectView removeFromSuperview];
    }
}

#pragma 3D Touch
//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //通过[previewingContext sourceView]拿到对应的cell的数据；
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    if (indexPath && indexPath.row < self.items.count) {
        PJDesignModel *model = [self.items objectAtIndex:indexPath.row];
        //返回预览界面
        PJDesignPreviewViewController *designPreviewViewController = [[PJDesignPreviewViewController alloc] initWithModel:model];
        return designPreviewViewController;
    }else{
        return nil;
    }
}

//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    if(indexPath && indexPath.row < self.items.count){
        PJDesignModel *model = [self.items objectAtIndex:indexPath.row];
        NSString *url = [NSString stringWithFormat:@"%@%@%ld.html",MJBHtmlBase,DesignDetail,(long)model.member_id];
        PJDesignMainPageViewController *designMainPageViewController = [[PJDesignMainPageViewController alloc] initWithUrl:url];
        designMainPageViewController.isGradualNavBarColor = YES;
        designMainPageViewController.isShare = YES;
        designMainPageViewController.isShowBack = NO;
        designMainPageViewController.hidesBottomBarWhenPushed = YES;
        designMainPageViewController.webViewTitle = [NSString stringWithFormat:@"设计师 %@",model.design];
        designMainPageViewController.loadType = RoundProgress;
        designMainPageViewController.shareUrl = url;
        
        [MobClick event:MobClickDesignDetail];
        [self showViewController:designMainPageViewController sender:self];
    }
}

- (void)showLoading:(BOOL)show{
    
}

/**
 * 显示加载失败页面
 */
- (void)showError:(BOOL)show{
    
}

- (NSString *)requestUrl{
    return @"/api/gallery/new_cases";
}

- (NSMutableDictionary *)params{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.page) forKey:@"page"];
    [params setObject:@(self.limit) forKey:@"limit"];
    return params;
}

- (PJDesignDataSource *)designDataSource{
    if(!_designDataSource){
        _designDataSource = [[PJDesignDataSource alloc] init];
        _designDataSource.controller = self;
    }
    return _designDataSource;
}

- (UITableViewStyle)tableViewStyle{
    return UITableViewStyleGrouped;
}

- (PJDesignPhotoBrowserManager *)designPhotoBrowserManager{
    if(!_designPhotoBrowserManager){
        _designPhotoBrowserManager = [[PJDesignPhotoBrowserManager alloc] init];
    }
    return _designPhotoBrowserManager;
}

- (UIView *)headerView{
    if(!_headerView){
        CGFloat scale = UIScale;
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 260 * scale)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        CXCycleScroll *banner = [[CXCycleScroll alloc] initWithFrame:CGRectMake(0, 0, SCREENWITH, 200 * scale)];
        banner.onColor = [UIColor whiteColor];
        banner.offColor = [[UIColor alloc] initWithWhite:1 alpha:0.3];
        banner.indicatorDiameter = 7;
        banner.indicatorSpace = 7;
        banner.placeholderImage = [UIImage imageNamed:@"default_Rectangle_Small"];
        [banner create];
        banner.delegate = self;
        self.banner = banner;
        [self.banner setBannerArray:self.bannerArr];
        [_headerView addSubview:banner];
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeLeftBg"]];
        leftImageView.frame = CGRectMake(0, CGRectGetMaxY(banner.frame), 85 * scale, 35 * scale);
        [_headerView addSubview:leftImageView];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeRightBg"]];
        rightImageView.frame = CGRectMake(_headerView.width - 85 * scale, leftImageView.origin.y, 85 * scale, 35 * scale);
        [_headerView addSubview:rightImageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"精品推荐";
        label.font = [UIFont systemFontOfSizeAndSetStyle:18.0];
        label.textColor = RGBCOLOR(51, 51, 51);
        [label sizeToFit];
        label.frame = CGRectMake((_headerView.width - label.width) / 2.0, CGRectGetMaxY(banner.frame) + (60 * scale - label.height) / 2.0, label.width, label.height);
        [_headerView addSubview:label];
        
//        UIView *driver = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.height - 10 * scale, _headerView.width, 10 * scale)];
//        driver.backgroundColor = RGBCOLOR(246, 246, 246);
//        [_headerView addSubview:driver];
    }
    return _headerView;
}

- (UIBlurEffect *)beffect{
    if(!_beffect){
        _beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    return _beffect;
}

- (NSMutableArray *)bannerArr{
    if(!_bannerArr){
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (CGRect)tableViewFrame{
    return CGRectMake(0, -64, self.view.width, self.view.height + 64);
}

@end
