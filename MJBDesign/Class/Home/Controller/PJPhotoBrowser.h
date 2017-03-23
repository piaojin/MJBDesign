//
//  PJPhotoBrowser.h
//  MJBDesign
//
//  Created by piaojin on 16/12/13.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <MWPhotoBrowser/MWPhotoBrowser.h>

@interface PJPhotoBrowser : MWPhotoBrowser

@property (copy, nonatomic) void (^shareBlock)();//分享
@property (copy, nonatomic) void (^collectBlock)();//收藏

@end
