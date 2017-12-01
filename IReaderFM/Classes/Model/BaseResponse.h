//
//  BaseResponse.h
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject

@property (nonatomic,assign) NSInteger code;

@property (nonatomic,strong) NSDictionary *data;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,assign) Boolean  success;


- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;


@end
