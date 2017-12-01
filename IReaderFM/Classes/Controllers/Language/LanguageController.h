//
//  DS_LanguageController.h
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "BaseTableViewController.h"
@class LanguageController;

@protocol LanguageControllerDelegate <NSObject>
@optional
- (void)languageControllerBack:(LanguageController *)languaeController;

@end

@interface LanguageController : BaseTableViewController
@property (nonatomic,weak)id<LanguageControllerDelegate>delegate;
@end
