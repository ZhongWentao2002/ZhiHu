//
//  PageCell.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**PageCell
 * 拥有titleLab，需要去判断行高
 * 
 */

#import <UIKit/UIKit.h>

#import <Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageCell : UITableViewCell

#pragma mark - 基本数据属性

/**title标题Label*/
@property (nonatomic, strong) UILabel *titleLab;

/**hint作者Label*/
@property (nonatomic, strong) UILabel *hintLab;

/**image图片imageView*/
@property (nonatomic, strong) UIImageView *pictureView;

#pragma mark - 链式编程声明

#pragma mark 模式链式

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

/**frame的layout*/
- (PageCell *(^)(CGFloat))width;

#pragma mark 属性链式

/**自定义title的文字*/
- (PageCell *(^)(NSString *text))title;

/**自定义hint的文字*/
- (PageCell *(^)(NSString *text))hint;

/**自定义picture*/
- (PageCell *(^)(NSString *url))picture;

@end

NS_ASSUME_NONNULL_END
