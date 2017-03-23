//
//  PJHttpModel.h
//  MJBangProject
//
//  Created by DavidWang on 16/8/8.
//  Copyright © 2016年 X团. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJBHttpModel : NSObject

@property (assign, nonatomic) NSInteger status;

@property (strong, nonatomic) NSString *message;

@property (strong, nonatomic) id data;

@end
