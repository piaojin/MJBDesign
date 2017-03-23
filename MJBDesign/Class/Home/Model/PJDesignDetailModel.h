//
//  PJDesignDetailModel.h
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
 "data": {
 "info": {
 "cost": 68376,
 "acreage_use": "66.00",
 "address": "广州粤信广场",
 "id": "201611041356057634",
 "member_id": 604965,
 "house_type": "两房",
 "package_name": "现代简约之森林雅趣",
 "city": "广州",
 "designer": {
 "id": 3098,
 "avatar_id": "201610293089784188",
 "avatar_pic": "http://v15.owner.meijiabang.net/file?id=201610293089784188",
 "name": "朱淑娟",
 "memo": "设计源于生活，生活造就设计"
 }
 },
 "pic_data": [
 "http://v15.owner.meijiabang.net/file?id=201611113430196587",
 "http://v15.owner.meijiabang.net/file?id=201611113666309018"
 ],
 "pic_class_data": {
 "0": {
 "id": 985,
 "type": "pm",
 "panorama_link": "全景",
 "summary": "",
 "name": "",
 "pic_list": [
 "http://v15.owner.meijiabang.net/file?id=201611113430196587"
 ],
 "class_name": "平面图"
 },
 "4": {
 "id": 986,
 "type": "qt",
 "panorama_link": "",
 "summary": "",
 "name": "",
 "pic_list": [
 "http://v15.owner.meijiabang.net/file?id=201611113666309018"
 ],
 "class_name": "其他"
 }
 }
 }
 }
 */
@class PicClassData,Info,Designer,PicClass;

@interface PJDesignDetailModel : NSObject

@property (nonatomic, strong) PicClassData *pic_class_data;

@property (nonatomic, strong) Info *info;

@property (nonatomic, strong) NSArray<NSString *> *pic_data;

@end

@interface PicClassData : NSObject

@property (nonatomic, strong) NSArray<PicClass *> *pic_class;

@end

@interface PicClass : NSObject

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *panorama_link;

@property (nonatomic, strong) NSArray<NSString *> *pic_list;

@property (nonatomic, copy) NSString *class_name;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;

@end

@interface Info : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, copy) NSString *acreage_use;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger member_id;

@property (nonatomic, copy) NSString *package_name;

@property (nonatomic, copy) NSString *house_type;

@property (nonatomic, strong) Designer *designer;

@end

@interface Designer : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *avatar_id;

@property (nonatomic, copy) NSString *memo;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *avatar_pic;

@end

