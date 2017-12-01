//
//  CatalogInfo.m
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "CatalogInfo.h"

static NSString * const kCatalogId = @"key";
static NSString * const kCatalogName = @"name";




@implementation CatalogInfo

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{
    self = [super init];
    if (!self) {return nil;}
    
    
     _catalogId  = [dict objectForKey:kCatalogId];
    
    _catalogName  = [dict objectForKey:kCatalogName];
    
    return self;

}

@end
