//
//  BannerView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

/**Banner视图
 * 图片轮播器
 * 将接受collectionView的代理
 * 不确定的东西将交给自己的代理去做
 */

#import <UIKit/UIKit.h>

#import "BannerCell.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 代理

@protocol BannerViewDelegate <NSObject>

@required//提醒一下下

/**单击了cell传出indexpath*/
- (void)BannerView_tapAtIndexPath:(NSIndexPath *)indexPath;

/**已停止滑动*/
- (void)BannerView_endedScollAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - BannerView属性

@interface BannerView : UICollectionView
<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**代理*/
@property (nonatomic, weak) id <BannerViewDelegate> Banner_delegate;

/**注册Cell的方法*/
- (BannerCell *)getReusableBannerCell:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
