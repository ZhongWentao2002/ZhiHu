//
//  NewsViewController.h
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - News模块代理

@protocol NewsDelegate <NSObject>

@end

#pragma mark - News属性

@interface NewsViewController : UIViewController

/**代理，关键时候得到push对象*/
@property (nonatomic, weak) UIViewController <NewsDelegate> *delegate;

/**init不可用，请使用Create_withDelegate*/
- (instancetype)init __attribute__((unavailable("请使用Create_withDelegate()")));

/**链式创建方法*/
+ (NewsViewController *(^)(UIViewController <NewsDelegate> *))Create_withDelegate;


@end

NS_ASSUME_NONNULL_END
