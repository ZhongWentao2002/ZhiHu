//
//  BannerCell.h
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerCell : UICollectionViewCell

#pragma mark - 基本数据属性

/**title标题Label*/
@property (nonatomic, strong) UILabel *titleLab;

/**hint作者Label*/
@property (nonatomic, strong) UILabel *hintLab;

/**image图片imageView*/
@property (nonatomic, strong) UIImageView *pictureView;


@end


#pragma mark - 被封装的

@interface BannerCell (CGRect)

#pragma mark - 被封装的基本CGRect

/**title的Rect封装*/
@property (nonatomic, readonly) CGRect titleRect;

/**hint的Rect封装*/
@property (nonatomic, readonly) CGRect hintRect;

@end

NS_ASSUME_NONNULL_END
