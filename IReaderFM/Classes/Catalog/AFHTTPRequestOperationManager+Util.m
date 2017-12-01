//
//  AFHTTPRequestOperationManager+Util.m
//  Vehicle20151123
//
//  Created by cxios on 15/11/23.
//  Copyright © 2015年 cxios. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Util.h"
#import "Reachability.h"

@implementation AFHTTPRequestOperationManager (Util)


+ (instancetype)CXManager
{
  
   
    AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
    
  
    [manager.securityPolicy setAllowInvalidCertificates:YES];  //忽略https证书
   
    [manager.securityPolicy setValidatesDomainName:NO];  //是否验证域名
    // 设置请求格式
    // manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager.requestSerializer setValue:[self generateUserAgent] forHTTPHeaderField:@"User-Agent"];
    
    return manager;
}

+ (NSString *)generateUserAgent
{
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString *IDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    return [NSString stringWithFormat:@"cxgps.com/%@/%@/%@/%@/%@", appVersion,
            [UIDevice currentDevice].systemName,
            [UIDevice currentDevice].systemVersion,
            [UIDevice currentDevice].model,
            IDFV];
}



@end

