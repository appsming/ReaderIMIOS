//
//  CatalogInfo.h
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatalogInfo : NSObject

@property (nonatomic,copy) NSString *catalogId;

@property (nonatomic,copy) NSString *catalogName;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;

@end
