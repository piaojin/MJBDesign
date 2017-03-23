//
//  PJMoreViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/8.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJMoreViewController.h"
#import "PJMoreCellTableViewCell.h"
#import "PJSetterViewController.h"
#import "PJExperienceHouseViewController.h"

#define Setting 1
#define Experience 0

@implementation PJMoreDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object{
    if(object){
       return [PJMoreCellTableViewCell class];
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
    if(self.sectionsItems.count > 0){
        if(indexPath.section < self.sectionsItems.count){
            return self.sectionsItems[indexPath.section];
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

@end

@interface PJMoreViewController ()

@end

@implementation PJMoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:MobClickMore];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:MobClickMore];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    [self setForbidLoadMore:YES];
    [self setForbidRefresh:YES];
    self.isLoadFromXIB = YES;
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.tableView.backgroundColor = RGBCOLOR(246, 246, 246);
    self.tableView.sectionFooterHeight = 0;
    [self createDataSource];
}

- (void)createDataSource{
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"experienceHouse",@"icon",@"家居体验馆",@"title", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"setting",@"icon",@"设置",@"title", nil];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:dic1,dic2, nil];
    [self addItems:arr];
    self.dataSource = [PJMoreDataSource dataSourceWithSectionsItems:self.items controller:self];
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
    if(indexPath.section == Setting){
        PJSetterViewController *setterViewController = [[PJSetterViewController alloc] init];
        setterViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setterViewController animated:YES];
        [MobClick event:MobClickSetting];
    }else{
        PJExperienceHouseViewController *experienceViewController = [[PJExperienceHouseViewController alloc] init];
        experienceViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:experienceViewController animated:YES];
        [MobClick event:MobClickExperienceHouse];
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
