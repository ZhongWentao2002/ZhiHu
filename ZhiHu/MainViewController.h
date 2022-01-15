//
//  MainViewController.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**知乎日报主页控制器
 * 此控制器将管理一个banner和tableview
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainDelegate <NSObject>

@end

@interface MainViewController : UIViewController

/**代理，关键时候得到push对象*/
@property (nonatomic, weak) UIViewController <MainDelegate> *delegate;

/**指定manageVC为自己代理，封装性良好*/
- (instancetype)initWithDelegate:(UIViewController <MainDelegate> *)manageVC;

@end

NS_ASSUME_NONNULL_END
