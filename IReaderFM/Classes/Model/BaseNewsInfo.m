//
//  BaseNewsInfo.m
//  IReaderFM
//
//  Created by tao song on 2017/8/13.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "BaseNewsInfo.h"
static NSString * const kList = @"list";
static NSString * const kTotal = @"total";


@implementation BaseNewsInfo

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{

   self =   [super initWithObjectFormDict:dict];

    if (self) {
        
        _list  = [self.data objectForKey:kList];
        
        _pageCount = [[self.data objectForKey:kTotal] integerValue];
        
        
    }



    return self;

}


@end
