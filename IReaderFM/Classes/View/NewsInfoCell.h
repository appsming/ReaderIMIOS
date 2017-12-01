//
//  NewsInfoCell.h
//  IReaderFM
//
//  Created by tao song on 2017/8/13.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "NewsInfo.h"
#import "UIImageView+WebCache.h"

@interface NewsInfoCell : UITableViewCell

@property (nonatomic,strong) NewsInfo  *newsInfo;

@property (nonatomic, strong)  UIImageView* pictureView;
@property (nonatomic, strong)  UILabel* titleLabel;
@property (nonatomic, strong)  UILabel* authorLabel;
@property (nonatomic, strong)  UILabel* speakerLabel;
@property (nonatomic, strong)  UILabel* durationLabel;
@property (nonatomic, strong)  UILabel* lookCountLabel;

@property (nonatomic, strong)  UIImageView* authorIcon;
@property (nonatomic, strong)  UIImageView* speakerIcon;
@property (nonatomic, strong)  UIImageView* durationIcon;


@property (nonatomic, strong)  TTTAttributedLabel* detailLabel;


@property (nonatomic, strong)  UIButton* playButton;
@property (nonatomic, strong)  UIButton* moreButton;

+ (void)initContetTextView:(UITextView*)textView;
@end
