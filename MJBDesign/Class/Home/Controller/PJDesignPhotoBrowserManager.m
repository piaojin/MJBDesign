//
//  PJDesignPhotoBrowserViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/12.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJDesignPhotoBrowserManager.h"
#import "PJDesignDetailModel.h"
#import "MWPhotoBrowser.h"
#import "MJBCaptionView.h"
#import "PJPhotoBrowser.h"
#import "PJServiceViewController.h"
#import "PJHtmlConst.h"
#import "ShareManager.h"
#import "PJDesignMainPageViewController.h"

@interface PJDesignPhotoBrowserManager ()<MWPhotoBrowserDelegate>

@property (strong, nonatomic)PJPhotoBrowser *photoBrowser;
@property (strong, nonatomic)PJDesignDetailModel *model;
@property (strong, nonatomic)NSMutableArray *photosArr;
@property (strong, nonatomic)NSMutableDictionary *params;
/**
 *   设计师主页H5
 */
@property (copy, nonatomic)NSString *designUrl;

@end

@implementation PJDesignPhotoBrowserManager

- (instancetype)initWithMemberId:(NSInteger)member_id controller:(MJBBaseViewController *)controller{
    if(self = [super init]){
        self.member_id = member_id;
        self.controller = controller;
    }
    return self;
}

- (void)show{
    WeakSelf;
    _photoBrowser = [[PJPhotoBrowser alloc] initWithDelegate:self];
    _photoBrowser.displayActionButton = NO;
    //分享
    _photoBrowser.shareBlock = ^(){
        [ShareManager showShareWithTitle:DesignShareTitle descr:DesignShareContent shareUrl:weakSelf.designUrl shareIcon:[UIImage imageNamed:@"logo"] showView:PJKeyWindow completion:^(id result, NSError *error) {
            
        }];
        [MobClick event:MobClickDesignShare];
    };
    //收藏
//    _photoBrowser.collectBlock = ^(){
//        
//    };
    
    [weakSelf.photosArr removeAllObjects];
    [self.controller.navigationController pushViewController:_photoBrowser animated:YES];
    [MJBHTTPManager getNewCaseInfo:self.params success:^(id response) {
        if(response){
            PJDesignDetailModel *model = [PJDesignDetailModel mj_objectWithKeyValues:response];
            weakSelf.model = model;
            if([response isKindOfClass:[NSDictionary class]]){
                
                NSDictionary *dic = (NSDictionary *)response;
                NSDictionary *pic_class_data = [dic objectForKey:@"pic_class_data"];
                NSMutableArray *arr = [NSMutableArray array];
                
                for(id value in pic_class_data.allValues){
                    PicClass *picClass = [PicClass mj_objectWithKeyValues:value];
                    if(picClass){
                        [arr addObject:picClass];
                    }
                }
                
                weakSelf.model.pic_class_data.pic_class = [NSArray arrayWithArray:arr];
                
                for(PicClass *picClass in model.pic_class_data.pic_class){
                    NSString *imgUrl = picClass.pic_list.firstObject;
                    if(![NSString isBlankString:imgUrl]){
                        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:imgUrl]];
                        [weakSelf.photosArr addObject:photo];
                    }
                }
            }else{
                for(NSString *imgUrl in model.pic_data){
                    if(![NSString isBlankString:imgUrl]){
                        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:imgUrl]];
                        [weakSelf.photosArr addObject:photo];
                    }
                }
            }
            [weakSelf.photoBrowser reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.photosArr.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photosArr.count) {
        return [self.photosArr objectAtIndex:index];
    }
    return nil;
}

- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
    if (self.photosArr.count == 0)return nil;
    MWPhoto *photo = [self.photosArr objectAtIndex:index];
    PicClass *picClass = self.model.pic_class_data.pic_class[index];
    MJBCaptionView *captionView = [[MJBCaptionView alloc] initWithPhoto:photo picClass:picClass];
#pragma mark 申请设计
    WeakSelf;
    //申请设计
    captionView.captionViewBlock = ^() {
        PJServiceViewController *serviceViewController = [[PJServiceViewController alloc] init];
        serviceViewController.isRootViewController = NO;
        serviceViewController.isShare = YES;
//        serviceViewController.isShowBack  =YES;
        serviceViewController.shareTitle = ServiceShareTitle;
        serviceViewController.shareContent = ServiceShareContent;
        serviceViewController.shareUrl = Service;
        serviceViewController.shareIcon = [UIImage imageNamed:@"logo"];
        [weakSelf.controller.navigationController pushViewController:serviceViewController animated:YES];
        [MobClick event:MobClickFreeDesign];
    };
    //更多
    captionView.detailBlock = ^() {
        PJDesignMainPageViewController *designMainPageViewController = [[PJDesignMainPageViewController alloc] initWithUrl:weakSelf.designUrl];
        designMainPageViewController.isGradualNavBarColor = YES;
        designMainPageViewController.isShare = YES;
        designMainPageViewController.isShowBack = NO;
        designMainPageViewController.webViewTitle = weakSelf.model.info.package_name;
        designMainPageViewController.loadType = RoundProgress;
        designMainPageViewController.shareUrl = weakSelf.designUrl;
        designMainPageViewController.shareIcon = [UIImage imageNamed:@"logo"];
        [weakSelf.controller.navigationController pushViewController:designMainPageViewController animated:YES];
        [MobClick event:MobClickDesignDetail];
    };
    //全景
    captionView.panoramaBlock = ^(PicClass *model) {
        MJBBaseWebViewController *panoramaWebViewController = [[MJBBaseWebViewController alloc] initWithUrl:model.panorama_link];
        [weakSelf.controller.navigationController pushViewController:panoramaWebViewController animated:YES];
    };
    
    return captionView;
}

- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
    return @"";
}

- (NSMutableDictionary *)params{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.member_id) forKey:@"id"];
    return params;
}

- (NSMutableArray *)photosArr{
    if(!_photosArr){
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (NSString *)designUrl{
    return [NSString stringWithFormat:@"%@%@%ld.html",MJBHtmlBase,DesignDetail,(long)self.member_id];
}

@end
