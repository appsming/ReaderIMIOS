//
//  UIButton+UIButtonImageWithLable.h
//  Vehicle
//
//  Created by cxios on 15/11/2.
//  Copyright © 2015年 cxios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType isPianyi:(BOOL)pianyi;
@end
