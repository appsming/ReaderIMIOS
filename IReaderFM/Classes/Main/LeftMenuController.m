

#import "LeftMenuController.h"
#import "TDevices.h"
#import "LoginViewController.h"
#import "MyCareViewController.h"
#import "MyPariseViewController.h"
#import "MyBasicInfoViewController.h"
#import "MyCollectionViewController.h"
#import "AboutMeViewController.h"
#import "FeedBackViewController.h"
#import "ShareViewController.h"
#import "SettingsViewController.h"
#import "UIViewController+MMDrawerController.h"
@interface LeftMenuController ()  <UITableViewDelegate,UITableViewDataSource>
    
    @property (nonatomic,strong) UITableView *sliderTableView;
    
    @property (nonatomic,strong) NSArray *menuAry;
    @property (nonatomic,strong) NSArray *iconAry;
    @property (nonatomic,strong) NSDictionary *myDict;
    
    @end

@implementation LeftMenuController
    
    
    
- (void)initData
    {
        
        NSString  *collectionStr = DSLocalizedString(@"slider_user_collection", nil);
        
        NSString  *careStr = DSLocalizedString(@"slider_user_care", nil);
        
        NSString  *pariseStr = DSLocalizedString(@"slider_user_parise", nil);
        
        NSString  *feedbackStr = DSLocalizedString(@"slider_user_feedback", nil);
        
        NSString  *shareStr = DSLocalizedString(@"slider_user_share", nil);
        
        NSString  *setStr = DSLocalizedString(@"slider_user_set", nil);
        
        NSString  *aboutStr = DSLocalizedString(@"slider_user_about", nil);
        
        
        _menuAry = @[@[collectionStr, careStr, pariseStr], @[feedbackStr, shareStr],@[setStr,aboutStr]];
        
        _iconAry = @[@[@"more_collect",@"more_praise",@"more_attention"],@[@"more_idea",@"more_share"],@[@"more_update",@"more_about_us"]];
        
        
    }
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}
    
- (void)initView
    {
        
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-kSliderWidth, ScreenHeight) style:UITableViewStyleGrouped];
        tableview.dataSource = self;
        tableview.delegate  = self;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.backgroundColor = [UIColor themeColor];
        [self.view addSubview:tableview];
        
    }
    
    
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackTextColor];
    
    NSString  *iconName  = _iconAry[indexPath.section][indexPath.row];
    NSString *title  =  _menuAry[indexPath.section][indexPath.row];
    
    [cell.textLabel setText:title];
    cell.imageView.image = [UIImage imageNamed:iconName];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    
    
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UITableViewCell *cell =  [tableView  cellForRowAtIndexPath:indexPath];
        
        
        
        NSInteger section = indexPath.section;
        
        NSInteger row = indexPath.row;
        
        
        if (section == 0) {
            
            switch (row) {
                case 0:{
                    
                    MyCollectionViewController  *myCollectionVC = [[MyCollectionViewController alloc] init];
                    myCollectionVC.title= cell.textLabel.text;
                    [self setContentViewController:myCollectionVC];
                    break;
                }
                case 1:{
                    
                    MyPariseViewController  *myPariseVC = [[MyPariseViewController alloc] init];
                    myPariseVC.title= cell.textLabel.text;
                    [self setContentViewController:myPariseVC];
                    break;
                }
                
                case 2:{
                    
                    MyCareViewController  *myCareVC = [[MyCareViewController alloc] init];
                    myCareVC.title= cell.textLabel.text;
                    [self setContentViewController:myCareVC];
                    break;
                }
                
                default:
                break;
            }
            
            
        }else if(section == 1){
            
            switch (row) {
                case 0:{
                    
                    FeedBackViewController  *feedBackVC = [[FeedBackViewController alloc] init];
                    feedBackVC.title= cell.textLabel.text;
                    [self setContentViewController:feedBackVC];
                    break;
                }
                case 1:{
                    
                    ShareViewController  *shareVC = [[ShareViewController alloc] init];
                    shareVC.title= cell.textLabel.text;
                    [self setContentViewController:shareVC];
                    break;
                }
            }
            
            
        }else if(section == 2){
            
            switch (row) {
                case 0:{
                    
                    SettingsViewController  *settingsVC = [[SettingsViewController alloc] init];
                    settingsVC.title= cell.textLabel.text;
                    [self setContentViewController:settingsVC];
                    break;
                }
                
                
                case 1:{
                    
                    AboutMeViewController  *aboutVC = [[AboutMeViewController alloc] init];
                    aboutVC.title= cell.textLabel.text;
                    [self setContentViewController:aboutVC];
                    break;
                }
            }
            
            
        }
        
        
    }
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
        if (section == 0) {
            return 180.0f;
        }else {
            
            return 10;
        }
    }
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    {
        
        if (section == 0) {
            
            
            UIView *headerView = [[UIView alloc] init];
            
            headerView.backgroundColor = [UIColor clearColor];
            
            UIImageView *avatorImgView = [[UIImageView alloc] init];
            
            avatorImgView.contentMode = UIViewContentModeScaleAspectFit;
            
            //  [avatorImgView setCornerRadius:30];
            
            avatorImgView.userInteractionEnabled = YES;
            
            avatorImgView.translatesAutoresizingMaskIntoConstraints = NO;
            
            [headerView addSubview:avatorImgView];
            
            [avatorImgView setImage:[UIImage imageNamed:@"header_avathor"]];
            
            
            
            UILabel *nameLabel = [UILabel new];
            nameLabel.text = [NSString stringWithFormat:@"%@%@",DSLocalizedString(@"slider_user_nickname", nil),@"小老儿"];
            nameLabel.font = [UIFont systemFontOfSize:16];
            
            nameLabel.textColor = [UIColor blackColor];
            
            nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [headerView addSubview:nameLabel];
            
            NSDictionary *views = NSDictionaryOfVariableBindings(avatorImgView, nameLabel);
            NSDictionary *metrics = @{@"x": @([UIScreen mainScreen].bounds.size.width / 4 - 15)};
            [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[avatorImgView(90)]-15-[nameLabel]-15-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
            [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-x-[avatorImgView(90)]" options:0 metrics:metrics views:views]];
            
            nameLabel.userInteractionEnabled = YES;
            [avatorImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushLoginPage)]];
            [nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushLoginPage)]];
            
            
            [headerView setBackgroundColor:[UIColor orangeColor]];
            
            return headerView;
            
        }else {
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 10)];
            view.backgroundColor = [UIColor clearColor];
            return view ;
            
        }
        
        
        
    }
    
    
    
    //section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
    {
        return 1;
    }
    
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return _menuAry.count;
        
    }
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return  3;
    }else if(section == 1){
        
        return 2;
    }else {
        
        return 2;
    }
    
    
}
    
    
    
    
    // 判断是否login
- (void)pushLoginPage
    {
        if (self.myDict) {
            
            
            
            
            MyBasicInfoViewController *myBaseInfoView =  [MyBasicInfoViewController new];
            [self setContentViewController:myBaseInfoView];
            
        }else {
            
            
            [self showMesssageDialog:DSLocalizedString(@"no_login_tologin", nil) andAlertTag:10000];
            
        }
    }
    
    
- (void)setContentViewController:(UIViewController *)viewController
    {
        viewController.hidesBottomBarWhenPushed = YES;
        UINavigationController *nav = (UINavigationController *)self.self.mm_drawerController.centerViewController;
        
        [nav pushViewController:viewController animated:NO];
        
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    
    
- (void)showMesssageDialog:(NSString *)msg andAlertTag:(NSInteger)tag
    {
        
        NSString *title =DSLocalizedString(@"dialog_title", nil);
        // NSString *cancelButtonTitle = DSLocalizedString(@"ip_dialog_cancle", nil);
        NSString *destructiveButtonTitle = DSLocalizedString(@"ip_dialog_ok", nil);
        
        
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:destructiveButtonTitle, nil];
        alter.tag = tag;
        [alter show];
    }
    
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        
        NSInteger tag =    alertView.tag;
        
        switch (tag) {
            case 10000:{
                
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                [self setContentViewController:loginVC];
                break;
            }
        }
    }
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
    
    
    
    
    
    @end
