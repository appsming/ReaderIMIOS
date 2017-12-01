//
//  ImageHeaderView.h
//  IReaderFM
//
//  Created by tao song on 17/8/6.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface ImageHeaderView : UIView

@property (nonatomic,strong) UIImageView *profileImage;

@property (nonatomic,strong) UIImageView  *backgroundImage;

@property (nonatomic,strong) UILabel      *nickNameLabel;

@property (nonatomic,strong) UILabel      *nameDescLabel;

@end
