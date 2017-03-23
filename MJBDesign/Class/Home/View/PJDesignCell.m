//
//  PJDesignCell.m
//  MJBDesign
//
//  Created by piaojin on 16/12/9.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJDesignCell.h"
#import "PJDesignModel.h"

@interface PJDesignCell ()

@property (strong, nonatomic)UIImageView *designImageView;
@property (strong, nonatomic)UILabel *authorLabel;
@property (strong, nonatomic)UILabel *styleNameLabel;
@property (strong, nonatomic)UILabel *appointmentLabel;
@property (strong, nonatomic)UIView *bottomView;
@property (strong, nonatomic)UIButton *previewButton;
@property (strong, nonatomic)PJDesignModel *designModel;
@property (assign, nonatomic)BOOL isRegister3DTouch;

@end

@implementation PJDesignCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)model{
    return 336 * UIScale;
}

- (void)initView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = RGBCOLOR(246, 246, 246);
    [self.contentView addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@15);
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.equalTo(self.contentView);
    }];
    
    self.designImageView = [[UIImageView alloc] init];
    self.designImageView.userInteractionEnabled = YES;
    [self.designImageView setContentMode:(UIViewContentModeScaleToFill)];
    [self.contentView addSubview:self.designImageView];
    
    [self.designImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_width).dividedBy(1.3);
        make.top.equalTo(self.bottomView.mas_bottom).offset(0);
        make.left.equalTo(self.contentView).offset(0);
    }];
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font  = [UIFont systemFontOfSize:14.0];
    self.authorLabel.textColor = RGBCOLOR(51, 51, 51);
    [self.contentView addSubview:self.authorLabel];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.designImageView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(@16);
    }];
    
    self.styleNameLabel = [[UILabel alloc] init];
    self.styleNameLabel.textColor = RGBCOLOR(153, 153, 153);
    self.styleNameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.styleNameLabel];
    
    [self.styleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(12);
        make.left.equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(@16);
    }];
    
    self.appointmentLabel = [[UILabel alloc] init];
    [self.appointmentLabel setTextAlignment:(NSTextAlignmentRight)];
    self.appointmentLabel.textColor = RGBCOLOR(204, 204, 204);
    self.appointmentLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.appointmentLabel];
    
    [self.appointmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerY.equalTo(self.authorLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(@13);
    }];
    
    self.previewButton = [[UIButton alloc] init];
    [self.designImageView addSubview:self.previewButton];
    self.previewButton.backgroundColor = [UIColor blackColor];
    self.previewButton.alpha = 0.5;
    
//    [self.previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.designImageView).offset(15);
//        make.right.equalTo(self.designImageView).offset(-15);
//        make.width.height.mas_equalTo(30);
//    }];
}

- (void)setModel:(id)model{
    self.designModel = (PJDesignModel *)model;
    if(![NSString isBlankString:self.designModel.pic_url]){
        [self.designImageView sd_setImageWithURL:[[NSURL alloc] initWithString:self.designModel.pic_url] placeholderImage:[UIImage imageNamed:@"default_Rectangle_Small"]];
    }else{
        self.designImageView.image = [UIImage imageNamed:@"default_Rectangle_Small"];
    }
    
    NSString *str;
    if([NSString isBlankString:self.designModel.name]){
        str = @"设计作品";
    }else{
        str = self.designModel.name;
    }
    self.authorLabel.text = [NSString stringWithFormat:@"%@ %@",self.designModel.design,str];
    
    self.appointmentLabel.text = [NSString stringWithFormat:@"已有%ld次预约",(long)self.designModel.reserve_num];
    
    NSString *styleStr = self.designModel.style;
    if(![NSString isBlankString:self.designModel.house_type]){
        styleStr = [NSString stringWithFormat:@"%@，%@",styleStr,self.designModel.house_type];
    }
    
    if(![NSString isBlankString:self.designModel.acreage_use]){
        styleStr = [NSString stringWithFormat:@"%@，%@㎡",styleStr,self.designModel.acreage_use];
    }
    
    self.styleNameLabel.text = styleStr;
    
    [self.previewButton setImage:[UIImage imageNamed:@"preview"] forState:(UIControlStateNormal)];
    [self.previewButton addTarget:self action:@selector(previewClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self register3DTouch];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.previewButton.frame = CGRectMake(self.designImageView.width - 30 - 15, 15, 30, 30);
    self.previewButton.layer.cornerRadius = self.previewButton.height / 2.0;
    self.previewButton.layer.masksToBounds = YES;
}

#pragma 3D Touch不可重复注册，否则会有意想不到的错误
- (void)register3DTouch{
    if([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]){
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                    NSLog(@"3D Touch 可用!");
            if(!_isRegister3DTouch){
                //给cell注册3DTouch的peek（预览）和pop功能
                [self.controller registerForPreviewingWithDelegate:self.controller sourceView:self];
                _isRegister3DTouch = YES;
            }
        } else {
                    NSLog(@"3D Touch 无效");
        }
    }else{
        NSLog(@"3D Touch 无效");
    }
}

- (void)previewClick{
    if([self.delegate respondsToSelector:@selector(action:withObject:)]){
        [self.delegate action:self withObject:@{@"ActionType":@"Preview",@"Model":self.designModel}];
    }
}

@end
