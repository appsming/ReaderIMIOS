
/******************************************************************************
 版权所有 :  此文件版权归深圳市世纪畅行科技有限公司
 文件名称  :    AdveriseController.h
 文件作用描述  : 声明一些变量及方法
 文件创建人 :    明邦良
 文件创建时间 :   16-12-2
 文件修改人 :
 文件修改时间 :
 修改描述 :
 备注     :
 ******************************************************************************/


#import <UIKit/UIKit.h>

@class AdveriseController;

@protocol AdveriseControllerDelegate <NSObject>
@optional
- (void)adveriseControllerBack:(AdveriseController *)adveriseController;

@end

@interface AdveriseController : UIViewController
- (BOOL)downLoadSource;
@property (nonatomic,weak)id<AdveriseControllerDelegate>delegate;
@end
