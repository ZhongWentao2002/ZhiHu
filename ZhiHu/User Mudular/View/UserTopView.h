//
//  UserTopView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/22.
//

/**UserTopView
 * 此View将代替navigation的bar
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UserTopView代理

@protocol UserTopViewDelegate <NSObject>

@required//提醒

/**单击了返回按钮*/
- (void)UserTopView_tapBack;

@end

#pragma mark - UserTop视图

@interface UserTopView : UIView

/**返回按钮*/
@property (nonatomic, strong) UIButton *backBtn;

/**代理*/
@property (nonatomic, weak) id <UserTopViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
