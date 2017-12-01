//
//  PersonCell.m
//  iosapp
//
//  Created by ChanAetern on 1/7/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "NewsInfoCell.h"
#import "TDevices.h"

@implementation NewsInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor themeColor];
        
        [self initSubviews];
        [self setLayout];
        
        UIView *selectedBackground = [UIView new];
        selectedBackground.backgroundColor = [UIColor colorWithHex:0xF5FFFA];
        [self setSelectedBackgroundView:selectedBackground];
    }
    
    return self;
}

#pragma mark - class methods

+ (void)initContetTextView:(UITextView*)textView
{
    textView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont boldSystemFontOfSize:15.0];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    [textView setTextContainerInset:UIEdgeInsetsZero];
    textView.textContainer.lineFragmentPadding = 0;
    textView.linkTextAttributes = @{
                                    NSForegroundColorAttributeName: [UIColor blackTextColor],
                                    NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)
                                    };
}


- (void)initSubviews
{
    
    _pictureView  = [UIImageView new];
    _pictureView.contentMode = UIViewContentModeScaleAspectFill;
    [_pictureView setCornerRadius:5.0];
    [self addSubview:_pictureView];

    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
  
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.font = [UIFont boldSystemFontOfSize:12];
    _titleLabel.textColor = [UIColor blackTextColor];
    [self addSubview:_titleLabel];
    
    
    UIImage *authorImag = [UIImage imageNamed:@"icon_author"];
    
    _authorIcon = [[UIImageView alloc] initWithImage:authorImag];
    [_authorIcon setContentMode:UIViewContentModeScaleAspectFill];
      [self addSubview:_authorIcon];
    
    
    _authorLabel = [UILabel new];
    _authorLabel.numberOfLines = 0;
    [_authorLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _authorLabel.font = [UIFont systemFontOfSize:10];
    _authorLabel.textColor = [UIColor blackTextColor];
    [self addSubview:_authorLabel];
    
    
    
    UIImage *speakerImag = [UIImage imageNamed:@"icon_speaker"];
    
    _speakerIcon = [[UIImageView alloc] initWithImage:speakerImag];
    [self addSubview:_speakerIcon];
    
    _speakerLabel = [UILabel new];
    _speakerLabel.numberOfLines = 0;
    [_speakerLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _speakerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _speakerLabel.font = [UIFont systemFontOfSize:10];
    _speakerLabel.textColor = [UIColor blackTextColor];
    [self addSubview:_speakerLabel];
 
    
    
    UIImage *durationImag = [UIImage imageNamed:@"icon_duration"];
    
    _durationIcon = [[UIImageView alloc] initWithImage:durationImag];
    [self addSubview:_durationIcon];
    
    _durationLabel = [UILabel new];
    _durationLabel.numberOfLines = 0;
      [_durationLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _durationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _durationLabel.font = [UIFont systemFontOfSize:10];
    _durationLabel.textColor = [UIColor blackTextColor];
    [self addSubview:_durationLabel];
    
    
    _lookCountLabel = [UILabel new];
    _lookCountLabel.numberOfLines = 0;
    [_lookCountLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _lookCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _lookCountLabel.font = [UIFont systemFontOfSize:10];
    _lookCountLabel.textColor = [UIColor blackTextColor];
    [self addSubview:_lookCountLabel];
    
    
    
    
    _detailLabel = [TTTAttributedLabel new];
    _detailLabel.numberOfLines = 3;
   // _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _detailLabel.font = [UIFont systemFontOfSize:10];
    _detailLabel.textColor = [UIColor blackTextColor];
      [self addSubview:_detailLabel];
    
  
    
    
    _playButton = [UIButton new];
    _playButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _playButton.titleLabel.textColor = [UIColor blackTextColor];
     [self addSubview:_playButton];
}

- (void)setLayout
{

    UIView  *cellView =    self;
    
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(cellView.mas_top).offset(5);
        
        make.left.mas_equalTo(cellView.mas_left).offset(10);
        
        make.height.mas_equalTo(@80);
        
        make.width.mas_equalTo(@80);
        
        
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.top.mas_equalTo(cellView.mas_top).offset(5);
        make.left.mas_equalTo(_pictureView.mas_right).offset(15);
        make.right.mas_equalTo(cellView.mas_right);
       
        
    }];
    
    
    [_authorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_pictureView.mas_right).offset(15);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_authorIcon.mas_right).offset(2);
        make.lastBaseline.mas_equalTo(_authorIcon.mas_bottom);

    }];
    
    
    [_speakerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_authorLabel.mas_right).offset(15);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [_speakerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_speakerIcon.mas_right).offset(2);
        make.lastBaseline.mas_equalTo(_speakerIcon.mas_bottom);
        
    }];
    
    
    [_durationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_speakerLabel.mas_right).offset(15);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_durationIcon.mas_right).offset(2);
        make.lastBaseline.mas_equalTo(_durationIcon.mas_bottom);
        
    }];
    
    
    [_lookCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
     //   make.left.mas_equalTo(_durationLabel.mas_right).offset(2);
        make.right.mas_equalTo(cellView.mas_right).offset(-15);
        make.lastBaseline.mas_equalTo(_durationLabel.mas_bottom);
        
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_lookCountLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_pictureView.mas_right).offset(15);
        make.right.mas_equalTo(cellView.mas_right).offset(-5);
        make.lastBaseline.mas_equalTo(_pictureView.mas_bottom);
        
    }];
    

}




- (void)setNewsInfo:(NewsInfo *)newsInfo
{
    _newsInfo = newsInfo;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:newsInfo.imgUrl]];
    self.titleLabel.text = newsInfo.title;
    self.authorLabel.text = newsInfo.textAuthor;
    self.speakerLabel.text = newsInfo.voiceAuthor;
    self.durationLabel.text =newsInfo.voiceTime;
    self.lookCountLabel.text = newsInfo.listenCount;
    self.detailLabel.text = newsInfo.descs;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
