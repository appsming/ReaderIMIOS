//
//  ApiParseModel.h
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsInfo.h"
#import "BaseNewsInfo.h"
#import "CatalogInfo.h"
#import "TDevices.h"

@interface ApiParseModel : NSObject


// 解析分类

+ (NSMutableArray *)parseCatalogListinfoWithJsonDict:(NSDictionary *)jsonDict;


// 解析新闻列表
+ (NSMutableArray *)parseNewsListinfoWithJsonDict:(NSDictionary *)jsonDict;

//解析新闻详情
+ (NewsInfo *)parseNewsDetailinfoWithJsonDict:(NSDictionary *)jsonDict;



@end
