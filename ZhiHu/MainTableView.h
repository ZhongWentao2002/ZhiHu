//
//  MainTableView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**MainTableView
 * 自己将掌握PageCell类型，用于创建该类Cell
 * 自己将掌握banner类型，用于头视图
 *
 * Cell将在循环的时候确定，所以自己将不引用
 * Top只有一个，所以强引用
 */

#import <UIKit/UIKit.h>

#import "PageCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTableView : UITableView
/**代理*/
<UITableViewDelegate>

/**init方法不可用，请使用initWithFrame:style:*/
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - PageCell相关的方法

/**复用机制得到Cell*/
- (PageCell *(^)(void))ReusablePageCell;

@end

NS_ASSUME_NONNULL_END
