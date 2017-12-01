//
//  BaseResponse.m
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "BaseResponse.h"


static NSString * const kData= @"data";
static NSString * const kMsg = @"msg";
static NSString * const kSuccess = @"success";
static NSString * const kCode = @"code";



@implementation BaseResponse


- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{
    self = [super init];
    if (!self) {return nil;}
    

    _data  = [dict objectForKey:kData];
    
    _msg  = [dict objectForKey:kMsg];
    
    _success = [[dict objectForKey:kSuccess] boolValue];
    
    _code = [[dict objectForKey:kCode] integerValue];
    

    return self;
    
    
    
}
@end
