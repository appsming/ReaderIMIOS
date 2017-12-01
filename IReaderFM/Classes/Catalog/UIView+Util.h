//
//  UIView+Util.h
//  Vehicle20151123
//
//  Created by cxios on 15/11/23.
//  Copyright © 2015年 cxios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

- (UIImage *)convertViewToImage;
- (UIImage *)updateBlur;

@end
