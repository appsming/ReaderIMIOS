//
//  GuideCell.h
//  CarTrace
//
//  Created by tao song on 16/12/2.
//  Copyright © 2016年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GuideCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView  *guideImageViews;

@property (nonatomic,strong) UIButton  *nextButtons;


@property (nonatomic,copy)  void (^tryToUserBtnBlock)();


- (void)setNewImageCell:(UIImage *) guideImag;

@end
