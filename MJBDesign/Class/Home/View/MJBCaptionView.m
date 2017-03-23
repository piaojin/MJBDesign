//
//  MJBCaptionView.m
//  MJBangProject
//
//  Created by xiao on 16/11/18.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "MJBCaptionView.h"

@interface MJBCaptionView ()

@property (strong, nonatomic)PicClass *model;

@end

@implementation MJBCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo picClass:(PicClass *)model{
    if(self = [super initWithPhoto:photo]){
        self.model = model;
    }
    return self;
}

- (void)setupCaption {
    self.userInteractionEnabled = YES;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWITH, 50)];
    
    CGFloat btnW = 122;
    UIButton *visitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWITH / 2 - btnW / 2, 10, btnW, 31)];
    visitBtn.backgroundColor = [UIColor clearColor];
    [visitBtn setTitle:@"申请免费设计" forState:UIControlStateNormal];
    [visitBtn addTarget:self action:@selector(visitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    visitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [visitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    visitBtn.layer.cornerRadius = 5;
    visitBtn.layer.masksToBounds = YES;
    visitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    visitBtn.layer.borderWidth = 1.0;
    [visitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [bgView addSubview:visitBtn];
    
    CGFloat W = 20;
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(15, (bgView.height - W) / 2.0, W, W)];
    [detailButton setBackgroundImage:[UIImage imageNamed:@"detailWhite"] forState:UIControlStateNormal];
    detailButton.layer.cornerRadius = detailButton.height / 2.0;
    detailButton.backgroundColor = [UIColor clearColor];
    [detailButton addTarget:self action:@selector(detailClick) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:detailButton];
    
    UIButton *more = [[UIButton alloc] init];
    [more setTitle:@"更多" forState:(UIControlStateNormal)];
    more.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [more setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [more sizeToFit];
    more.frame = CGRectMake(CGRectGetMaxX(detailButton.frame) + 6, (bgView.height - more.height) / 2.0, more.width, more.height);
    [bgView addSubview:more];
    
    [more addTarget:self action:@selector(detailClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    if(![NSString isBlankString:self.model.panorama_link]){
        UILabel *panoramaLabel = [[UILabel alloc] init];
        panoramaLabel.text = @"全景";
        panoramaLabel.font = [UIFont systemFontOfSize:15.0];
        panoramaLabel.textColor = [UIColor whiteColor];
        [panoramaLabel sizeToFit];
        panoramaLabel.frame = CGRectMake(bgView.width - panoramaLabel.width - 15, (bgView.height - panoramaLabel.height) / 2.0, panoramaLabel.width, panoramaLabel.height);
        [bgView addSubview:panoramaLabel];
        
        UIButton *panoramaButton = [[UIButton alloc] initWithFrame:CGRectMake(panoramaLabel.origin.x - 6 - W, (bgView.height - W) / 2.0, W, W)];
        [panoramaButton setBackgroundImage:[UIImage imageNamed:@"3DWhite"] forState:UIControlStateNormal];
        panoramaButton.layer.cornerRadius = panoramaButton.height / 2.0;
        panoramaButton.backgroundColor = [UIColor clearColor];
        [panoramaButton addTarget:self action:@selector(panoramaClick) forControlEvents:(UIControlEventTouchUpInside)];
        [bgView addSubview:panoramaButton];
        
        UIGestureRecognizer *panoramaTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(panoramaClick)];
        [panoramaLabel addGestureRecognizer:panoramaTap];
    }
    
    [self addSubview:bgView];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(SCREENWITH, 50);
}

- (void)visitBtnClick {
    if (_captionViewBlock) {
        _captionViewBlock();
    }
}

- (void)detailClick{
    if(_detailBlock){
        _detailBlock();
    }
}

- (void)panoramaClick{
    if(_panoramaBlock){
        _panoramaBlock(_model);
    }
}

@end
