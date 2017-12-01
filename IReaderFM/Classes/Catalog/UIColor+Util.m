//
//  UIColor+Util.m
//  Vehicle20151123
//
//  Created by cxios on 15/11/23.
//  Copyright © 2015年 cxios. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

#pragma mark - theme colors

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)themeColor
{
    
    return [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
}

+ (UIColor *)blackTextColor
{
    
    return [UIColor colorWithRed:37.0/255 green:46.0/255 blue:49.0/255 alpha:1.0];
    
}


+ (UIColor *)orangeTextColor
{
    
    return [UIColor colorWithRed:255.0/255 green:168.0/255 blue:73.0/255 alpha:1.0];
    
}


+ (UIColor *)grayTextHitColor
{
    
    return [UIColor colorWithRed:168.0/255 green:168.0/255 blue:164.0/255 alpha:1.0];
    
}

+ (UIColor *)whiteTextColor
{
    
    return [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    
}


+ (UIColor *)defaultBoardColor
{
    
    return [UIColor colorWithRed:232.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    
}



+ (UIColor *)NoSelectBoardColor
{
    
    return [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.0];
    
}

+ (UIColor *)SelectedBoardColor
{
    
    return [UIColor colorWithRed:255.0/255 green:168.0/255 blue:73.0/255 alpha:1.0];
    
}


+ (UIColor *)navigationbarColor
{
    
    return [UIColor colorWithRed:255.0/255.0 green:168.0/255.0 blue:72.0/255.0 alpha:1.0];
}

+ (UIColor *)separatorColor
{
    
    return [UIColor colorWithRed:217.0/255 green:217.0/255 blue:223.0/255 alpha:1.0];
}



+ (UIColor *)titleBarColor
{
    
    return [UIColor colorWithHex:0xE1E1E1];
}

+ (UIColor *)contentTextColor
{
    
    return [UIColor colorWithHex:0x272727];
}


+ (UIColor *)selectTitleBarColor
{
    
    
    return [UIColor colorWithHex:0xE1E1E1];
}


+ (UIColor *)selectCellSColor
{
    
    return [UIColor colorWithRed:203.0/255 green:203.0/255 blue:203.0/255 alpha:1.0];
}


+ (UIColor *)cellsColor
{
    return [UIColor whiteColor];
}


+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}



@end
