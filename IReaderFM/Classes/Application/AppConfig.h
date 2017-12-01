//
//  AppConfig.h
//  IReaderFM
//
//  Created by tao song on 17/8/5.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//
#import "UIColor+Util.h"
#ifndef AppConfig_h
#define AppConfig_h

#define  KAppleUrl     @"https://www.apple.com/"



/*************************系统参数及类库(1)*********************************/

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

#define ScreenBounds  [[UIScreen mainScreen] bounds]

#define kISFirstStart   @"kISFirstStart"



/*************************发布设置(2)*********************************/

//debug:print log ,release:not print log
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


//color set
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define INCH35 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH47 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH55 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH55B ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)




#define NaviHeight 64
//分割线的高度
#define LINE_HEIGHT 0.5
//分割线的背景色
#define LINE_COLOR [UIColor colorWithHexString:@"cbcbcb"]

#define NO_WAN_CONNECT @"无网络连接"

#define XIAN_BLUE @"3faafb"
//输入框距左边距离
#define PUT_X       40
//按钮距左边的距离
#define BTN_X       35

#define kCell_Height 44

#define DEFAULT_CITY @"北京"

/**************************语言设置(3)************************************/

// set app Language
#define AppLanguage @"appLanguage"
//#define DSLocalizedString(key, comment) \
//[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

#define DSLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource: [[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]  rangeOfString:@"en" options:NSCaseInsensitiveSearch].length >0 ? @"en":@"zh-Hans" ofType:@"lproj"]] localizedStringForKey:(key)  value:@"" table:nil]


//#define DSLocalizedString(key, comment) \
//(([[[NSLocale preferredLanguages] objectAtIndex:0] isEqual:@"zh-Hans"])?([[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil]))


//保存旧的设置语言
#define AppLanguageOld @"appLanguageOld"
#define DS_CustomLocalizedOldString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguageOld"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

//应用内切换语言通知
#define KLanguageSwitching @"LanguageSwitching"
#define kCatalogNotice  @"CatalogNotice"

#define kCatalogJson  @"CatalogJson"

#define kSliderWidth  80


#import <MMDrawerController/MMDrawerVisualState.h>
#import <MMDrawerController/MMDrawerController.h>
#import "MMExampleDrawerVisualStateManager.h"

#endif /* AppConfig_h */
