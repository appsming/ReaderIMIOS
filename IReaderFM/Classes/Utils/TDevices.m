//
//  TDevices.m
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "TDevices.h"

@implementation TDevices


+ (Boolean)isFirstStart
{

    NSUserDefaults  *userDefault = [NSUserDefaults standardUserDefaults];

    
    if (![[userDefault objectForKey:kISFirstStart] isEqualToString:@"YES"]) {
        
        [userDefault setObject:@"YES" forKey:kISFirstStart];
    
        [userDefault synchronize];
    
        return YES;
    }
    
    return NO;
    

}



// 获取当前系统的版本
+ (float)getIOSVersionNo
{
    return [[[UIDevice currentDevice]systemVersion] floatValue];
}


// 获取网络是否正常
+ (Boolean)haveIntent
{
    Reachability  *reachability = [Reachability reachabilityWithHostName:KAppleUrl];
    
    if (reachability.currentReachabilityStatus == 0)
    {
        
        return NO;
        
    }
    return YES;
}

// 获取当前请求url
+ (NSString *)getBaseUrlWithApi:(NSString *)path
{
   NSString *baseUrl = @"";
    
     baseUrl = [NSString stringWithFormat:@"%@%@%@",FMAPI_HTTP,FMAPI_URL_HOST,path];

    return baseUrl;

}


// 创建获取显示进度条，提示框


+ (MBProgressHUD *)getProgressWithMsg:(NSString *)msg {
        
    MBProgressHUD  *HUD = [self createHUD];
    
    return HUD;
}

+ (void)showMesssageDialog:(NSString *)msg
{
    
    NSString *title =DSLocalizedString(@"dialog_title", nil);
    NSString *cancelButtonTitle = DSLocalizedString(@"ip_dialog_cancle", nil);
    NSString *destructiveButtonTitle = DSLocalizedString(@"ip_dialog_ok", nil);
    
    
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:destructiveButtonTitle, nil];
    
    [alter show];
    
    
}


+ (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    
    return HUD;
}



/**
 * 网址正则验证 1或者2使用哪个都可以
 *
 *  @param string 要验证的字符串
 *
 *  @return 返回值类型为BOOL
 */
+ (BOOL)urlValidation:(NSString *)string {
    NSError *error;
    // 正则1
    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    // 正则2
    regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch = [string substringWithRange:match.range];
        NSLog(@"匹配");
        return YES;
    }
    return NO;
}



// 创建UIButton
+ (UIButton *)createCommonButtonwithColor:(UIColor *)color
{
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    return btn;
    
}

// 解析数组
+ (NSArray *)parseDictWithAry:(NSDictionary *)data
{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in data) {
        [array addObject:dict];
    }
    return array;
}





+ (void)setCatalogAry:(NSString *)catalogJson
{

   NSUserDefaults  *catalogUserDefault =   [NSUserDefaults standardUserDefaults];

    [catalogUserDefault setObject:catalogJson forKey:kCatalogJson];
    
    [catalogUserDefault synchronize];

}

+ (NSString *)getCatalogJson
{

    NSUserDefaults  *catalogUserDefault =   [NSUserDefaults standardUserDefaults];
    
  NSString *jsonStr = [catalogUserDefault objectForKey:kCatalogJson];
    
    return jsonStr;
}

@end
