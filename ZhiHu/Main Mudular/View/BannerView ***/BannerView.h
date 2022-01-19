//
//  BannerView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import <UIKit/UIKit.h>

#import "BannerCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerView : UICollectionView
<UICollectionViewDelegate>

/**注册Cell的方法*/
- (BannerCell *(^)(NSIndexPath *))ReusableBannerCell_atIndexPath;

@end

NS_ASSUME_NONNULL_END
