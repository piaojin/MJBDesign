//
//  PJSetterCell.m
//  MJBDesign
//
//  Created by piaojin on 16/12/9.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJSetterCell.h"
#import "NSString+PJ.h"
#import "SetterModel.h"

@interface PJSetterCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (strong, nonatomic)UIImageView *rightImageView;
@property(nonatomic,strong)SetterModel *setterModel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation PJSetterCell

- (void)initView{
    self.rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]];
    [self.contentView addSubview:self.rightImageView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(14);
    }];
    self.rightImageView.hidden = YES;
}

- (void)setModel:(id)model{
    _setterModel = (SetterModel *)model;
    self.value.text = _setterModel.value;
    self.title.text = _setterModel.title;
    if([NSString isBlankString:_setterModel.value] && !_setterModel.isCache){
        self.rightImageView.hidden = NO;
    }else{
        self.rightImageView.hidden = YES;
    }
    
    if(_setterModel.isCache && [NSString isBlankString:_setterModel.value]){
        [self.activityIndicatorView startAnimating];
        self.value.hidden = YES;
    }else{
        [self.activityIndicatorView stopAnimating];
        self.value.hidden = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if(_setterModel.isCache){
        UIView *driver = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 0.5)];
        driver.backgroundColor  = RGBCOLOR(228, 228, 228);
        [self.contentView addSubview:driver];
    }
}

- (void)startAnimating{
    [self.activityIndicatorView startAnimating];
    self.value.hidden = YES;
}

- (void)stopAnimating{
    [self.activityIndicatorView stopAnimating];
    self.value.hidden = NO;
}

@end
