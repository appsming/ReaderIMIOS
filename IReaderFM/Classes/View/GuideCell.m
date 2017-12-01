//
//  GuideCell.m
//  Monitor
//
//  Created by tao song on 16/4/1.
//  Copyright © 2016年 ming bangliang. All rights reserved.
//

#import "GuideCell.h"
#import "AppConfig.h"

@implementation GuideCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nextButtons = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 100) * 0.5, ScreenHeight - 90, 100, 33)];
       
        self.guideImageViews = [[UIImageView alloc]initWithFrame:ScreenBounds];
        
      
        
        self.guideImageViews.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.guideImageViews];
        
        [self.nextButtons setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState: UIControlStateNormal];
       
         [self.nextButtons addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.nextButtons  setHidden:YES];
        [self.contentView addSubview:self.nextButtons];
    }
    return self;
}


- (void)setNextButtonHidden:(Boolean)hidden
{

    [self.nextButtons  setHidden:hidden];

}

- (void)setNewImageCell:(UIImage *) guideImag
{

    self.guideImageViews.image = guideImag;

}


- (void)nextButtonClick
{

  
    if (self.tryToUserBtnBlock) {
        self.tryToUserBtnBlock();
    }
    

  

}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"init(coder:) has not been implemented");
    }
    return self;
}


@end
