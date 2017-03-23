//
//  PJDesignModel.h
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
 "id": "201611293543304716",
 "member_id": 633219,
 "house_type": "",
 "style": "现代简约之森林雅趣",
 "city": "重庆",
 "design": "江成",
 "avatar": "http://v15.owner.meijiabang.net/file?id=201612013403440810",
 "name": "的说法收到",
 "address": "88洋",
 "cost": 62160,
 "acreage_use": "60.00",
 "reserve_num": 374,
 "pic_url": "http://v15.owner.meijiabang.net/file?id=201612012619251008"
 },
 {
 "id": "201611242885861979",
 "member_id": 630866,
 "house_type": "",
 "style": "",
 "city": "广州",
 "design": "周维鑫",
 "avatar": "http://v15.owner.meijiabang.net/file?id=201610313777993049",
 "name": "3",
 "address": "天胜村",
 "cost": 0,
 "acreage_use": "0.00",
 "reserve_num": 487,
 "pic_url": ""
 },
 {
 "id": "201611124103042019",
 "member_id": 615745,
 "house_type": "四房",
 "style": "现代简约之森林雅趣",
 "city": "厦门",
 "design": "陈煌坚",
 "avatar": "http://v15.owner.meijiabang.net/file?id=201610303795334866",
 "name": "",
 "address": "橡树湾三期11号B梯2402",
 "cost": 100906.4,
 "acreage_use": "97.40",
 "reserve_num": 250,
 "pic_url": ""
 },
 {
 "id": "201611102606789236",
 "member_id": 613864,
 "house_type": "三房",
 "style": "现代简约",
 "city": "深圳",
 "design": "王冬微",
 "avatar": "http://v15.owner.meijiabang.net/file?id=201610271065522406",
 "name": "",
 "address": "HT益田村",
 "cost": 67340,
 "acreage_use": "65.00",
 "reserve_num": 212,
 "pic_url": "http://v15.owner.meijiabang.net/file?id=201611140777278141"
 }
 ]
 }
 */
@interface PJDesignModel : NSObject


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *style;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, assign) NSInteger reserve_num;

@property (nonatomic, copy) NSString *pic_url;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *house_type;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *acreage_use;

@property (nonatomic, copy) NSString *design;

@property (nonatomic, assign) NSInteger member_id;



@end


