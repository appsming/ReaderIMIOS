//
//  AppDelegate.m
//  IReaderFM
//
//  Created by tao song on 17/8/4.
//  Copyright © 2017年 com.wxkj. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

    @property (nonatomic,strong) MMDrawerController * drawerController;

    
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
     [self loadCookies];
     [self setLanguage];
     [self setAppSubject];
     [self requestCotalog];
    
    return YES;
}








- (void)setLanguage
{
    
    if (![CX_CurrentSystemTool readCurrentAppLanguage]) {
        NSString *language = [CX_CurrentSystemTool currentSysTemLanguage];
        [CX_CurrentSystemTool saveSetLanguage:language];
        NSLog(@"======set===%@",language);
    }
    
}


- (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
}



- (void)setAppSubject
{
    
    /************ 控件外观设置 **************/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [UISearchBar appearance].tintColor = [UIColor orangeColor];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setCornerRadius:14.0];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAlpha:0.6];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
    
    [[UITextField appearance] setTintColor:[UIColor blackTextColor]];
    [[UITextView appearance]  setTintColor:[UIColor blackTextColor]];
    

}



- (void)buildKeyWindow
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCatalogNotice object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    if ([CX_AppStartState isFirstStart]) {//登录页
        GuideController *guideVC = [[GuideController alloc] init];
        
        self.window.rootViewController = guideVC;
        
        [self.window makeKeyAndVisible];
        
        
    }else {
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        
        MainViewController  *mainViewController = [[MainViewController alloc] init];
        
        mainViewController.title = app_Name;
        
        UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        
        centerNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        centerNav.navigationBar.tintColor = [UIColor whiteColor];
        centerNav.navigationBar.barTintColor = [UIColor navigationbarColor];
        [centerNav.view setBackgroundColor:[UIColor themeColor]];
        
        LeftMenuController  *leftMenuController = [[LeftMenuController alloc] init];
        
         self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerNav leftDrawerViewController:leftMenuController];
        
        
        [self.drawerController setShadowRadius:0.8f];
        
        [self.drawerController.view setBackgroundColor:[UIColor themeColor]];
        [self.drawerController setShowsShadow:YES];
        [self.drawerController setMaximumLeftDrawerWidth:ScreenWidth-kSliderWidth];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [[MMExampleDrawerVisualStateManager sharedManager]
                     drawerVisualStateBlockForDrawerSide:drawerSide];
            if(block){
                block(drawerController, drawerSide, percentVisible);
            }
            
        }];//侧滑效果
        
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window setRootViewController:self.drawerController];

        
        
        
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        
        
        
        
        
    }
}


- (void)requestCotalog
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buildKeyWindow) name:kCatalogNotice object:nil];
    
    
    if (![TDevices haveIntent]) {
        
        [TDevices showMesssageDialog:NO_WAN_CONNECT];
        
        [NSThread sleepForTimeInterval:5*1000];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kCatalogNotice object:nil];
    }else {

        NSDictionary *catalogDict = [ApiDict catalogDictOnInit];
        
        
    AFHTTPRequestOperationManager  *manager = [AFHTTPRequestOperationManager CXManager];

    [manager POST:[TDevices getBaseUrlWithApi:FMAPI_NEWS_CATALOG] parameters:catalogDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *jsonStr =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"=====jsonStr==========%@",jsonStr);
        
        NSDictionary  *jsonDict = [JSONTools parseJsonFromStringOrObject:jsonStr];
        
        
        BaseResponse  *baseResponse = [[BaseResponse alloc] initWithObjectFormDict:jsonDict];
        
        if (nil != baseResponse && baseResponse.success) {
            
            NSDictionary *data = baseResponse.data;
            
              NSMutableArray *catalogAry =    [ApiParseModel  parseCatalogListinfoWithJsonDict:data];
 
            if (catalogAry.count >0) {
            
                [TDevices setCatalogAry:[JSONTools dictToJsonString:data]];
            }
          
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kCatalogNotice object:nil];
        
            
        }else {
        
         [[NSNotificationCenter defaultCenter] postNotificationName:kCatalogNotice object:nil];
        }
        
       
        
        
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             [[NSNotificationCenter defaultCenter] postNotificationName:kCatalogNotice object:nil];
        }];

    }


}







- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
