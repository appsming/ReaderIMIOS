//
//  BaseNewsInfo.h
//  IReaderFM
//
//  Created by tao song on 2017/8/13.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "BaseResponse.h"

@interface BaseNewsInfo : BaseResponse

@property (nonatomic,strong) NSMutableDictionary *list;
@property (nonatomic,assign) NSInteger pageCount;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;


@end
