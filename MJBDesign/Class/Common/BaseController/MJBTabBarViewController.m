//
//  DenseTabBarViewController.m
//  XtuanMoive2.0
//
//  Created by mark on 14-7-22.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "MJBTabBarViewController.h"
#import "MJBBaseNavVC.h"
#import "PJDesignViewController.h"
#import "PJServiceViewController.h"
#import "PJExperienceViewController.h"
#import "PJMoreViewController.h"
#import "PJHtmlConst.h"

@interface MJBTabBarViewController ()

@property (strong, nonatomic)NSDictionary *tabTitleAttrNormal;
@property (strong, nonatomic)NSDictionary *tabTitleAttrHighlighted;

@end

@implementation MJBTabBarViewController

- (NSDictionary *)tabTitleAttrNormal{
    if(!_tabTitleAttrNormal){
        _tabTitleAttrNormal = @{NSForegroundColorAttributeName : RGBCOLOR(102, 102, 102)};
    }
    return _tabTitleAttrNormal;
}

- (NSDictionary *)tabTitleAttrHighlighted{
    if(!_tabTitleAttrHighlighted){
        _tabTitleAttrHighlighted = @{NSForegroundColorAttributeName : RGBCOLOR(129, 0, 128)};
    }
    return _tabTitleAttrHighlighted;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
//    [UITabBar appearance].translucent = NO;
    [self addSubViewControllers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 添加TabBarItem

- (void)addSubViewControllers{
    
    PJDesignViewController *designViewController = [[PJDesignViewController alloc] init];
    UITabBarItem *designViewControllerItem = [[UITabBarItem alloc]initWithTitle:@"图库" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"homePressed"]];
    designViewController.tabBarItem = designViewControllerItem;
    designViewController.isRootViewController = YES;
    designViewController.isGradualNavBarColor = YES;
    [designViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -2)];
    [designViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrNormal forState:(UIControlStateNormal)];
    [designViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrHighlighted forState:(UIControlStateSelected)];
    MJBBaseNavVC *designNav = [[MJBBaseNavVC alloc] initWithRootViewController:designViewController];
    
    PJExperienceViewController *experienceViewController = [[PJExperienceViewController alloc] init];
    UITabBarItem *experienceViewControllerItem = [[UITabBarItem alloc]initWithTitle:@"体验家" image:[UIImage imageNamed:@"experience"] selectedImage:[UIImage imageNamed:@"experiencePressed"]];
    experienceViewController.tabBarItem = experienceViewControllerItem;
    experienceViewController.isRootViewController = YES;
    experienceViewController.isShare = YES;
    experienceViewController.loadType = RoundProgress;
    [experienceViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrNormal forState:(UIControlStateNormal)];
    [experienceViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrHighlighted forState:(UIControlStateSelected)];
     [experienceViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -2)];
    /**
     *   分享相关设置
     *
     */
    experienceViewController.shareTitle = ExperienceShareTitle;
    experienceViewController.shareContent = ExperienceShareContent;
    experienceViewController.shareUrl = UserShow;
    experienceViewController.shareIcon = [UIImage imageNamed:@"logo"];
     MJBBaseNavVC *experienceNav = [[MJBBaseNavVC alloc] initWithRootViewController:experienceViewController];
    
    PJServiceViewController *serviceViewController = [[PJServiceViewController alloc] init];
    UITabBarItem *serviceViewControllerItem = [[UITabBarItem alloc]initWithTitle:@"服务" image:[UIImage imageNamed:@"service"] selectedImage:[UIImage imageNamed:@"servicePressed"]];
    serviceViewController.tabBarItem = serviceViewControllerItem;
    serviceViewController.isRootViewController = YES;
    serviceViewController.isShare = YES;
    serviceViewController.loadType = RoundProgress;
    [serviceViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -2)];
    [serviceViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrNormal forState:(UIControlStateNormal)];
    [serviceViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrHighlighted forState:(UIControlStateSelected)];
    /**
     *   分享相关设置
     *
     */
    serviceViewController.shareTitle = ServiceShareTitle;
    serviceViewController.shareContent = ServiceShareContent;
    serviceViewController.shareUrl = Service;
    serviceViewController.shareIcon = [UIImage imageNamed:@"logo"];
    MJBBaseNavVC *serviceNav = [[MJBBaseNavVC alloc] initWithRootViewController:serviceViewController];
    
    PJMoreViewController *moreViewController = [[PJMoreViewController alloc] init];
    UITabBarItem *moreViewControllerItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"more"] selectedImage:[UIImage imageNamed:@"morePressed"]];
    moreViewController.tabBarItem = moreViewControllerItem;
    moreViewController.isRootViewController = YES;
    [moreViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -2)];
    [moreViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrNormal forState:(UIControlStateNormal)];
    [moreViewController.tabBarItem setTitleTextAttributes:self.tabTitleAttrHighlighted forState:(UIControlStateSelected)];
    MJBBaseNavVC *moreNav = [[MJBBaseNavVC alloc] initWithRootViewController:moreViewController];
    
    self.viewControllers = @[designNav,experienceNav,serviceNav,moreNav];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
