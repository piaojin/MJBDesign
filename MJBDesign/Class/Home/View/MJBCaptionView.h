//
//  MJBCaptionView.h
//  MJBangProject
//
//  Created by xiao on 16/11/18.
//  Copyright © 2016年 X团. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWCaptionView.h"
#import "PJDesignDetailModel.h"

@interface MJBCaptionView : MWCaptionView
@property (copy, nonatomic) void (^captionViewBlock)();//免费设计
@property (copy, nonatomic) void (^detailBlock)();//更多
@property (copy, nonatomic) void (^panoramaBlock)(PicClass *model);//全景
- (id)initWithPhoto:(id<MWPhoto>)photo picClass:(PicClass *)model;
@end
