//
//  PreviewView.m
//  MJBDesign
//
//  Created by piaojin on 16/12/13.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PreviewView.h"
#import "PJDesignModel.h"

@interface PreviewView ()

@property (strong, nonatomic) UIImageView *designImageView;
@property (strong, nonatomic) UILabel *designName;
@property (strong, nonatomic) UILabel *style;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *cancel;
@property (strong, nonatomic) UIButton *goButton;

@end

@implementation PreviewView
/**
 *   移除子控件的约束和子控件本身,否则会包约束冲突警告
 */
- (void)reMoveSubViewsAndConstraints{
    for(UIView *view in self.subviews){
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [UIView animateWithDuration:0.3 animations:^{
            view.hidden = YES;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

- (instancetype)initWithModel:(PJDesignModel *)designModel{
    if(self = [super init]){
        self.designModel = designModel;
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.designImageView = [[UIImageView alloc] init];
    [self addSubview:self.designImageView];
    
    [self.designImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(self.mas_width).dividedBy(2.1);
    }];
    
    self.designName = [[UILabel alloc] init];
    self.designName.font = [UIFont systemFontOfSize:23.0];
    self.designName.textColor = RGBCOLOR(51, 51, 51);
    [self.designName setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.designName];
    [self.designName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.designImageView.mas_bottom).offset(20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
    self.style = [[UILabel alloc] init];
    self.style.font = [UIFont systemFontOfSize:14.0];
    self.style.textColor = RGBCOLOR(153, 153, 153);
    [self.style setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.style];
    [self.style mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.designName.mas_bottom).offset(20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
    self.avatar = [[UIImageView alloc] init];
    [self addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.style.mas_bottom).offset(25);
        make.width.height.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(self.style.mas_centerX);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.font = [UIFont systemFontOfSize:16.0];
    self.name.textColor = RGBCOLOR(51, 51, 51);
    [self.name setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_bottom).offset(15);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
    self.cancel = [[UIButton alloc] init];
    [self.cancel setImage:[UIImage imageNamed:@"cancel"] forState:(UIControlStateNormal)];
    self.cancel.alpha = 0.3;
    [self addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(85);
        make.bottom.equalTo(self).offset(-30);
        make.width.height.mas_equalTo(CGSizeMake(41, 41));
    }];
    
    self.goButton = [[UIButton alloc] init];
    [self.goButton setImage:[UIImage imageNamed:@"go"] forState:(UIControlStateNormal)];
    self.goButton.alpha = 0.3;
    [self addSubview:self.goButton];
    [self.goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-85);
        make.bottom.equalTo(self).offset(-30);
        make.width.height.mas_equalTo(CGSizeMake(41, 41));
    }];
    
    self.cancel.userInteractionEnabled = YES;
    [self.cancel addTarget:self action:@selector(cancelClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.goButton addTarget:self action:@selector(goClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)initData {
    [self.designImageView sd_setImageWithURL:[NSURL URLWithString:self.designModel.pic_url] placeholderImage:[UIImage imageNamed:@"default_Rectangle_Small"]];
    
    NSString *str = self.designModel.name;
    /**
     *   如果作品名为空则用风格作为显示内容
     */
    if([NSString isBlankString:str]){
        str = self.designModel.style;
    }
    self.designName.text = str;
    
    self.style.text = [NSString stringWithFormat:@"%@,%@,%@,%@㎡",self.designModel.city,self.designModel.style,self.designModel.house_type,self.designModel.acreage_use];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.designModel.avatar] placeholderImage:[UIImage imageNamed:@"default_Square"]];
    
    self.name.text = self.designModel.design;
    
    self.avatar.layer.cornerRadius = self.avatar.height / 2.0;
    self.avatar.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initData];
}

- (void)cancelClick{
    NSLog(@"cancelClick");
    if([_delegate respondsToSelector:@selector(previewCancel)]){
        [self reMoveSubViewsAndConstraints];
        [_delegate previewCancel];
    }
}

- (void)goClick{
    if([_delegate respondsToSelector:@selector(previewDetail:)]){
        [_delegate previewDetail:self.designModel];
    }
}

- (void)setIsHideActionButton:(BOOL)isHideActionButton{
    _cancel.hidden = isHideActionButton;
    _goButton.hidden = isHideActionButton;
}

@end
