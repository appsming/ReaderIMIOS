//
//  DS_LanguageController.m
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//  目前只支持简体中文、繁体中文（香港、台湾）三种国际化

#import "LanguageController.h"


@interface LanguageController () {
    NSDictionary *_languageDict;
}
@property (nonatomic,strong)UINavigationBar *navigationBar;
@property (nonatomic,copy)NSString *selectedLanguageType;
@property (nonatomic,strong)UILabel *rightItemLabel;
@end

@implementation LanguageController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationBar];
    [self obtainData];
    [self setNavigationBarItem];
    _selectedLanguageType = [CX_CurrentSystemTool readCurrentAppLanguage];
    [self tableViewCellBlock:^(UITableView *tableView,UITableViewCell *cell, NSIndexPath *indexPath, NSString *model) {
        CXLanguageCell *cells = (CXLanguageCell *)cell;
        cells.selectedState = YES;
        cell.textLabel.text = model;
    }];
    
    NSString *currentKey = [CX_CurrentSystemTool currentSetLanguageKey];
    NSInteger index = [self.dataSourceArray indexOfObject:currentKey];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *model = self.dataSourceArray[indexPath.row];
    self.selectedLanguageType = _languageDict[model];
    if ([[CX_CurrentSystemTool readCurrentAppLanguage] isEqualToString:self.selectedLanguageType]) {
        self.rightItemLabel.textColor = UIColorFromRGB(0x3f6847);
    }else {
        self.rightItemLabel.textColor = [UIColor greenColor];
    }
}

- (void)obtainData
{
    _languageDict = [CX_CurrentSystemTool appAllLanguages];
    self.dataSourceArray = [[_languageDict allKeys] mutableCopy];
}

- (void)leftItemAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightItemAction
{
    if ([_selectedLanguageType isEqualToString:[CX_CurrentSystemTool readCurrentAppLanguage]]) {
        return;
    }
    //Hans en
    if ([_selectedLanguageType containsString:@"Hans"] || [_selectedLanguageType containsString:@"en"]) {
    //   if ([_selectedLanguageType containsString:@"zh"] || [_selectedLanguageType containsString:@"en"]) {
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"应用内切换语言暂时只翻译英文和简体中文,如果想实现，请自己翻译Localizable目录下对应的语言" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [CX_CurrentSystemTool saveOldLanguage];
    [CX_CurrentSystemTool saveSetLanguage:_selectedLanguageType];
    
    if ([self.delegate respondsToSelector:@selector(languageControllerBack:)]) {
        [self.delegate languageControllerBack:self];
    }
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    WEAKSELF;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(64);
    }];
}

- (UINavigationBar *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[UINavigationBar alloc] init];
        _navigationBar.frame = CGRectMake(0, 0, ScreenWidth, 64);
    }
    return _navigationBar;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}




- (void)setNavigationBarItem
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 44);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = DSLocalizedString(@"ip_dialog_cancle",nil);
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftItemAction)];
    [label addGestureRecognizer:tap];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    // 45 76 47
    UILabel *rightlabel = [[UILabel alloc] init];
    rightlabel.textColor = UIColorFromRGB(0x3f6847);
    self.rightItemLabel = rightlabel;
    rightlabel.frame = CGRectMake(0, 0, 80, 44);
    rightlabel.textAlignment = NSTextAlignmentRight;
    rightlabel.text = DSLocalizedString(@"ip_dialog_ok",nil);
    rightlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *righttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightItemAction)];
    [rightlabel addGestureRecognizer:righttap];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightlabel];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.text = DSLocalizedString(@"settings_change_language", nil);
    UINavigationItem *navigationBarTitle = [[UINavigationItem alloc] init];
    navigationBarTitle.titleView = titleLabel;
    navigationBarTitle.leftBarButtonItem = leftItem;
    navigationBarTitle.rightBarButtonItem = rightItem;
    [self.navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
}

@end
