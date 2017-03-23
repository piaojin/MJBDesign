//
//  PJDesignPreviewViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/13.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJDesignPreviewViewController.h"
#import "PJDesignModel.h"
#import "PreviewView.h"

@interface PJDesignPreviewViewController ()

@property (strong, nonatomic) UIImageView *designImageView;
@property (strong, nonatomic) UILabel *designName;
@property (strong, nonatomic) UILabel *style;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *cancel;
@property (strong, nonatomic) UIButton *goButton;
@property (strong, nonatomic)PJDesignModel *designModel;


@end

@implementation PJDesignPreviewViewController

- (instancetype)initWithModel:(PJDesignModel *)designModel{
    if(self = [super init]){
        self.designModel = designModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initView];
//    [self initData];
    PreviewView *previewView = [[PreviewView alloc] initWithModel:self.designModel];
    previewView.frame = self.view.bounds;
    previewView.isHideActionButton = YES;
    [self.view addSubview:previewView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.designImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.designImageView];
    
    [self.designImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@140);
    }];
    
    self.designName = [[UILabel alloc] init];
    self.designName.font = [UIFont systemFontOfSize:23.0];
    self.designName.textColor = RGBCOLOR(51, 51, 51);
    [self.designName setTextAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:self.designName];
    [self.designName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.designImageView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    self.style = [[UILabel alloc] init];
    self.style.font = [UIFont systemFontOfSize:14.0];
    self.style.textColor = RGBCOLOR(153, 153, 153);
    [self.style setTextAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:self.style];
    [self.style mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.designName.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    self.avatar = [[UIImageView alloc] init];
    [self.view addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.style.mas_bottom).offset(25);
        make.width.height.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(self.style.mas_centerX);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.font = [UIFont systemFontOfSize:16.0];
    self.name.textColor = RGBCOLOR(51, 51, 51);
    [self.name setTextAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    self.cancel = [[UIButton alloc] init];
    [self.cancel setImage:[UIImage imageNamed:@"cancel"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(84);
        make.bottom.equalTo(self.view).offset(-30);
        make.width.height.mas_equalTo(CGSizeMake(41, 41));
    }];
    
    self.goButton = [[UIButton alloc] init];
    [self.goButton setImage:[UIImage imageNamed:@"go"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.goButton];
    [self.goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-84);
        make.bottom.equalTo(self.view).offset(-30);
        make.width.height.mas_equalTo(CGSizeMake(41, 41));
    }];
    
    self.cancel.userInteractionEnabled = YES;
    [self.cancel addTarget:self action:@selector(cancelClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.goButton addTarget:self action:@selector(goClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)initData {
    [self.designImageView sd_setImageWithURL:[NSURL URLWithString:self.designModel.pic_url] placeholderImage:[UIImage imageNamed:@"default_Rectangle_Small"]];
    
    self.designName.text = self.designModel.name;
    
    self.style.text = [NSString stringWithFormat:@"%@,%@,%@,%@",self.designModel.city,self.designModel.style,self.designModel.house_type,self.designModel.acreage_use];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.designModel.avatar] placeholderImage:[UIImage imageNamed:@"default_Square"]];
    
    self.name.text = self.designModel.design;
    
    self.avatar.layer.cornerRadius = self.avatar.height / 2.0;
    self.avatar.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelClick{
    NSLog(@"cancelClick");
    if(_cancelBlock){
        _cancelBlock();
    }
    if([_delegate respondsToSelector:@selector(PJDesignPreviewCancel)]){
        [_delegate PJDesignPreviewCancel];
    }
}

- (void)goClick{
    if(_goBlock){
        _goBlock(self.designModel);
    }
    if([_delegate respondsToSelector:@selector(PJDesignPreviewDetail:)]){
        [_delegate PJDesignPreviewDetail:self.designModel];
    }
}

@end
