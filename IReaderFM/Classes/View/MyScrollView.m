//
//  MyScrollView.m
//  IReaderFM
//
//  Created by tao song on 2017/8/12.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

/**
 *  重写手势，如果是左滑，则禁用掉scrollview自带的
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
