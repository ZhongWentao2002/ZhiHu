//
//  MainViewController.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**知乎日报主页控制器（模块）
 * 此控制器将管理一个banner和tableview
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Main模块代理

@protocol MainDelegate <NSObject>

@required//提醒下下

/**得到单击了Cell被push到的页面，传出id和url*/
- (UIViewController *)VC_pushedFromCell_withID:(NSInteger)ID url:(NSString *)url;

/**得到单击了SafeView的Img被push到的页面*/
- (UIViewController *)VC_pushedFromHeadView;

@end

#pragma mark - Main属性

@interface MainViewController : UIViewController

/**代理，关键时候得到push对象*/
@property (nonatomic, weak) UIViewController <MainDelegate> *delegate;

/**init不可用，请使用Create_withDelegate*/
- (instancetype)init __attribute__((unavailable("请使用Create_withDelegate()")));

/**链式创建方法*/
+ (MainViewController *(^)(UIViewController <MainDelegate> *))Create_withDelegate;

@end

NS_ASSUME_NONNULL_END
