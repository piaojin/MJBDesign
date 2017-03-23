//
//  MJBBaseTableViewCell.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBBaseViewController.h"


@protocol MJBBaseTableViewCellDelegate <NSObject>

- (void)action:(id)sender withObject:(id)object;

@end

@interface MJBBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id model;
@property (weak, nonatomic)MJBBaseViewController *controller;
@property (weak, nonatomic)id<MJBBaseTableViewCellDelegate> delegate;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
//消除重用造成的数据重复显示
- (void)clearData;


@end
