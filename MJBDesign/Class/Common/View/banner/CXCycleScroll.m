//
//  CXCycleScroll.m
//  MJBangProject
//
//  Created by X团 on 15/11/19.
//  Copyright © 2015年 X团. All rights reserved.
//

#import "CXCycleScroll.h"
#import "PJAdModel.h"

#define CXCYCLE_TIMER_COUNT 3

#define CXCYCLE_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CXCYCLE_SCREEN_HIGHT  [UIScreen mainScreen].bounds.size.height

@interface CXCycleScroll ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIImageView * placeholdImg;
@property (strong, nonatomic) DDPageControl * pageControl;
@property (assign, nonatomic) CGFloat currentOffX;
@property (strong, nonatomic) NSTimer * timer;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) BOOL isTimer;

@property (strong, nonatomic) NSArray * scrollArray;
@property (strong, nonatomic) NSArray * currentArray;
@property (weak, nonatomic)PJAdModel *model;

@end

@implementation CXCycleScroll

-(instancetype)init {

    self = [super init];
    if (self) {
        
        self.pageType = DDPageControlTypeOnFullOffFull;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.pageType = DDPageControlTypeOnFullOffFull;
    }
    
    return self;
}

/**
 * 初始化
 */
-(void)create {

    // scroll View
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    
    // programmatically add the page control
    self.pageControl = [[DDPageControl alloc] init];
    //[self.pageControl setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 10)];
    [self.pageControl setCenter:CGPointMake(self.scrollView.center.x, self.frame.size.height - 10 * UIScale)];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setType:self.pageType];
    [self.pageControl setOnColor:self.onColor];
    [self.pageControl setOffColor:self.offColor];
    [self.pageControl setIndicatorDiameter:self.indicatorDiameter];
    [self.pageControl setIndicatorSpace:self.indicatorSpace];
    [self addSubview: self.pageControl];
    self.pageControl.userInteractionEnabled = NO;
    
    //placehold Img
    self.placeholdImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.placeholdImg.contentMode = UIViewContentModeScaleAspectFill;
    self.placeholdImg.clipsToBounds = YES;
    self.placeholdImg.image = self.placeholderImage;
    [self.scrollView addSubview:self.placeholdImg];
}

/**
 * start timer
 */
-(void)startTimer {
    
    self.count = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:CXCYCLE_TIMER_COUNT target:self selector:@selector(scrollMoveAnimalm) userInfo:nil repeats:YES];
}

/**
 * 计时器到时,系统滚动图片
 */
- (void)scrollMoveAnimalm {
    
    self.isTimer = YES;
    
    [self scrollViewDidRollOneMoreTime:self.scrollView];
}

/**
 * 设置图片
 */
-(void)setBannerArray:(NSArray *)bannerArray {

    if (bannerArray.count <= 0) {
        [self.placeholdImg setHidden:NO];
        return;
    }
    
    if (_scrollArray.count != 0) {
        return;
    }
    
    [self.placeholdImg setHidden:YES];
    _scrollArray = bannerArray;
    self.currentArray = bannerArray;
    if(self.currentArray.count > 1){
        [self.pageControl setNumberOfPages:_scrollArray.count];
    }else{
        [self.pageControl setNumberOfPages:0];
    }
    
    if(_scrollArray.count > 1){
        id object1 = _scrollArray[0];
        id object2 = _scrollArray[_scrollArray.count - 1];
        NSMutableArray * array = [[NSMutableArray alloc] init];
        [array addObjectsFromArray:_scrollArray];
        [array addObject:object1];
        [array insertObject:object2 atIndex:0];
        _scrollArray = (NSArray *)array;
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _scrollArray.count, self.scrollView.frame.size.height);
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
    }
    
    for (int i = 0; i < _scrollArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if (i == 0) {
            imageView.tag = _scrollArray.count - 1;
            
        } else if(i == _scrollArray.count - 1){
            imageView.tag = 0;
            
        } else {
            imageView.tag = i - 1;
        }
        [self.scrollView addSubview:imageView];
        
        //设置图片
        id object = _scrollArray[i];
        NSString * imgUrl = nil;
        if ([object isKindOfClass:[PJAdModel class]]) {
            PJAdModel *model = (PJAdModel *)object;
            self.model = model;
            imgUrl = model.pic_url;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]  placeholderImage:self.placeholderImage];// 将需要缓存的图片加载进来
            
        } else if([object isKindOfClass:[NSString class]]){
            imgUrl = (NSString *)object;
            imageView.image = [UIImage imageNamed:imgUrl];
            
        } else {
            imageView.image = self.placeholderImage;
        }
        
        if (!imgUrl) {
            imageView.image = self.placeholderImage;
        }
        
        //tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        tap.view.tag = imageView.tag;
        [imageView addGestureRecognizer:tap];
    }
    
    if (_scrollArray.count > 1) {
        // start timer
        [self startTimer];
    }
}

#pragma mark - image touch
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    //设置代理
    if ([self.delegate respondsToSelector:@selector(CXCycleScrollView:withTouchIndex:object:)]) {
        [self.delegate CXCycleScrollView:self withTouchIndex:tap.view.tag object:self.model];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.currentOffX = scrollView.contentOffset.x;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.isTimer = NO;
    
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:CXCYCLE_TIMER_COUNT]];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidRollOneMoreTime:scrollView];
}

-(void)scrollViewDidRollOneMoreTime:(UIScrollView *)scrollView {

    if (!self.timer) {
        return;
    }
    
    int offset = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.count = offset;
    
    //new
    if (offset == self.scrollArray.count - 1) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
        self.count = 2;
        if (self.isTimer) {
            [self.pageControl setCurrentPage:1];
        } else {
            [self.pageControl setCurrentPage:0];
        }
        
    } else if (offset == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (self.scrollArray.count - 2), 0) animated:NO];
        self.count = self.scrollArray.count - 2;
        [self.pageControl setCurrentPage:self.currentArray.count - 1];
        
    } else {
        if (self.isTimer) {
            if (self.count >= 1 && self.count <= self.currentArray.count - 1) {
                [self.pageControl setCurrentPage:self.count];
            } else if (self.count == self.currentArray.count) {
                [self.pageControl setCurrentPage:0];
            }
            self.count ++;
        } else {
            [self.pageControl setCurrentPage:self.count - 1];
            if((scrollView.contentOffset.x - self.currentOffX) > 0) {
                self.count ++;
            } else {
                self.count --;
            }
        }
    }
    
    if (self.isTimer) {
        [self.scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * self.count, 0) animated:YES];
    }
}

@end
