//
//  PJDesignPreviewViewController.h
//  MJBDesign
//
//  Created by piaojin on 16/12/13.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseViewController.h"
@class PJDesignModel;
@protocol PJDesignPreviewDelegate <NSObject>

- (void)PJDesignPreviewCancel;
- (void)PJDesignPreviewDetail:(PJDesignModel *)designModel;

@end
@interface PJDesignPreviewViewController : MJBBaseViewController

- (instancetype)initWithModel:(PJDesignModel *)designModel;
@property (copy, nonatomic) void (^cancelBlock)();//取消
@property (copy, nonatomic) void (^goBlock)(PJDesignModel *designModel);//详情
@property (weak, nonatomic)id<PJDesignPreviewDelegate>delegate;

@end
