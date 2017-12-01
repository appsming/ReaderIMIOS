//
//  CarsListViewController.m
//  CarTrace
//
//  Created by tao song on 17/7/28.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "MainViewController.h"
#import "NewsInfoCell.h"
#import <objc/runtime.h>
#import "NewsDetailViewController.h"
#import "UIViewController+MMDrawerController.h"
#import <objc/runtime.h>


static NSString * const kCarCellID = @"CarCell";
static Reachability *reachability;
static const char kRepresentedObject;

@interface MainViewController ()

@end

@implementation MainViewController {
    
    NSArray        *titleArr;
    
    UIView         *_moveView;
    NSMutableArray *_btnArr;
    
    NSMutableArray *_totalArray;
    NSMutableArray *_tableArray;
    NSMutableArray *_nothingArray;
    
    UIScrollView   *_scrollView;
    NSMutableArray  *requestAry;
    NSMutableArray  *requestManagerAry;
    Boolean            isFirst;
    
    
    
    NSInteger       pageIndex;
    
    NSInteger       pageSize;
    
    NSInteger       pageCount;
    
    
    
    
}

- (instancetype)init
{
    
    self  =  [super init];
    
    if (self) {
        UIBarButtonItem  *searchBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchViewController)];
        
         UIBarButtonItem  *switchBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu_black_24dp"] style:UIBarButtonItemStylePlain target:self action:@selector(switchSliderBar)];
        
        self.navigationItem.rightBarButtonItem  = searchBarButtonItem;
        
        self.navigationItem.leftBarButtonItem = switchBarButtonItem;
    }
    
    return self;
    
}

- (void)switchSliderBar
{
 [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

    
    
- (void)searchViewController
{
    [TDevices showMesssageDialog:@"暂未开放！"];
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
   
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

}


- (void)initView
{
       self.view.clipsToBounds = YES;
     [self.view setBackgroundColor:[UIColor themeColor]];
    UIView *segView = [[UIView alloc] initWithFrame:CGRectMake(0, NaviHeight, ScreenWidth, 42)];
    segView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segView];
    
    requestManagerAry = [[NSMutableArray alloc] init];
    _btnArr = [[NSMutableArray alloc] init];
    
    

    
    
    NSDictionary *catalogDict =  [JSONTools parseJsonFromStringOrObject: [TDevices getCatalogJson]];
    
    titleArr = [ApiParseModel parseCatalogListinfoWithJsonDict:catalogDict];
    
    for (int i = 0; i < titleArr.count; i ++) {
          CatalogInfo  *catalogInfo =[titleArr objectAtIndex:i];
        
        UIButton *btn = [self creatMyBtn:CGRectMake(ScreenWidth / titleArr.count * i, 0, ScreenWidth / titleArr.count, 42) aview:segView tag:i];
        [btn setTitle:catalogInfo.catalogName forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        if (i == 0) {
            [btn setTitleColor:[UIColor colorWithHexString:XIAN_BLUE] forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
        }
        [segView addSubview:btn];
        [_btnArr addObject:btn];
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 12, LINE_HEIGHT, segView.frame.size.height - 24)];
            line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            [btn addSubview:line];
        }
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, ScreenWidth, LINE_HEIGHT)];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [segView addSubview:line];
    
    _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth / titleArr.count, 2)];
    _moveView.backgroundColor = [UIColor colorWithHexString:XIAN_BLUE];
    [segView addSubview:_moveView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segView.frame.origin.y + segView.frame.size.height, ScreenWidth, ScreenHeight - segView.frame.origin.y - segView.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * titleArr.count, _scrollView.frame.size.height);
   
    
    _totalArray = [[NSMutableArray alloc] init];
    _tableArray = [[NSMutableArray alloc] init];
    _nothingArray = [[NSMutableArray alloc] init];
    NSMutableArray *nothingsArray = [[NSMutableArray alloc] init];
    requestAry  = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < _btnArr.count; i++) {
        NSString *errorOutMsg = DSLocalizedString(@"tip_message_error_out", nil);
        
        NSMutableArray *daijieArr = [[NSMutableArray alloc] init];
        [_totalArray addObject:daijieArr];
        [nothingsArray addObject:errorOutMsg];
        [requestAry addObject:@(NO)];
    }
    
    for (int i = 0; i < nothingsArray.count; i ++) {
        PullTableView *tableView = [[PullTableView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.pullDelegate = self;
        [_scrollView addSubview:tableView];
        //  tableView.hasLoadAll = YES;
        //   tableView.loadMoreView.alpha = 0;
        
        [tableView registerClass:[NewsInfoCell class]  forCellReuseIdentifier:kCarCellID];
        UITextView  *_textView = [[UITextView alloc] initWithFrame:CGRectZero];
        [NewsInfoCell initContetTextView:_textView];
        
        
        UIView *kongView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        tableView.tableFooterView = kongView;
        [_tableArray addObject:tableView];
        
        UILabel *nothingLab = [self creatMyLabel:nothingsArray[i] frame:CGRectMake(20, 100, ScreenWidth - 40, 50) afloat:13 aview:tableView withColorStr:@"a6a6a7"];
        nothingLab.numberOfLines = 0;
        nothingLab.textAlignment = NSTextAlignmentCenter;
        nothingLab.alpha = 0;
        [_nothingArray addObject:nothingLab];
    }
    
    UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(0, NaviHeight, 8, ScreenHeight - NaviHeight)];
    panView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:panView];
    
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        if (![requestAry[0] boolValue]) {
            [self refreshDataWithIndex:0];
        }
    });
    
   
    
}


#pragma mark - PullTableViewDelagate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView {
    
    reachability = [Reachability reachabilityWithHostName:KAppleUrl];
    
    if (reachability.currentReachabilityStatus == 0) {
        
        [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
        
        NSString *meesage = DSLocalizedString(@"tips_message_errorwork", nil);
        
        [TDevices showMesssageDialog: meesage ];
        
        
        return;
        
    }
    
    
    
    for (int i = (int)requestManagerAry.count - 1; i >= 0; i --) {
        MMRequestManager *manager = [requestManagerAry objectAtIndex:i];
        if (manager.tag == pullTableView.tag) {
            manager.delegate = nil;
            [requestManagerAry removeObject:manager];
        }
    }
    
    
    CatalogInfo  *catalogInfo =[titleArr objectAtIndex:(int)pullTableView.tag];

    pageIndex = 1 ;
    pageSize = 15;
    
    NSString *keyType = catalogInfo.catalogId;
    
    if (keyType.length >0) {
         NSMutableDictionary  *dict =  [ApiDict newsListDictWithPageNo:pageIndex andPageSize:pageSize andkeyType:keyType];
        
        
        
        MMRequestManager *manager = [[MMRequestManager alloc] init];
        manager.tag = (int)pullTableView.tag;
        [requestManagerAry addObject:manager];
        
        [manager startRequestDeletate:self urlString:[TDevices
                                                      getBaseUrlWithApi:FMAPI_NEWS_LIST] parameters:dict andHttpType:HttpRequestTypeCommon];
        
    }else {
    
        [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
        
        NSString *meesage = DSLocalizedString(@"tips_message_errorwork", nil);
        
        [TDevices showMesssageDialog: meesage ];
    }

}




- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView {
    reachability = [Reachability reachabilityWithHostName:KAppleUrl];
    
    if (reachability.currentReachabilityStatus == 0) {
        
        [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
        NSString *meesage = DSLocalizedString(@"tips_message_errorwork", nil);
        
        [TDevices showMesssageDialog: meesage ];
        
        
        return;
        
    }
    
    
    
    for (int i = (int)requestManagerAry.count - 1; i >= 0; i --) {
        MMRequestManager *manager = [requestManagerAry objectAtIndex:i];
        if (manager.tag == pullTableView.tag) {
            manager.delegate = nil;
            [requestManagerAry removeObject:manager];
        }
    }
    
    
    CatalogInfo  *catalogInfo =[titleArr objectAtIndex:(int)pullTableView.tag];
    
     ++pageIndex;
    pageSize = 15;
    
    NSString *keyType = catalogInfo.catalogId;
    
    if (pageIndex < pageCount) {
        if (keyType.length >0) {
            NSMutableDictionary  *dict =  [ApiDict newsListDictWithPageNo:pageIndex andPageSize:pageSize andkeyType:keyType];
            
            
            
            MMRequestManager *manager = [[MMRequestManager alloc] init];
            manager.tag = (int)pullTableView.tag;
            [requestManagerAry addObject:manager];
            
            [manager startRequestDeletate:self urlString:[TDevices
                                                          getBaseUrlWithApi:FMAPI_NEWS_LIST] parameters:dict andHttpType:HttpRequestTypeCommon];
            
        }else {
            
            [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
            
            //NSString *meesage = DSLocalizedString(@"tips_message_errorwork", nil);
            
           // [TDevices showMesssageDialog: meesage ];
        }
        
    }else {
    
        
        [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%d", (int)pullTableView.tag] afterDelay:0.3];
    }
    
    


    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}



#pragma mark - DDRequestManagerDelegate
- (void)didGetCommonSuccess:(MMRequestManager *)manager infoDic:(NSDictionary *)dictJson andManagerTag:(NSInteger)tag{
  
    NSLog(@"=========didGetCommonSuccess================%@",dictJson);
    
     BaseNewsInfo  *baseEntity = [[BaseNewsInfo alloc] initWithObjectFormDict:dictJson];
     NSMutableArray  *carsArry = [[NSMutableArray alloc] init];
    if (baseEntity !=nil &&  baseEntity.success) {
         pageCount  = baseEntity.pageCount;
     carsArry = [ApiParseModel parseNewsListinfoWithJsonDict:baseEntity.list];
        
    }
    
    
    UILabel *nothingLab = [_nothingArray objectAtIndex:tag];
    nothingLab.alpha = 1;
    PullTableView *tableView = [_tableArray objectAtIndex:tag];
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tag];
    
    if (!tableView.pullTableIsLoadingMore) {
        [dataArray removeAllObjects];
        if (carsArry.count > 0) {
            [dataArray addObjectsFromArray:carsArry];
        }
        [tableView reloadData];
    } else if (carsArry.count > 0) {
        NSMutableArray *insertArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < carsArry.count; i ++) {
            [insertArr addObject:[NSIndexPath indexPathForRow:dataArray.count + i inSection:0]];
        }
        [dataArray addObjectsFromArray:carsArry];
        [tableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if (pageIndex < pageSize) {
        tableView.hasLoadAll = NO;
    } else {
        tableView.hasLoadAll = YES;
    }
    
    
    [self doneFinish:[NSString stringWithFormat:@"%ld", tag]];
    
    
    if ([requestManagerAry containsObject:manager]) {
        [requestManagerAry removeObject:manager];
    }
    
  }



- (void)didGetCommonFail:(MMRequestManager *)manager errorStr:(NSString *)errorStr andManagerTag:(NSInteger)tag{
    [TDevices showMesssageDialog:errorStr];
    [self performSelector:@selector(doneFinish:) withObject:[NSString stringWithFormat:@"%ld", tag] afterDelay:0.3];
    
    
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tableView.tag];
    UILabel *nothingLab = [_nothingArray objectAtIndex:tableView.tag];
    if (dataArray.count == 0) {
        nothingLab.hidden = NO;
    } else {
        nothingLab.hidden = YES;
    }
    return dataArray.count;
}

//- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 100;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PullTableView *myTableView = [_tableArray objectAtIndex:tableView.tag];
    NSMutableArray *dataArray = [_totalArray objectAtIndex:tableView.tag];
    
    
    NewsInfoCell *cell = [myTableView dequeueReusableCellWithIdentifier:kCarCellID forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[NewsInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCarCellID];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
 
     NewsInfo  *software = dataArray[indexPath.row];
    
    cell.newsInfo= software;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      NSMutableArray *dataArray = [_totalArray objectAtIndex:tableView.tag];
     NewsInfo  *software = dataArray[indexPath.row];
    
    NewsDetailViewController *newDetailVC =  [[NewsDetailViewController alloc] init];
    newDetailVC.title = DSLocalizedString(@"news_title_detail", nil);
    [newDetailVC setNewsInfo:software];
   [self.navigationController pushViewController:newDetailVC animated:YES];

   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




// 事件
- (void)btnClick:(UIButton *)btn {
    if (![requestAry[btn.tag] boolValue]) {
        [self refreshDataWithIndex:(int)btn.tag];
    }
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(btn.frame.origin.x * _btnArr.count, 0);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        
        _moveView.center = CGPointMake((_scrollView.contentOffset.x + ScreenWidth / 2) / _btnArr.count, _moveView.center.y);
        int index = (scrollView.contentOffset.x + ScreenWidth / 2) / ScreenWidth;
      

        for (int i = 0; i < _btnArr.count; i ++) {
            UIButton *btn = [_btnArr objectAtIndex:i];
            if (i == index) {
                [btn setTitleColor:[UIColor colorWithHexString:XIAN_BLUE] forState:UIControlStateNormal];
            } else {
                [btn setTitleColor:[UIColor colorWithHexString:@"777777"] forState:UIControlStateNormal];
            }
        }
        if (index > 0 && !requestAry[index - 1] && index * ScreenWidth - scrollView.contentOffset.x > 20) {
            [self refreshDataWithIndex:index - 1];
        }
        if (!requestAry[index + 1] && scrollView.contentOffset.x - index * ScreenWidth > 20) {
            [self refreshDataWithIndex:index + 1];
        }
    }
}




- (void)refreshDataWithIndex:(int)index {
    [requestAry insertObject:@(YES) atIndex:index];
    if (index < _tableArray.count) {
        PullTableView *tableView = [_tableArray objectAtIndex:index];
        tableView.pullTableIsRefreshing = YES;
    }
}

- (void)doneFinish:(NSString *)tagIndex {
    int index = [tagIndex intValue];
    PullTableView *tableView = [_tableArray objectAtIndex:index];
    tableView.pullTableIsRefreshing = NO;
    tableView.pullTableIsLoadingMore = NO;
    //    tableView.hasLoadAll = YES;
    //    tableView.loadMoreView.alpha = 0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

        
        return 1;


    
}

- (UILabel *)creatMyLabel:(NSString *)text frame:(CGRect)frame afloat:(CGFloat)afloat aview:(UIView *)aview  withColorStr:(NSString *)colorStr {
    UILabel *myLabel = [[UILabel alloc] initWithFrame:frame];
    myLabel.text = text;
    myLabel.backgroundColor = [UIColor clearColor];
    if (colorStr) {
        myLabel.textColor = [UIColor colorWithHexString:colorStr];
    } else {
        myLabel.textColor = [UIColor colorWithWhite:0 alpha:0.85];
    }
    myLabel.font = [UIFont systemFontOfSize:afloat];
    if (aview) {
        [aview addSubview:myLabel];
    }
    return  myLabel;
}





- (UIButton *)creatMyBtn:(CGRect)frame aview:(UIView *)aview tag:(int)tag {
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = frame;
    [headerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    headerBtn.tag = tag;
    if (aview) {
        [aview addSubview:headerBtn];
    }
    return headerBtn;
}


@end
