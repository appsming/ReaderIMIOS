//
//  UIButton+UIButtonImageWithLable.m
//  Vehicle
//
//  Created by cxios on 15/11/2.
//  Copyright © 2015年 cxios. All rights reserved.
//

#import "UIButton+UIButtonImageWithLable.h"

@implementation UIButton (UIButtonImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType isPianyi:(BOOL)pianyi {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    if (pianyi) {
        CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12.0f]];
        [self.imageView setContentMode:UIViewContentModeCenter];
        [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                                  0.0,
                                                  0.0,
                                                  -titleSize.width)];
        [self setImage:image forState:stateType];
        
        [self.titleLabel setContentMode:UIViewContentModeCenter];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                                  -image.size.width,
                                                  0.0,
                                                  0.0)];
        [self setTitle:title forState:stateType];
    }else {
        
        
        
        CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12.0f]];
        [self.imageView setContentMode:UIViewContentModeCenter];
        [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                                  0.0,
                                                  0.0,
                                                  0.0)];
        [self setImage:image forState:stateType];
        
        [self.titleLabel setContentMode:UIViewContentModeCenter];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                                  0.0,
                                                  0.0,
                                                  0.0)];
        [self setTitle:title forState:stateType];
    }
    
    
    
}
@end
