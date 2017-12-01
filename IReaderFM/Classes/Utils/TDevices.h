//
//  TDevices.h
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>
#import <PINCache/PINCache.h>
#import "MBProgressHUD.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import "MMRequestManager.h"
#import "ApiDict.h"
#import "ApiConfig.h"
#import "AppConfig.h"
#import "JSONTools.h"
#import "UIImage+Rotate.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"
#import "AFHTTPRequestOperationManager+Util.h"
#import "UIButton+UIButtonImageWithLable.h"
#import "NSString+Custom.h"
#import "CX_CurrentSystemTool.h"

@interface TDevices : NSObject

+ (Boolean)isFirstStart;

// 判断是否有网
+ (Boolean)haveIntent;

// 获取当前系统的版本
+ (float)getIOSVersionNo;

// 获取当前请求url
+ (NSString *)getBaseUrlWithApi:(NSString *)path;


// 创建获取显示进度条，提示框
+ (MBProgressHUD *)getProgressWithMsg:(NSString *)msg;
+ (MBProgressHUD *)createHUD;
+ (void)showMesssageDialog:(NSString *)msg;

+ (BOOL)urlValidation:(NSString *)string ;
// 创建UIButton
+ (UIButton *)createCommonButtonwithColor:(UIColor *)color;

+ (NSArray *)parseDictWithAry:(NSDictionary *)data;


+ (void)setCatalogAry:(NSString *)jsonStr;

+ (NSString *)getCatalogJson;

@end
