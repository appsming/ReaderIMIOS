//
//  UIColor+Util.h
//  Vehicle20151123
//
//  Created by cxios on 15/11/23.
//  Copyright © 2015年 cxios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

+ (UIColor *)themeColor;
+ (UIColor *)blackTextColor;
+ (UIColor *)orangeTextColor;
+ (UIColor *)grayTextHitColor;

+ (UIColor *)whiteTextColor;

+ (UIColor *)NoSelectBoardColor;

+ (UIColor *)defaultBoardColor;

+ (UIColor *)SelectedBoardColor;
+ (UIColor *)navigationbarColor;
+ (UIColor *)separatorColor;

+ (UIColor *)titleBarColor;
+ (UIColor *)selectTitleBarColor;
+ (UIColor *)contentTextColor;
+ (UIColor *)selectCellSColor;
+ (UIColor *)cellsColor;
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
