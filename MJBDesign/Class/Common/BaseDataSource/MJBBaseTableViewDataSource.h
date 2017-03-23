//
//  PJBaseTableViewDataSource.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MJBTableViewController;
@protocol MJBBaseTableViewDataSource <UITableViewDataSource>

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object;

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object;

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MJBBaseTableViewDataSource : NSObject <MJBBaseTableViewDataSource>

@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSMutableArray *sectionsItems;
@property (weak, nonatomic)MJBTableViewController *controller;


/**
 * 只有单组数据
 */
+ (MJBBaseTableViewDataSource *)dataSourceWithItems:(NSMutableArray *)items;

+ (MJBBaseTableViewDataSource *)dataSourceWithItems:(NSMutableArray *)items controller:(MJBTableViewController *)controller;

/**
 * 分组数据
 */
+ (MJBBaseTableViewDataSource *)dataSourceWithSectionsItems:(NSMutableArray *)items;

+ (MJBBaseTableViewDataSource *)dataSourceWithSectionsItems:(NSMutableArray *)items controller:(MJBTableViewController *)controller;

@end
