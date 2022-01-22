//
//  NewsViewController.h
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

/**NewsViewController
 * 持有一个Web视图
 * 一份web数据
 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - News模块代理

@protocol NewsDelegate <NSObject>

@end

#pragma mark - News属性

@interface NewsViewController : UIViewController

#pragma mark - 其它属性

/**代理，关键时候得到push对象*/
@property (nonatomic, weak) UIViewController <NewsDelegate> *delegate;

#pragma mark - 对外方法

/**init不可用，请使用Create_withDelegate*/
- (instancetype)init __attribute__((unavailable("请使用Create_withDelegate:ID:URL")));

/**创建的方法*/
+ (NewsViewController *)createWithDelegate:(UIViewController <NewsDelegate> *)delegate
                                        ID:(NSInteger)ID URL:(NSString * _Nullable )url;

@end

NS_ASSUME_NONNULL_END
