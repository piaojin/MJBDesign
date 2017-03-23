//
//  ShareManager.m
//  mjbang_work
//
//  Created by piaojin on 16/10/19.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "ShareManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "SVProgressHUD.h"

@interface ShareManager ()<ShareViewDelegate>

@property (strong, nonatomic)ShareView *shareView;
@property (strong, nonatomic)UMShareWebpageObject *shareObject;
@property (strong, nonatomic)NSString *MobClickSocialType;

/**
 *   防止多次显示面板
 */
@property (assign, nonatomic)BOOL isShow;

@end

@implementation ShareManager

+ (ShareManager *)shareManager{
    static ShareManager *shareManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareManagerInstance = [[self alloc] init];
    });
    return shareManagerInstance;
}

/**
 *   显示分享面板
 *
 *   @param title           分享标题
 *   @param descr           分享内容描述
 *   @param shareUrl        分享的链接地址
 *   @param shareIcon       分享的ICON
 *   @param showView        要显示在哪个视图上，默认根视图
 *   @param shareButtonType 分享的按钮类型（有标题或没有标题）
 *   @param completion      分享完成的回调
 */
+ (void)showShareWithTitle:(NSString *)title descr:(NSString *)descr shareUrl:(NSString *)shareUrl shareIcon:(id)shareIcon showView:(UIView *)showView completion:(ShareCompletionHandler)completion{
    if(![self shareManager].isShow){
        [self shareManager].shareCompletionHandler = completion;
        //创建网页内容对象
        UMShareWebpageObject *tempShareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:shareIcon];

        //设置网页地址
        tempShareObject.webpageUrl =shareUrl;
        [self shareManager].shareObject = tempShareObject;
        if(showView){
            [showView addSubview:[self shareManager].shareView];
        }else{
            [[UIApplication sharedApplication].keyWindow addSubview:[self shareManager].shareView];
        }
        [self shareManager].isShow = YES;
    }
}

+ (void)showShare:(NSString *)title descr:(NSString *)descr shareUrl:(NSString *)shareUrl shareIcon:(id)shareIcon showView:(UIView *)showView completion:(ShareCompletionHandler)completion{
    [self showShareWithTitle:title descr:descr shareUrl:shareUrl shareIcon:nil showView:showView completion:completion];
    [self shareManager].shareObject.thumbImage = shareIcon;
}

/**
 *   关闭分享面板
 */
+ (void)closeSharePanel{
    [self shareManager].isShow = NO;
    [[self shareManager].shareView closeShareView];
    [[self shareManager].shareView removeFromSuperview];
    [[self shareManager] setShareView:nil];
}

- (void)closeShare{
    self.isShow = NO;
    [_shareView removeFromSuperview];
    [self setShareView:nil];
}

/**
 *   执行分享动作
 *
 */
- (void)doShare:(ShareType)shareType{
    
    NSString *mobClickType = [NSString stringWithFormat:@"%@_MobClickSocialType",self.MobClickSocialType];
    NSString *type;
    switch (shareType) {
        case WeiXin:
            [self shareTextToPlatformType:UMSocialPlatformType_WechatSession];
            type = [NSString stringWithFormat:@"%@%@",mobClickType,@"WxSession"];
            break;
            
        case WeiXinFriend:
            [self shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
            type = [NSString stringWithFormat:@"%@%@",mobClickType,@"WxTimeline"];
            break;
            
        case QQShare:
            [self shareTextToPlatformType:UMSocialPlatformType_QQ];
            type = [NSString stringWithFormat:@"%@%@",mobClickType,@"QQ"];
            break;
            
        case CopyUrl:
            [self copySuccess];
            type = [NSString stringWithFormat:@"%@%@",mobClickType,@"CopyUrl"];
            break;
            
        default:
            [self shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
    }
}

- (void)copySuccess{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.shareObject.webpageUrl;
    [SVProgressHUD showSuccessWithStatus:@"已经复制到剪切板上"];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"美家图库分享";
    messageObject.shareObject = self.shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        __block __weak typeof(self) tmpSelf = self;
        if (error) {
            switch (error.code) {
                case UMSocialPlatformErrorType_NotInstall:
                    //应用为安装
                    [SVProgressHUD showErrorWithStatus:@"未安装应用"];
                    break;
                case UMSocialPlatformErrorType_SourceError:
                    //第三方错误
                    [SVProgressHUD showErrorWithStatus:@"分享应用错误"];
                    break;
                case UMSocialPlatformErrorType_NotSupport:
                    //不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持）
                    [SVProgressHUD showErrorWithStatus:@"SDK版本不支持分享"];
                    break;
                case UMSocialPlatformErrorType_ShareDataTypeIllegal:
                    //分享内容不支持
                    [SVProgressHUD showErrorWithStatus:@"分享内容不支持"];
                    break;
                case UMSocialPlatformErrorType_ShareFailed:
                    //分享失败
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                    break;
                case UMSocialPlatformErrorType_ShareDataNil:
                    //分享内容为空
                    [SVProgressHUD showErrorWithStatus:@"分享内容为空"];
                    break;
                case UMSocialPlatformErrorType_Cancel:
                    //用户取消分享
                    [SVProgressHUD showErrorWithStatus:@"您已取消分享"];
                default:
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                    break;
            }
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
        
        /**
         *   分享结果回调
         */
        if(tmpSelf.shareCompletionHandler){
            tmpSelf.shareCompletionHandler(data,error);
        }
    }];
}

- (ShareView *)shareView{
    if(!_shareView){
        _shareView = [[ShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _shareView.delegate = self;
    }
    return _shareView;
}

/**
 *   设置蒙层frame
 */
+ (void)setCoverFrame:(CGRect)frame{
    [self shareManager].shareView.coverView.frame = frame;
}

/**
 *   设置分享面板背景视图frame
 */
+ (void)setSharePanelBgViewFrame:(CGRect)frame{
    [self shareManager].shareView.panelView.frame = frame;
}
/**
 *   设置分享面板frame
 */
+ (void)setSharePanelFrame:(CGRect)frame{
    [self shareManager].shareView.frame = frame;
}

@end


@interface ShareView ()<ShareViewClickDelegate>

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.coverView = [[UIView alloc] init];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.6;
    UITapGestureRecognizer *coverViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeShareView)];
    [_coverView addGestureRecognizer:coverViewTap];
    [self addSubview:_coverView];
    
    self.panelView = [[UIView alloc] init];
    _panelView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_panelView];
}

/**
 *   关闭分享面板
 */
- (void)closeShareView{
    
    WeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.panelView.alpha = 0;
        weakSelf.panelView.hidden = YES;
        [weakSelf.panelView removeFromSuperview];
        [weakSelf.coverView removeFromSuperview];
    }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(closeShare)]){
        [self.delegate closeShare];
    }
}

/**
 *   点击某个分享按钮
 *
 */
- (void)clickShare:(ShareType)shareType{
    if(self.delegate && [self.delegate respondsToSelector:@selector(doShare:)]){
        [self.delegate doShare:shareType];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _coverView.frame = self.bounds;
    
    [self initShareTitleButton];
}

/**
 *   有标题的分享按钮
 */
- (void)initShareTitleButton{
    CGFloat scale = UIScale;
    
    _panelView.frame = CGRectMake(0, 0, 220 * scale, 150 * scale);
    _panelView.center = _coverView.center;
    _panelView.layer.cornerRadius = 10.0;
    _panelView.layer.masksToBounds = YES;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _panelView.width, 50 * scale)];
    titleLabel.text = @"分享到";
    [titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [_panelView addSubview:titleLabel];
    
    UIView *driver = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), _panelView.frame.size.width, 0.5)];
    driver.backgroundColor = RGBCOLOR(228, 228, 228);
    [_panelView addSubview:driver];
    
    CGFloat M = 35.0;
    CGFloat W = (_panelView.width - 4 * M) / 2.0;
    CGFloat H = _panelView.height - CGRectGetMaxY(driver.frame) - 20.0;
    CGFloat Y = CGRectGetMaxY(driver.frame);
    
    ShareViewTitleButton *weiXin = [[ShareViewTitleButton alloc] initWithFrame:CGRectMake(M, Y + 10.0, W, H) title:@"微信好友" iconName:@"wechat_normal" shareType:WeiXin];
    weiXin.delegate = self;
    [weiXin setIconNamePressed:@"wechat_pressed"];
    [_panelView addSubview:weiXin];
    
    ShareViewTitleButton *weixinFriend = [[ShareViewTitleButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weiXin.frame) + 2 * M, Y + 10.0, W, H) title:@"朋友圈" iconName:@"friend_circle_normal" shareType:WeiXinFriend];
    weixinFriend.delegate = self;
    [weixinFriend setIconNamePressed:@"friend_circle_pressed"];
    [_panelView addSubview:weixinFriend];
    
    _panelView.alpha = 0;
    WeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.panelView.alpha = 1;
    }];
}

@end

/**
 *   分享按钮,包含标题
 */
@interface ShareViewTitleButton ()

@property (strong, nonatomic)UIButton *shareButton;
@property (strong, nonatomic)UILabel *shareTitle;
@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *iconName;
@property (assign, nonatomic)ShareType shareType;

@end

@implementation ShareViewTitleButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title iconName:(NSString *)iconName shareType:(ShareType)shareType {
    self = [super initWithFrame:frame];
    if(self){
        self.shareType = shareType;
        self.title = title;
        self.iconName = iconName;
        [self initView];
    }
    return self;
}

- (void)initView {
    self.shareButton = [[UIButton alloc] init];
    [self addSubview:_shareButton];
    [_shareButton addTarget:self action:@selector(clickShare) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.shareTitle = [[UILabel alloc] init];
    [_shareTitle setTextAlignment:(NSTextAlignmentCenter)];
    _shareTitle.textColor = RGBCOLOR(147, 147, 147);
    [self addSubview:_shareTitle];
}

- (void)clickShare{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickShare:)]){
        [self.delegate clickShare:self.shareType];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_shareButton setBackgroundImage:[UIImage imageNamed:_iconName] forState:(UIControlStateNormal)];
    _shareButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    
    _shareTitle.text = _title;
    [_shareTitle sizeToFit];
    _shareTitle.frame = CGRectMake(0, self.width, _shareTitle.frame.size.width, self.height - self.width);
    _shareTitle.center = CGPointMake(_shareButton.center.x, _shareTitle.center.y);
}

- (void)setIconNamePressed:(NSString *)iconNamePressed{
    _iconNamePressed = iconNamePressed;
    [self.shareButton setImage:[UIImage imageNamed:iconNamePressed] forState:(UIControlStateHighlighted)];
}

@end
