//
//  PJTableViewController.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseModelViewController.h"
#import "MJBBaseTableViewDataSource.h"
#import "MJRefresh.h"
#import "MJBBaseTableViewCell.h"

@interface MJBTableViewController : MJBBaseModelViewController<UITableViewDelegate,MJBBaseTableViewCellDelegate>

@property(nonatomic, strong) id <MJBBaseTableViewDataSource> dataSource;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) PullLoadType pullLoadType;
//是否可以上拉刷新
@property(nonatomic, assign) BOOL loadMoreEnable;
@property(nonatomic, assign) BOOL loadRefreshEnable;
@property(nonatomic, assign) BOOL forbidLoadMore;
@property (nonatomic, strong)MJRefreshNormalHeader *freshHeader;
@property (nonatomic, strong)MJRefreshAutoNormalFooter *freshFooter;
//是否处理重用造成的数据重复显示问题
@property (assign, nonatomic)BOOL isClearRepeat;
/**
 *   是否从xib加载cell
 */
@property (assign, nonatomic)BOOL isLoadFromXIB;
/**
 *   cell的xib文件名
 */
@property (strong, nonatomic)NSString *XIBName;


- (UITableView *)tableView;

- (UITableViewStyle)tableViewStyle;

- (CGRect)tableViewFrame;

- (void)createDataSource;
/**
 *   禁用上拉刷新
 *
 */
- (void)setForbidLoadMore:(BOOL)forbidLoadMore;
/**
 *   禁用下拉刷新
 *
 */
- (void)setForbidRefresh:(BOOL)forbidRefresh;
/**
 *   直接调用自动下拉刷新
 */
- (void)autoPullDown;

/**
 *   更新了新数据
 */
- (void)refreshForNewData ;

/**
 *   在下拉刷新之前可以处理的事
 */
- (void)beforePullDownRefreshing;

/**
 *   在上拉刷新之前可以处理的事
 */
- (void)beforePullUpLoading;

/**
 *   下拉刷新回调
 */
- (void)beginPullDownRefreshing;

/**
 *   上拉刷新回调
 */
- (void)beginPullUpLoading;

- (void)setPullEndStatus;

- (void)setPullFailedStatus;

/**
 *   初始化：控制是否下拉刷新
 *
 */
- (BOOL)canPullDownRefreshed;

/**
 *   初始化：是否上拉更多
 *
 */
- (BOOL)canPullUpLoadMore;

/**
 *   控制是否下拉刷新
 *
 */
- (void)setLoadRefreshEnable:(BOOL)loadRefreshEnable;

/**
 *   每页item数少于limit处理方法
 */
- (void)handleWhenLessOnePage;

/**
 *   如果无数据则进行处理
 */
- (void)handleWhenNoneData;

/**
 *   cell 点击跳转方法
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

@end
