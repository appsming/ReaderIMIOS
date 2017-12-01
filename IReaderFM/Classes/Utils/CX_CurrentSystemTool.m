/******************************************************************************
 版权所有 :  此文件版权归深圳市世纪畅行科技有限公司
 文件名称  :    CX_CurrentSystemTool.m
 文件作用描述  : 实现语言的配置文件保存，读取plist文件
 文件创建人 :    明邦良
 文件创建时间 :   16-12-2
 文件修改人 :
 文件修改时间 :
 修改描述 :
 备注     :
 ******************************************************************************/



#import "CX_CurrentSystemTool.h"
#import "AppConfig.h"
static NSString *const login = @"isFirstApp";


@implementation CX_CurrentSystemTool

+ (NSString *)currentSysTemLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSArray *lauguageArr = [currentLanguage componentsSeparatedByString:@"-"];
//#if TARGET_IPHONE_SIMULATOR
//   // currentLanguage = [currentLanguage substringToIndex:currentLanguage.length - 3];
//#else
//    //包含繁体中文
//    if ([currentLanguage containsString:@"-CN"]) {
//        currentLanguage = [currentLanguage substringToIndex:currentLanguage.length - 3];
//    }
//#endif
    NSString *lauguageString;
    if (lauguageArr.count > 1) {
        NSString *lauStr = [lauguageArr[0] stringByAppendingString:@"-"];
        lauguageString = [lauStr stringByAppendingString:lauguageArr[1]];
    } else {
        lauguageString = currentLanguage;
    }
    
    
    
    
    return lauguageString;
}

+ (void)saveSetLanguage:(NSString *)language
{
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
}

+ (NSString *)readCurrentAppLanguage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage];
}

+ (void)saveOldLanguage
{
    NSString *oldLanguage = [CX_CurrentSystemTool readCurrentAppLanguage];
    if (![oldLanguage isEqualToString:@""] && oldLanguage) {
        [[NSUserDefaults standardUserDefaults] setObject:oldLanguage forKey:AppLanguageOld];
    }
}

+ (NSString *)readOldLanguage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguageOld];
}

+ (NSString *)currentSetLanguageKey
{
    NSString *currentLanguage = [CX_CurrentSystemTool readCurrentAppLanguage];
    NSDictionary *dict = [CX_CurrentSystemTool appAllLanguages];
    __block NSString *currentKey = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:currentLanguage]) {
            currentKey = key;
            *stop = YES;
        }
    }];
    return currentKey;
}

+ (NSDictionary *)appAllLanguages
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CXLocalizable.plist" ofType:nil];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}


@end


@implementation CX_AppStartState
+ (BOOL)isFirstStart
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![[userDefaults objectForKey:login] isEqualToString:@"YES"]) {
        [userDefaults setObject:@"YES" forKey:login];
        [userDefaults synchronize];
        return YES;
    }
    return NO;
}

@end



