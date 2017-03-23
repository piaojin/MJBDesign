//
//  ShareManager.h
//  mjbang_work
//
//  Created by piaojin on 16/10/19.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *   友盟分享自定义事件
 */
#define MobClickSocialTypeWxsesion @"MobClickSocialTypeWxsesion"  //微信好友分享
#define MobClickSocialTypeWxtimeline @"MobClickSocialTypeWxtimeline" //微信朋友圈

typedef enum {
    WeiXin,//微信朋友分享
    WeiXinFriend,//微信朋友圈
    QQShare,//QQ
    CopyUrl//复制链接
} ShareType;

/**
 *  分享操作的回调
 *
 *  @param result 表示回调的结果
 *  @param error  表示回调的错误码
 */
typedef void (^ShareCompletionHandler)(id result,NSError *error);

#pragma 分享协议
@protocol ShareViewDelegate <NSObject>

/**
 *   退出分享
 */
- (void)closeShare;
/**
 *   分享
 */
- (void)doShare:(ShareType)shareType;

@end

@protocol ShareViewClickDelegate <NSObject>

/**
 *   点击某个分享按钮
 */
- (void)clickShare:(ShareType)shareType;

@end

@class ShareContent;
#pragma 分享管理类
@interface ShareManager : NSObject

@property (copy, nonatomic)ShareCompletionHandler shareCompletionHandler;

+ (ShareManager *)shareManager;

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
+ (void)showShareWithTitle:(NSString *)title descr:(NSString *)descr shareUrl:(NSString *)shareUrl shareIcon:(id)shareIcon showView:(UIView *)showView completion:(ShareCompletionHandler)completion;

+ (void)showShare:(NSString *)title descr:(NSString *)descr shareUrl:(NSString *)shareUrl shareIcon:(id)shareIcon showView:(UIView *)showView completion:(ShareCompletionHandler)completion;

/**
 *   关闭分享面板
 */
+ (void)closeSharePanel;

/**
 *   设置蒙层frame
 */
+ (void)setCoverFrame:(CGRect)frame;

/**
 *   设置分享面板背景视图frame
 */
+ (void)setSharePanelBgViewFrame:(CGRect)frame;
/**
 *   设置分享面板frame
 */
+ (void)setSharePanelFrame:(CGRect)frame;

@end

#pragma 分享视图类
@interface ShareView : UIView

@property (weak, nonatomic)id<ShareViewDelegate> delegate;
//蒙层
@property (strong, nonatomic)UIView *coverView;
//分享面板
@property (strong, nonatomic)UIView *panelView;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *   关闭分享面板
 */
- (void)closeShareView;

@end

#pragma 分享按钮,包含标题
@interface ShareViewTitleButton : UIView

@property (weak, nonatomic)id<ShareViewClickDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title iconName:(NSString *)iconName shareType:(ShareType)shareType;
@property (copy, nonatomic)NSString *iconNamePressed;

@end