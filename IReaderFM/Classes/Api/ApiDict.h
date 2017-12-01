//
//  ApiDict.h
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiDict : NSObject

// 获取分类
+ (NSMutableDictionary *) catalogDictOnInit;


// 获取资讯列表
+ (NSMutableDictionary *) newsListDictWithPageNo:(NSInteger)pageNo andPageSize:(NSInteger)pageSize andkeyType:(NSString *)keyType;


// 获取资讯详情
+ (NSMutableDictionary *) newsDetailDictWithNewsId:(NSString *)newsId;

// 资讯搜索列表
+ (NSMutableDictionary *) newsSearchListWithKey:(NSString *)content;


// 获取用户登录
+ (NSMutableDictionary *) userLoginDictWithName:(NSString *)name andPwd:(NSString *)passwd;


// 获取用户注册
+ (NSMutableDictionary *) userRegisterDictWithPhone:(NSString *)name andPwd:(NSString *)passwd andCode:(NSString *)regiserCode;
@end
