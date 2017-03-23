//
//  PJExperienceModel.h
//  MJBDesign
//
//  Created by piaojin on 16/12/12.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *   {
 address = "\U8fbd\U5b81\U7701\U6c88\U9633\U5e02\U94c1\U897f\U533a\U4fdd\U5de5\U5317\U885738-2";
 name = "\U6c88\U9633\U7f8e\U5bb6\U5e2e\U4f53\U9a8c\U9986";
 phone = "024-31981992";
 "pic_url" = "https://img.mjbang.cn/5c85794b98e3087ed9bcf254e9c1fad9.jpg?t=1481532351";
 "work_time" = "09:00--18:00";
 }
 */
@interface PJExperienceModel : NSObject

@property (copy, nonatomic)NSString *address;
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *phone;
@property (copy, nonatomic)NSString *pic_url;
@property (copy, nonatomic)NSString *work_time;

@end
