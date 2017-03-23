//
//  PreviewView.h
//  MJBDesign
//
//  Created by piaojin on 16/12/13.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PJDesignModel;
@protocol PreviewDelegate <NSObject>

- (void)previewCancel;
- (void)previewDetail:(PJDesignModel *)designModel;

@end
@interface PreviewView : UIView

- (instancetype)initWithModel:(PJDesignModel *)designModel;
@property (strong, nonatomic)PJDesignModel *designModel;
@property (weak, nonatomic)id<PreviewDelegate>delegate;
/**
 *   是否隐藏两个按钮
 */
@property (assign, nonatomic)BOOL isHideActionButton;;

@end
