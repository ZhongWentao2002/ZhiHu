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
 * 自己被选中后不显示任何东西
 *
 * Defualt状态，即加载不出来cell的状态，初始化时默认此状态
 * 当得到了值过后，视图将有其他人决定
 * 外部将传递Story模型供封装使用
 */

#import <UIKit/UIKit.h>

#import "UIView+Frame.h"

NS_ASSUME_NONNULL_BEGIN

/**PageCell复用标识*/
#define PageCellReuseIdentifier @"PageCell"

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

#pragma mark - 初始化方法

/**创建复用池cell*/
+ (PageCell *)CreateReusableCell;

#pragma mark - 赋值

/**自定义title的文字*/
- (PageCell *)TitleWithtext:(NSString *)str;

/**title文字颜色，NO黑，YES灰*/
- (PageCell *)isWatched:(BOOL)watched;

/**自定义hint的文字*/
- (PageCell *)HintWithtext:(NSString *)str;

/**自定义picture*/
- (PageCell *)PictureWithURLString:(NSString *)url;

/**无数据状态
 * 这种状态将存在于 加载数据前 和 无限滚动加载数据前
 * 复用池机制将自动调用一次
 * 请在与复用池匹配的else中手动调用一次
 *
 * 数据：titleLab显示空文本，灰色，单行灰
 * hintlab显示空文本，灰色
 * backgroundColor
 */
- (PageCell *)Default;

@end

NS_ASSUME_NONNULL_END
