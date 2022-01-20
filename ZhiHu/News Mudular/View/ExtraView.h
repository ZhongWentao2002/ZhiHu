//
//  ExtraView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/20.
//

/**Extra视图
 * 此视图将展示新闻额外信息
 * 拥有：返回，评论，点赞，收藏，转发
 * 数据将被类扩展为label显示
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExtraViewDelegate <NSObject>

@required//实现

/**单击了返回按钮*/
- (void)ExtraView_tapBackItem;

/**单击了评论按钮*/
- (void)ExtraView_tapCommentItem;

/**单击了点赞按钮*/
- (void)ExtraView_tapPopuliarItem;

/**单击了收藏按钮*/
- (void)ExtraView_tapCollectItem;

/**单击了转发按钮*/
- (void)ExtraView_tapRelayItem;

@end

#pragma mark - Extra视图

@interface ExtraView : UIView

#pragma mark - 基本属性

/**返回按钮*/
@property (nonatomic, strong) UIButton *backBtn;

/**评论按钮*/
@property (nonatomic, strong) UIButton *commentBtn;

/**点赞*/
@property (nonatomic, strong) UIButton *likeBtn;

/**收藏*/
@property (nonatomic, strong) UIButton *collectBtn;

/**转发*/
@property (nonatomic, strong) UIButton *relayBtn;

#pragma mark - 其它属性

/**代理*/
@property (nonatomic, weak) id <ExtraViewDelegate> delegate;

@end

#pragma mark - 数字视图

@interface ExtraView ()

/**总评论数*/
@property (nonatomic, strong) UILabel *commentNumLab;

/**很小的细线*/
@property (nonatomic, strong) UILabel *line;

/**点赞数*/
@property (nonatomic, strong) UILabel *popularLab;

@end

NS_ASSUME_NONNULL_END
