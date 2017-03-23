//
//  PJPhotoBrowser.m
//  MJBDesign
//
//  Created by piaojin on 16/12/13.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJPhotoBrowser.h"
#import "UIColor+PJ.h"
#import "UIImage+PJ.h"

@interface PJPhotoBrowser ()

@end

@implementation PJPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alwaysShowControls = YES;
    [self initView];
}

- (void)initView {
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"backWhite"] forState:(UIControlStateNormal)];
    backButton.backgroundColor = [UIColor blackColor];
    backButton.alpha = 0.6;
    backButton.frame = CGRectMake(10, 10, 30, 30);
    backButton.layer.cornerRadius = backButton.height / 2.0;
    backButton.layer.masksToBounds = YES;
    [backButton addTarget:self action:@selector(backView) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIView *navBarRightBgView = [[UIView alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.width - 10, 10, 65, 30)];
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"shareWhite"] forState:(UIControlStateNormal)];
    shareButton.backgroundColor = [UIColor blackColor];
    shareButton.alpha = 0.6;
    shareButton.frame = CGRectMake(navBarRightBgView.width - 30, 0, 30, 30);
    shareButton.layer.cornerRadius = shareButton.height / 2.0;
    shareButton.layer.masksToBounds = YES;
    [shareButton addTarget:self action:@selector(shareClick) forControlEvents:(UIControlEventTouchUpInside)];
    [navBarRightBgView addSubview:shareButton];
    
//    UIButton *collectButton = [[UIButton alloc] init];
//    [collectButton setImage:[UIImage imageNamed:@"collectWhite"] forState:(UIControlStateNormal)];
//    collectButton.backgroundColor = [UIColor blackColor];
//    collectButton.alpha = 0.3;
//    collectButton.frame = CGRectMake(navBarRightBgView.width - 30, 0, 30, 30);
//    collectButton.layer.cornerRadius = collectButton.height / 2.0;
//    collectButton.layer.masksToBounds = YES;
//    [collectButton addTarget:self action:@selector(colloectClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [navBarRightBgView addSubview:collectButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navBarRightBgView];
}

- (void)backView{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma 按钮点击事件
- (void)shareClick{
    if(_shareBlock){
        _shareBlock();
    }
}

- (void)colloectClick{
    if(_collectBlock){
        _collectBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

#pragma mark - Appearance

- (void)viewWillAppear:(BOOL)animated {
    // Super
    [super viewWillAppear:animated];
    UIImageView *navBarImageView = self.navigationController.navigationBar.subviews.firstObject;
    navBarImageView.alpha = 0;
    UIColor *color = [[UIColor alloc] initWithWhite:0 alpha:0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : color};
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    // Super
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
