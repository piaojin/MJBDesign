//
//  PJAdModel.h
//  MJBDesign
//
//  Created by piaojin on 16/12/9.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *   {
 "status": 200,
 "message": "",
 "data": [
 {
 "pic_url": "http://7xv4tm.com1.z0.glb.clouddn.com/0970dbd87a4eae85ce73e8e1809b358e.jpg?t=1481272855",
 "title": "2016国庆钜惠",
 "href": "http://i.mjbang.cn/zhuanti/2016guoqing.html"
 },
 {
 "pic_url": "http://7xv4tm.com1.z0.glb.clouddn.com/d964b338bd17f3697f7c217a59876814.jpg?t=1481272855",
 "title": "美家帮2周年",
 "href": "http://i.mjbang.cn/zhuanti/2year.html"
 },
 {
 "pic_url": "http://7xv4tm.com1.z0.glb.clouddn.com/f20c3855a8ecb7d5caf7e43c374517f4.jpg?t=1481272855",
 "title": "美家帮种子合伙人",
 "href": "http://www.mjbang.cn/zhuanti/partner.html"
 },
 {
 "pic_url": "http://7xv4tm.com1.z0.glb.clouddn.com/f393e1d51f9470d327ee6510a100ca52.jpg?t=1481272855",
 "title": "全包777m²",
 "href": "http://www.mjbang.cn/package.html"
 },
 {
 "pic_url": "http://7xv4tm.com1.z0.glb.clouddn.com/47f420cf64d64d74b60bb7d672ccf9bc.jpg?t=1481272855",
 "title": "24小时工地全程直播",
 "href": "http://www.mjbang.cn/live"
 }
 ]
 }
 */
@interface PJAdModel : NSObject


@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *href;


@end


