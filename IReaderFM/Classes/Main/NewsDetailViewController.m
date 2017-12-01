//
//  NewsDetailViewController.m
//  IReaderFM
//
//  Created by tao song on 2017/8/17.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "TDevices.h"
#import "BaseResponse.h"
#import "UIImageView+WebCache.h"
#import "TBPlayer.h"


@interface NewsDetailViewController ()  <UIScrollViewDelegate>
@property (nonatomic, weak) TBPlayer *player;
@property (nonatomic,strong) UIScrollView  *dataScrollew;


@property (nonatomic, strong)  UILabel* titleLabel;
@property (nonatomic, strong)  UILabel* authorLabel;
@property (nonatomic, strong)  UILabel* speakerLabel;
@property (nonatomic, strong)  UILabel* durationLabel;
@property (nonatomic, strong)  UILabel* lookCountLabel;
@property (nonatomic,strong)   UILabel* descLabel;

@property (nonatomic, strong)  UIImageView* authorIcon;
@property (nonatomic, strong)  UIImageView* speakerIcon;
@property (nonatomic, strong)  UIImageView* durationIcon;


@property (nonatomic, strong)  UIImageView* pictureView;
@property (nonatomic,strong)   UIWebView  *contentWebView;
@property (nonatomic,strong)   UILabel   *contentLabel;

@property (nonatomic,strong)  NSMutableDictionary  *dictParams;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic,strong)  UIView  *playView;

@end

@implementation NewsDetailViewController

- (instancetype)init
{

    self = [super init];

    if (self) {
        
        
    }
    
    return self;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加等待动画
    _hud = [TDevices createHUD];
    _hud.userInteractionEnabled = NO;
    
    
    [self initView];
    [self layoutUI];
    
    [self fetchDetails];
   
}

- (void)initView
{
    
    self.view.clipsToBounds = YES;

    _dataScrollew = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _dataScrollew.delegate = self;
    self.automaticallyAdjustsScrollViewInsets=YES;
    [self.view addSubview:_dataScrollew];
    

    _titleLabel = [UILabel new];

    
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_titleLabel];
    
    
    UIImage *authorImag = [UIImage imageNamed:@"icon_author"];
    
    _authorIcon = [[UIImageView alloc] initWithImage:authorImag];
    [_authorIcon setContentMode:UIViewContentModeScaleAspectFill];
    [self.dataScrollew addSubview:_authorIcon];
    
    
    _authorLabel = [UILabel new];
    _authorLabel.numberOfLines = 0;
    [_authorLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _authorLabel.font = [UIFont systemFontOfSize:12];
    _authorLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_authorLabel];
    
    
    
    UIImage *speakerImag = [UIImage imageNamed:@"icon_speaker"];
    
    _speakerIcon = [[UIImageView alloc] initWithImage:speakerImag];
    [self.dataScrollew addSubview:_speakerIcon];
    
    _speakerLabel = [UILabel new];
    _speakerLabel.numberOfLines = 0;
    [_speakerLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _speakerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _speakerLabel.font = [UIFont systemFontOfSize:12];
    _speakerLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_speakerLabel];
    
    
    
    UIImage *durationImag = [UIImage imageNamed:@"icon_duration"];
    
    _durationIcon = [[UIImageView alloc] initWithImage:durationImag];
    [self.dataScrollew addSubview:_durationIcon];
    
    _durationLabel = [UILabel new];
    _durationLabel.numberOfLines = 0;
    [_durationLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _durationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _durationLabel.font = [UIFont systemFontOfSize:12];
    _durationLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_durationLabel];
    
    
    _lookCountLabel = [UILabel new];
    _lookCountLabel.numberOfLines = 0;
    [_lookCountLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _lookCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _lookCountLabel.font = [UIFont systemFontOfSize:12];
    _lookCountLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_lookCountLabel];

    
    _pictureView  = [UIImageView new];
    //[_pictureView setCornerRadius:5.0];
    [self.dataScrollew addSubview:_pictureView];

    
    _descLabel =  [UILabel new];
    _descLabel.numberOfLines = 3;
    [_descLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descLabel.font = [UIFont systemFontOfSize:12];
    _descLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_descLabel];
    
    
    _contentLabel =  [UILabel new];
    _contentLabel.numberOfLines = 0;
    [_contentLabel setTextAlignment:NSTextAlignmentCenter|NSTextAlignmentLeft];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = [UIColor blackTextColor];
    [self.dataScrollew addSubview:_contentLabel];
    
    
    
    _playView = [UIView new];
    [self.dataScrollew addSubview:_playView];

   
}


- (void)layoutUI
{

    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_dataScrollew.mas_top).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        
        
    }];
    
    
    [_authorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_dataScrollew.mas_left).offset(15);
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
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.lastBaseline.mas_equalTo(_durationLabel.mas_bottom);
        
    }];
    
    
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lookCountLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
    
        make.height.mas_offset(200);
    }];
    
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pictureView.mas_bottom).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        
        make.height.mas_offset(40);
    }];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        
      
        
        make.bottom.mas_equalTo(self.dataScrollew.mas_bottom).offset(10);
        
        

    
    }];
    
    
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(_pictureView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(10);
        make.bottom.mas_equalTo(_descLabel.mas_top);
    }];
    
    

}



- (void)setNewsInfo:(NewsInfo *)newsInfo
{
    _newsInfo = newsInfo;
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:newsInfo.imgUrl]];
    });
    
    self.titleLabel.text = newsInfo.title;
    self.authorLabel.text = newsInfo.textAuthor;
    self.speakerLabel.text = newsInfo.voiceAuthor;
    self.durationLabel.text =newsInfo.voiceTime;
    self.lookCountLabel.text = newsInfo.listenCount;
    
    
    _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.descLabel.numberOfLines = 0;
    
    _contentLabel.lineBreakMode =NSLineBreakByTruncatingTail;;
 
      self.descLabel.text = newsInfo.descs;
    self.contentLabel.numberOfLines = 0;
    [self loadNewsDetails:_newsInfo.content];
    
    NSURL *url2 = [NSURL URLWithString:newsInfo.voiceUrl];
    NSURL *url3 = url2;
    [[TBPlayer sharedInstance] playWithUrl:url3 showView:self.view];

}
    
    
    -(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
    {
        NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
        attrs[NSFontAttributeName]=font;
        
        CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
        return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }


- (void)fetchDetails
{
    _manager  = [AFHTTPRequestOperationManager CXManager];

   NSMutableDictionary *dict =  [ApiDict  newsDetailDictWithNewsId:_newsInfo.newsId];

   
    
    [_manager  POST:[TDevices getBaseUrlWithApi:FMAPI_NEWS_DETAIL] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *jsonStr =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
       
        NSDictionary  *jsonDict = [JSONTools parseJsonFromStringOrObject:jsonStr];
        
        
        BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:jsonDict];
        
        if (nil != baseResponse && baseResponse.success) {
            
            NSDictionary *data = baseResponse.data;
            
            NewsInfo  *newInfo = [[NewsInfo alloc] initWithObjectFormDict:data];
            
            if (nil !=newInfo && newInfo.content.length >0) {
                [_hud hideAnimated:YES];
                [self setNewsInfo:newInfo];
                

            }else {
                [TDevices showMesssageDialog:@"获取数据失败！"];
                [_hud hideAnimated:YES];
              
            }
            
            
        }else {
        
            [TDevices showMesssageDialog:@"获取数据失败！"];
            [_hud hideAnimated:YES];
            
                }

     
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
        [_hud hideAnimated:YES];
        
    }];



}
- (void)loadNewsDetails:(NSString *)htmlString
{
    
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _contentLabel.attributedText = attrStr;
 
    
    
   
   }


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_hud) {
        [_hud setHidden:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
