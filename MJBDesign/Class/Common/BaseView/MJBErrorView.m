//
//  PJErrorView.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBErrorView.h"

@interface MJBErrorView ()

@property (strong, nonatomic)UILabel *label;

@end

@implementation MJBErrorView

- (instancetype)initErrorView:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(errorClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initView {
    [self.label setTextAlignment:(NSTextAlignmentCenter)];
    self.label.text = @"加载失败,点击重新加载";
    self.label.textColor = [UIColor blackColor];
    [self addSubview:self.label];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

- (void)errorClick:(UITapGestureRecognizer *)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(errorClick)]){
        [self.delegate errorClick];
    }
}

- (void)setErrorText:(NSString *)text{
    self.label.text = text;
    [self.label sizeToFit];
    self.label.frame = CGRectMake((self.frame.size.width - self.label.frame.size.width) / 2.0, (self.frame.size.height - self.label.frame.size.height) / 2.0, self.label.frame.size.width, self.label.frame.size.height);
    [self addSubview:self.label];
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc] init];
    }
    return _label;
}

@end
