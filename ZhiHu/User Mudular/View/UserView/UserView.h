//
//  UserView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/22.
//

/**UserView
 * 放一些登录登出的控件
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - User视图

@interface UserView : UIView

#pragma mark - 基础属性

/**持有一个头像*/
@property (nonatomic, strong) UIImageView *headImgView;

/**登陆退出键*/
@property (nonatomic, strong) UIButton *loadBtn;

#pragma mark - 方法

/**是否已经登录*/
+ (NSString *)ImageNameWhereIsLoaded;

@end

NS_ASSUME_NONNULL_END
