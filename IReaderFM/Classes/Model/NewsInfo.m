//
//  NewsInfo.m
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "NewsInfo.h"


static NSString * const kNewsId= @"_id";
static NSString * const kImgUrl = @"imgUrl";
static NSString * const kTitle = @"title";
static NSString * const kTextAuthor = @"textAuthor";
static NSString * const kListCount = @"listenCount";
static NSString * const kVoiceTime = @"voiceTime";
static NSString * const kVoiceAuthor = @"voiceAuthor";
static NSString * const kDescs = @"descs";
static NSString * const kVoiceUrl = @"voiceUrl";
static NSString * const  kContent= @"content";





@implementation NewsInfo


- (instancetype)initWithObjectFormDict:(NSDictionary *)dict
{

    self = [super init];
    if (!self) {return nil;}
    

    _newsId  = [dict  objectForKey:kNewsId];
    
    _imgUrl = [dict objectForKey:kImgUrl];
    
    _title  = [dict objectForKey:kTitle];
    
    _textAuthor = [dict objectForKey:kTextAuthor];
    
    _voiceAuthor  = [dict objectForKey:kVoiceAuthor];
    
    _listenCount = [dict objectForKey:kListCount];
    
    _voiceTime = [dict objectForKey:kVoiceTime];
    
    _descs  = [dict objectForKey:kDescs];
    
    
    _voiceUrl = [dict objectForKey:kVoiceUrl];
    
    _content = [dict objectForKey:kContent];
    return self;


}

@end
