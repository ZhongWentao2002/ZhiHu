//
//  SafeBarView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

/**SafeBar视图
 * 用于刘海屏那一块的视图布局
 * 无任何数据源，有代理
 *
 * 代理将告知已单击头部 和 已单击头像
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SafeBarView代理

@protocol SafeBarViewDelegate <NSObject>

@required//提醒一下下

/**单击safeBar时会调用此代理*/
- (void)safeBarTaped;

/**单击imageview时会调用此代理*/
- (void)safeBarImageViewTaped;

/**头像的请求*/
- (NSString *)safeBarNeedHeadImage;

@end

#pragma mark - SafeBarView属性

@interface SafeBarView : UIView

#pragma mark - 基本属性

/**天*/
@property (nonatomic, strong) UILabel *dayLab;

/**月*/
@property (nonatomic, strong) UILabel *monthLab;

/**线*/
@property (nonatomic, strong) UILabel *line;

/**标题Lab*/
@property (nonatomic, strong) UILabel *titleLab;

/**头像imageView*/
@property (nonatomic, strong) UIImageView *headImgView;

#pragma mark - 其它属性

/**代理*/
@property (nonatomic, weak) id <SafeBarViewDelegate> delegate;

#pragma mark - 方法

/**init不可用，请用Create_withDelegate*/
- (instancetype)init __attribute__((unavailable("请使用Create_withDelegate()")));

/**initWithFrame:不可用，请用链式语法*/
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("请使用Frame_CGRect()")));

/**重写加载部分数据*/
- (void)reloadData;

/**链式创建Create*/
+ (SafeBarView *(^)(id <SafeBarViewDelegate>))Create_withDelegate;

/**frame链式语法*/
- (SafeBarView *(^)(CGRect))Frame_CGRect;

@end

NS_ASSUME_NONNULL_END
