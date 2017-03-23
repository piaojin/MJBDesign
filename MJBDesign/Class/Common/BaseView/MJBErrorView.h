//
//  PJErrorView.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol MJBErrorViewDelegate <NSObject>

- (void)errorClick;

@end

@interface MJBErrorView : UIView

@property (weak, nonatomic)id<MJBErrorViewDelegate> delegate;
- (void)setErrorText:(NSString *)text;
- (instancetype)initErrorView:(CGRect)frame;

@end
