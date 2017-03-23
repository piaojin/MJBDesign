//
//  PJDesignPhotoBrowserViewController.h
//  MJBDesign
//
//  Created by piaojin on 16/12/12.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseViewController.h"
@interface PJDesignPhotoBrowserManager : NSObject

@property (nonatomic, assign) NSInteger member_id;
@property (strong, nonatomic)MJBBaseViewController *controller;
- (instancetype)initWithMemberId:(NSInteger)member_id controller:(MJBBaseViewController *)controller;
- (void)show;

@end
