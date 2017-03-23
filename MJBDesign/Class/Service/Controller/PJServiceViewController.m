//
//  PJServiceViewController.m
//  MJBDesign
//
//  Created by piaojin on 16/12/8.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJServiceViewController.h"
#import "PJHtmlConst.h"

@interface PJServiceViewController ()
@property(nonatomic,strong)UIButton *back;
@end

@implementation PJServiceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:MobClickService];//("PageOne"为页面名称，可自定义)
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:MobClickService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务";
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [self getTitleFont]};
    if(self.isRootViewController){
        [self initBack];
    }
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
    return Service;
}

- (void)showLoading:(BOOL)show{
    
}

@end
