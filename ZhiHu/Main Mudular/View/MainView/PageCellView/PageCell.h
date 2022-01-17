//
//  PageCell.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**PageCell
 * 拥有titleLab，需要去判断行高
 * hintLab，显示作者信息
 * picture，显示图片
 *
 * Defualt状态，即加载不出来cell的状态，初始化时默认此状态
 * 链式创建，当得到了值过后，视图将有其他人决定
 * 外部将传递Story模型供封装使用
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - PageCellDelegate

@protocol PageCellDelegate <NSObject>

@required//必须实现

/**在恰当的时机知道自己的superTableView*/
- (UITableView *)superTableView;

@end

#pragma mark - PageCell属性

@interface PageCell : UITableViewCell

#pragma mark - 基本数据属性

/**title标题Label*/
@property (nonatomic, strong) UILabel *titleLab;

/**hint作者Label*/
@property (nonatomic, strong) UILabel *hintLab;

/**image图片imageView*/
@property (nonatomic, strong) UIImageView *pictureView;

#pragma mark - 其他数据属性

/**代理*/
@property (nonatomic, weak) id delegate;

#pragma mark - 链式编程方法

#pragma mark 初始化

/**init不可用，请用initWithStyle*/
- (instancetype)init NS_UNAVAILABLE;

/**链式创建，如果有则直接拿，如果没有则创建，默认default状态*/
+ (PageCell *(^)(UITableView *))ReusableCellFromSuperTableView;

/**无数据状态
 * 这种状态将存在于 加载数据前 和 无限滚动加载数据前
 * 复用池机制将自动调用一次
 * 请在与复用池匹配的else中手动调用一次
 *
 * 数据：titleLab显示空文本，灰色，单行灰
 * hintlab显示空文本，灰色
 * backgroundColor
 */
- (PageCell *(^)(void))Default;

#pragma mark 根据传值设置数据

/**自定义title的文字*/
- (PageCell *(^)(NSString *text))Title_text;

/**自定义hint的文字*/
- (PageCell *(^)(NSString *text))Hint_text;

/**自定义picture*/
- (PageCell *(^)(NSString *url))Picture_URLString;


@end

#pragma mark - PageCell类扩展（封装）

@interface PageCell (CGRect)

#pragma mark - 被封装的基本CGRect

/**title的Rect封装*/
@property (nonatomic, readonly) CGRect titleRect;

/**hint的Rect封装*/
@property (nonatomic, readonly) CGRect hintRect;

/**picture的Rect封装*/
@property (nonatomic, readonly) CGRect pictureRect;

@end

NS_ASSUME_NONNULL_END
