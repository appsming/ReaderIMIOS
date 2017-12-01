//
//  MainViewController.h
//  IReaderFM
//
//  Created by tao song on 2017/8/10.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiParseModel.h"
#import "PullTableView.h"


@interface MainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, PullTableViewDelegate,MMRequestManagerDelegate, UIScrollViewDelegate,UIAlertViewDelegate>
@end
