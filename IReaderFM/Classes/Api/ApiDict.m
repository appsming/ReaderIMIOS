//
//  ApiDict.m
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "ApiDict.h"

@implementation ApiDict


// 获取分类
+ (NSMutableDictionary *) catalogDictOnInit
{

    NSMutableDictionary  *catalogDict = [[NSMutableDictionary alloc] init];


    return catalogDict;

}


// 获取资讯列表
+ (NSMutableDictionary *) newsListDictWithPageNo:(NSInteger)pageNo andPageSize:(NSInteger)pageSize andkeyType:(NSString *)keyType
{

    NSMutableDictionary  *newsListDict = [[NSMutableDictionary alloc] init];
    
    [newsListDict setValue:keyType forKey:@"typeKey"];
    [newsListDict setValue:@(pageNo) forKey:@"pageNo"];
    [newsListDict setValue:@(pageSize) forKey:@"pageSize"];
    
    NSLog(@"===newsListDictWithPageNo========%@",newsListDict);
    
    
    return newsListDict;



}


// 获取资讯详情
+ (NSMutableDictionary *) newsDetailDictWithNewsId:(NSString *)newsId
{

    NSMutableDictionary  *newsDetailDict = [[NSMutableDictionary alloc] init];
    
    
    [newsDetailDict setValue:newsId forKey:@"_id"];
    
    
    return newsDetailDict;



}

// 资讯搜索列表
+ (NSMutableDictionary *) newsSearchListWithKey:(NSString *)content
{

    NSMutableDictionary  *newsSearchDict = [[NSMutableDictionary alloc] init];
    
    
    [newsSearchDict setValue:content forKey:@"content"];
    
    
    return newsSearchDict;
    


}


// 获取用户登录
+ (NSMutableDictionary *) userLoginDictWithName:(NSString *)name andPwd:(NSString *)passwd
{

    NSMutableDictionary  *userLoginDict = [[NSMutableDictionary alloc] init];
    
    
    [userLoginDict setValue:name forKey:@"name"];
    
    [userLoginDict setValue:passwd forKey:@"passwd"];
  
    return userLoginDict;



}


// 获取用户注册
+ (NSMutableDictionary *) userRegisterDictWithPhone:(NSString *)name andPwd:(NSString *)passwd andCode:(NSString *)regiserCode
{

    NSMutableDictionary  *userLoginDict = [[NSMutableDictionary alloc] init];
    
    
    [userLoginDict setValue:name forKey:@"name"];
    
    [userLoginDict setValue:passwd forKey:@"passwd"];
    
     [userLoginDict setValue:regiserCode forKey:@"rgcode"];
    
    return userLoginDict;


}


@end
