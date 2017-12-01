//
//  NewsInfo.h
//  IReaderFM
//  
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsInfo : NSObject

@property (nonatomic,copy) NSString  *newsId;

@property (nonatomic,copy) NSString *imgUrl;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *textAuthor;

@property (nonatomic,copy) NSString *voiceAuthor;

@property (nonatomic,copy) NSString *voiceTime;

@property (nonatomic,copy) NSString *listenCount;

@property (nonatomic,copy) NSString *descs;

@property (nonatomic,copy) NSString *voiceUrl;

@property (nonatomic,copy) NSString *content;

- (instancetype)initWithObjectFormDict:(NSDictionary *)dict;



@end
