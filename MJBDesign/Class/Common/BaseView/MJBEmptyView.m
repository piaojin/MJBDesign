//
//  PJEmptyView.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBEmptyView.h"

@interface MJBEmptyView ()

@property (strong, nonatomic)UILabel *label;

@end

@implementation MJBEmptyView

- (instancetype)initEmptyView:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initView {
    self.label.text = @"空空如也";
    [self.label sizeToFit];
    self.label.frame = CGRectMake((self.frame.size.width - self.label.frame.size.width) / 2.0, (self.frame.size.height - self.label.frame.size.height) / 2.0, self.label.frame.size.width, self.label.frame.size.height);
    [self addSubview:self.label];
}

- (void)emptyClick:(UITapGestureRecognizer *)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(emptyClick)]){
        [self.delegate emptyClick];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label sizeToFit];
    self.label.frame = CGRectMake((self.frame.size.width - self.label.frame.size.width) / 2.0, (self.frame.size.height - self.label.frame.size.height) / 2.0, self.label.frame.size.width, self.label.frame.size.height);
}

- (void)setEmptyText:(NSString *)text{
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
