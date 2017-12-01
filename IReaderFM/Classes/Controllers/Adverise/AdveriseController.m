//
//  DSLaunchingController.m
//  WeiChat
//
//  Created by wangyang on 15/11/3.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "AdveriseController.h"
#import "TDevices.h"
@interface AdveriseController ()
@property (nonatomic,strong)UIImageView *launchImageView;

@property (nonatomic,strong) UIImage *launcherImage;
@end

@implementation AdveriseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.launchImageView];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    __weak typeof(self)weakSelf = self;
    [self.launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

- (BOOL)downLoadSource
{
  
    
    if ([TDevices haveIntent]) {
        
        
        
        NSString *path = @"http://img01.bqstatic.com/upload/activity/2016011111271981.jpg";
        
        [self downLoadPicWithUrl:path];
        
        
    } else {
        
        
        _launcherImage= [UIImage imageNamed:@"guide_40_1"];
        
        [self.launchImageView setImage:_launcherImage];
        
                if ([self.delegate respondsToSelector:@selector(adveriseControllerBack:)]) {
                  
                    [self.delegate adveriseControllerBack:self];
                }
    
    
    }
    
    return YES;
}



- (void)downLoadPicWithUrl:(NSString *)pPath
{
    
    
    NSString *picPath= pPath;
    
    NSURL *picUrl =  [NSURL URLWithString:picPath];
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:picUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        if (error != nil) {
            //加载广告失败
            NSLog(@"加载广告失败");
            _launcherImage = [UIImage imageNamed:@"guide_40_1"];
            [self.launchImageView setImage:_launcherImage];
            [NSThread sleepForTimeInterval:3.0];
            if ([self.delegate respondsToSelector:@selector(adveriseControllerBack:)]) {
                [self.delegate adveriseControllerBack:self];
            }
            return;
        }
        
        
        if (image != nil) {
            
            _launcherImage = image;
            [self.launchImageView setImage:_launcherImage];
            [NSThread sleepForTimeInterval:3.0];
            if ([self.delegate respondsToSelector:@selector(adveriseControllerBack:)]) {
                [self.delegate adveriseControllerBack:self];
            }
            
        }else {
            
            NSLog(@"加载广告失败");
            
            _launcherImage = [UIImage imageNamed:@"guide_40_1"];
            [self.launchImageView setImage:_launcherImage];
            [NSThread sleepForTimeInterval:3.0];
            if ([self.delegate respondsToSelector:@selector(adveriseControllerBack:)]) {
                [self.delegate adveriseControllerBack:self];
            }
        }
        

        
    }];

}




- (UIImageView *)launchImageView
{
    if (!_launchImageView) {
        _launchImageView = [[UIImageView alloc] init];
        if (INCH35) {
            _launchImageView.image = [UIImage imageNamed:@"guide_40_1"];
        }else if (INCH4) {
            _launchImageView.image = [UIImage imageNamed:@"guide_40_1"];
        }else if (INCH47) {
            _launchImageView.image = [UIImage imageNamed:@"guide_40_1"];
        }else {
            _launchImageView.image = [UIImage imageNamed:@"guide_40_1"];
        }
    }
    return _launchImageView;
}


@end
