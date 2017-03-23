//
//  SetterModel.h
//  MJBDesign
//
//  Created by 美家帮 on 2016/12/24.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetterModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *value;
@property(nonatomic,assign)BOOL isCache;

@end
