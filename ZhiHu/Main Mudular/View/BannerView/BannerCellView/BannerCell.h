//
//  BannerCell.h
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

/**BannerCell
 * 每个cell装有图片
 * 拥有标题
 * 和作者
 */

#import <UIKit/UIKit.h>

#import "UIView+Frame.h"

#define BannerCellReuseIdentifier @"BannerCell"

NS_ASSUME_NONNULL_BEGIN

@interface BannerCell : UICollectionViewCell

#pragma mark - 基本数据属性

/**title标题Label*/
@property (nonatomic, strong) UILabel *titleLab;

/**hint作者Label*/
@property (nonatomic, strong) UILabel *hintLab;

/**image图片imageView*/
@property (nonatomic, strong) UIImageView *pictureView;

#pragma mark 根据传值设置数据

/**自定义title的文字*/
- (BannerCell *)TitleWithText:(NSString *)str;

/**自定义hint的文字*/
- (BannerCell *)HintWithText:(NSString *)strt;

/**自定义picture*/
- (BannerCell *)Picture_URLString:(NSString *)url;

/**无数据状态
 * 这种状态将存在于 加载数据前 和 无限滚动加载数据前
 * 复用池机制将自动调用一次
 * 请在与复用池匹配的else中手动调用一次
 *
 * 数据：titleLab显示空文本，灰色，单行灰
 * hintlab显示空文本，灰色
 * backgroundColor
 */
- (BannerCell *)Default;

@end

NS_ASSUME_NONNULL_END
