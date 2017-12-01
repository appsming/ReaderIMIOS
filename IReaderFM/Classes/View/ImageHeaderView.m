//
//  ImageHeaderView.m
//  IReaderFM
//
//  Created by tao song on 17/8/6.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "ImageHeaderView.h"

@implementation ImageHeaderView


- (instancetype)init
{

    self  = [super init];

    if (self) {
        [self  initView];
        [self drawView];
        [self setViewAppearce];  // 设置属性
    }
    
    return self;

}


- (void)initView
{

    _profileImage  = [[UIImageView alloc] init];
    
    _backgroundImage = [[UIImageView alloc] init];

    _nickNameLabel  = [[UILabel alloc] init];
    
    _nameDescLabel = [[UILabel alloc] init];

    
    [self addSubview:_profileImage];
    
    [self addSubview:_backgroundImage];
    
    [self addSubview:_nickNameLabel];
    
    [self addSubview:_nameDescLabel];
}


- (void)drawView
{
    
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
        
    }];
    
    

    [_profileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.mas_equalTo(self.mas_top).offset(20);
//        make.left.mas_equalTo(self.mas_left).offset(20);

        make.center.mas_equalTo(self.center).offset(10);
        
        
    }];

    
    [_nickNameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.profileImage.mas_bottom).offset(10);
        
        make.center.mas_equalTo(self.center);
    }];
    
    
    
    [_nameDescLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(10);
        
        make.center.mas_equalTo(self.center);
        
        make.bottom.mas_equalTo(self.mas_bottom);

    }];
    
    
    
    



}



- (void)setViewAppearce
{




}



@end
