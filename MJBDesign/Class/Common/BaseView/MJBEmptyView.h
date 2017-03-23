//
//  PJEmptyView.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJBEmptyViewDelegate <NSObject>

- (void)emptyClick;

@end

@interface MJBEmptyView : UIView

@property (weak, nonatomic)id<MJBEmptyViewDelegate> delegate;
- (void)setEmptyText:(NSString *)text;
- (instancetype)initEmptyView:(CGRect)frame;

@end
