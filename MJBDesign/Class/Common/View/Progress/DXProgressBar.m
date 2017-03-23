//
//  DXProgressBar.m
//  MJBangProject
//
//  Created by DavidWang on 16/7/25.
//  Copyright © 2016年 X团. All rights reserved.
//

#import "DXProgressBar.h"

@interface DXProgressBar ()

@property (assign, nonatomic) CGFloat count;
@property (strong, nonatomic) CADisplayLink *displayLink;

@end

@implementation DXProgressBar

static DXProgressBar *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progressTintColor = RGBCOLOR(184, 70, 226);
        self.trackTintColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)sharedProgressBar {
    return [[self alloc] init];
}

+ (void)showInView:(UIView *)view {
    DXProgressBar *bar = [DXProgressBar sharedProgressBar];
    [view addSubview:bar];
    bar.frame = CGRectMake(0, 64, SCREENWITH, 5);
    [bar starProgressDisplay];
}

+ (void)dismiss {
    DXProgressBar *bar = [DXProgressBar sharedProgressBar];
    [bar stopProgressDisplay];
}

//开启定时器
- (void)starProgressDisplay {
    self.count = 0;
    
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSRunLoopCommonModes];
    }
}

//更新进度
- (void)updateProgress {
    
    CGFloat total = 3.0;
    CGFloat interval = 1 * (1/total) / 60.0;
    
    self.progress = self.count;
    self.count += interval;
    
    if (self.count > 0.9) {
        self.displayLink.paused = YES;
    }
}

//关闭定时器
- (void)stopProgressDisplay {
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    self.count = 1;
    self.progress = self.count;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.hidden = YES;
        [self removeFromSuperview];
    });
}

@end
