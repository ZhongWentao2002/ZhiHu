//
//  PageCell.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import <UIKit/UIKit.h>

#define PageCellIdentify @"PageCell"

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

- (PageCell *(^)(void))Default;

/**自定义title的文字*/
- (PageCell *(^)(NSString *text))title;

/**自定义hint的文字*/
- (PageCell *(^)(NSString *text))hint;

/**自定义picture*/
- (PageCell *(^)(NSString *url))picture;

@end

NS_ASSUME_NONNULL_END
