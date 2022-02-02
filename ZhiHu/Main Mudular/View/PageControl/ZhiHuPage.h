//
//  ZhiHuPage.h
//  ZhiHu
//
//  Created by SSR on 2022/2/1.
//

/**ZhiHuPage
 * 此Page只能横向布局
 * 并只能作用横向scroll
 * 只继承UIView
 */

#import <UIKit/UIKit.h>

#import "UIView+Frame.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ZhiHuPage属性

@interface ZhiHuPage : UIView

#pragma mark 属性

/**页数，默认5页*/
@property (nonatomic) NSInteger pages;

/**当前所在页数，默认第1页*/
@property (nonatomic) NSInteger currentPage;

/**整体色调，默认白色。传入请传入alpha为1的颜色*/
@property (nonatomic, strong) UIColor *currentColor;

/**page间距，默认5间距*/
@property (nonatomic) CGFloat space;

/**scroll一页的宽度，必须设置*/
@property (nonatomic) CGFloat scrollWidth;

#pragma mark - 方法

/**请在scrollViewWillBeginDragging中调用此方法，并传入offset*/
- (void)ScrollBegin:(CGPoint)offset;

/**请在scrollViewDidScroll中调用此方法，并传入offset*/
- (void)Scrolling:(CGPoint)offset;

/**请在scrollViewDidEndScrollingAnimation中调用此方法，并传入offset*/
- (void)ScrollingEnd:(CGPoint)offset;

@end

NS_ASSUME_NONNULL_END
