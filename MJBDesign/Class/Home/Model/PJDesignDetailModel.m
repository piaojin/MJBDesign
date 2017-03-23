//
//  PJDesignDetailModel.m
//  MJBDesign
//
//  Created by piaojin on 16/12/9.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJDesignDetailModel.h"

@implementation PJDesignDetailModel

@end


@implementation PicClassData

- (void)mj_keyValuesDidFinishConvertingToObject{
    NSLog(@"%@",self.mj_JSONString);
}

@end


@implementation PicClass

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"id":@"ID"};
}

@end


@implementation Info
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"id":@"ID"};
}
@end


@implementation Designer

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"id":@"ID"};
}

@end


