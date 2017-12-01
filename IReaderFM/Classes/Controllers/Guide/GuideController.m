/******************************************************************************
 版权所有 :  此文件版权归深圳市世纪畅行科技有限公司
 文件名称  :    GuideController.m
 文件作用描述  : 系统初次启动显示图片指南，引导用户使用
 文件创建人 :    明邦良
 文件创建时间 :   16-12-2
 文件修改人 :
 文件修改时间 :
 修改描述 :
 备注     :
 ******************************************************************************/




#import "GuideController.h"
#import "GuideCell.h"
#import "AppConfig.h"
#import "AppDelegate.h"

static NSString   *cellIdentifier = @"GuideCell";

@interface GuideController() <UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    UICollectionView  *collectionView;
    
    NSArray  *imageNames;
    
    UIPageControl *pageController;
    
    Boolean  isHiddenNextButton ;
    
}



@end

@implementation GuideController






- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self initView];
    
    [self buildCollectionView];
    
    [self  buildPageController];
}


- (void)initView
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    imageNames = @[@"guide_40_1", @"guide_40_2", @"guide_40_3"];
    isHiddenNextButton = YES;
    pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(0,  ScreenHeight - 50, ScreenWidth, 20)];
    
}


- (void)buildCollectionView
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = ScreenBounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collectionView = [[UICollectionView alloc]initWithFrame:ScreenBounds collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    
    [collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [self.view addSubview:collectionView];
    
}


- (void)buildPageController
{
    
    pageController.numberOfPages = imageNames.count;
    pageController.currentPage = 0;
    [self.view addSubview:pageController];
    
}


#pragma marker



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuideCell *cell = (GuideCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *image = imageNames[indexPath.row];
    
    [cell setNewImageCell:[UIImage imageNamed:image]];
    
    if (indexPath.row != imageNames.count - 1 ) {
        //  [cell setNextButtonHidden:YES];
        [cell.nextButtons setHidden:YES];
    }
    
    
    return cell;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    
    return [imageNames count];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    
    NSIndexPath  *path = [NSIndexPath indexPathForRow:imageNames.count -1  inSection:0];
    
    GuideCell  *cell = (GuideCell *)[collectionView  cellForItemAtIndexPath:path];
    
    //  [cell setNextButtonHidden:NO];
    isHiddenNextButton = YES;
    
    [cell.nextButtons setHidden:NO];
    
    cell.tryToUserBtnBlock = ^{
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        
        MainViewController  *mainViewController = [[MainViewController alloc] init];
        
        mainViewController.title = app_Name;
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        
        
        
        LeftMenuController  *leftMenuController = [[LeftMenuController alloc] init];
        
       
        
    };
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x != ScreenWidth * (CGFloat)imageNames.count - 1 && !isHiddenNextButton && scrollView.contentOffset.x > ScreenWidth * (CGFloat)imageNames.count - 2) {
        
        NSIndexPath  *path = [NSIndexPath indexPathForRow:imageNames.count -1  inSection:0];
        
        GuideCell  *cell = (GuideCell *)[collectionView  cellForItemAtIndexPath:path];
        
        [cell.nextButtons setHidden:YES];
        
        isHiddenNextButton = YES;
    }
    
    pageController.currentPage = (int)(scrollView.contentOffset.x / ScreenWidth + 0.5);
    
    
    
}





@end
