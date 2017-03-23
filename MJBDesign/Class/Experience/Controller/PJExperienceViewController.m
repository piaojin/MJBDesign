//
//  PJExperienceViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/8.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJExperienceViewController.h"
#import "PJHtmlConst.h"

@interface PJExperienceViewController ()
@property(nonatomic,strong)UIButton *back;
@end

@implementation PJExperienceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:MobClickExperience];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:MobClickExperience];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.title = @"体验家";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [self getTitleFont]};
    [self initBack];
}

- (void)initBack{
    self.back = [[UIButton alloc] init];
    [self.back setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [self.back sizeToFit];
    [self.back addTarget:self action:@selector(goBackPage) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.back];
    self.back.hidden = YES;
}

- (void)goBackPage{
    [super goBackPage];
}

- (void)pjWebViewDidFinishLoad:(UIWebView *)webView{
    if(![self.webView canGoBack]){
        self.back.hidden = YES;
    }else{
        self.back.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)urlStr{
    return UserShow;
}

- (void)showLoading:(BOOL)show{
    
}

@end
