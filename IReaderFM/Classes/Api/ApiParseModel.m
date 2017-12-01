//
//  ApiParseModel.m
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "ApiParseModel.h"

@implementation ApiParseModel


// 解析分类

+ (NSMutableArray *)parseCatalogListinfoWithJsonDict:(NSDictionary *)jsonDict
{
    
   NSArray *data  =    [TDevices parseDictWithAry:jsonDict];
  
    NSMutableArray  *catalogAry = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in data) {
        
        Boolean  shouldAdd = YES;
        
        CatalogInfo  *catalogInfo = [[CatalogInfo alloc] initWithObjectFormDict:dict];
        
       
        for (CatalogInfo *tempInfo in catalogAry) {
            if ([catalogInfo.catalogName isEqualToString:tempInfo.catalogName]) {
                shouldAdd  = NO;
                break;
            }
        }
        
        if (shouldAdd) {
            [catalogAry addObject:catalogInfo];
        }
        
        
        
    }
    
    return catalogAry;

}


// 解析新闻列表
+ (NSMutableArray *)parseNewsListinfoWithJsonDict:(NSDictionary *)jsonDict
{
    
    NSArray *data  =    [TDevices parseDictWithAry:jsonDict];
    
    NSMutableArray  *newsListAry = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in data) {
        
        Boolean  shouldAdd = YES;
        
        NewsInfo  *newsInfo = [[NewsInfo alloc] initWithObjectFormDict:dict];
        
        
        for (NewsInfo *tempInfo in newsListAry) {
            if ([newsInfo.newsId isEqualToString:tempInfo.newsId]) {
                shouldAdd  = NO;
                break;
            }
        }
        
        if (shouldAdd) {
            [newsListAry addObject:newsInfo];
        }
        
        
        
    }
    
    return newsListAry;

    
    
}


//解析新闻详情
+ (NewsInfo *)parseNewsDetailinfoWithJsonDict:(NSDictionary *)jsonDict
{
    
     NewsInfo  *newsInfo = [[NewsInfo alloc] initWithObjectFormDict:jsonDict];
    
    return newsInfo;

}





@end
