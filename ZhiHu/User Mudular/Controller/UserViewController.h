//
//  UserViewController.h
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

/**UserViewController
 * 用户页
 * 将有一个代替navigation的view
 * 和一个主页视图的view
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - News模块代理

@protocol LoadDelegate <NSObject>

@end

#pragma mark - News属性

@interface UserViewController : UIViewController

/**代理，关键时候得到push对象*/
@property (nonatomic, weak) UIViewController <LoadDelegate> *delegate;

/**init不可用，请使用Create_withDelegate*/
- (instancetype)init __attribute__((unavailable("请使用Create_withDelegate()")));

/**链式创建方法*/
+ (UserViewController *(^)(UIViewController <LoadDelegate> *))Create_withDelegate;


@end

NS_ASSUME_NONNULL_END
