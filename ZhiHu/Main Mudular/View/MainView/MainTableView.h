//
//  MainTableView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**MainTableView
 * 自己将掌握PageCell类型，用于创建该类Cell
 *
 * Cell将在循环的时候确定，所以自己将不引用
 * Top只有一个，所以强引用
 */

#import <UIKit/UIKit.h>

#import "PageCell.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MainTableView代理

@protocol MainTableViewDelegate <NSObject>

@required//提醒一下下

/**将WillDisplayCell的indexpath转交出去，当显示footer时调用*/
- (void)MainTableViewWillDisplaySection:(NSInteger)section;

/**获取indexPath的date*/
- (NSString *)titleForSection:(NSInteger)section;

/**单击了indexPath的cell*/
- (void)tapAtIndexPath:(NSIndexPath *)indexPath;

/**滑动了TableView*/
- (void)MainTableView_Scrolling_offset:(CGPoint)offset;

@end

#pragma mark - MainTableView基本

@interface MainTableView : UITableView
/**遵守的代理*/
<UITableViewDelegate>

#pragma mark - 其他属性

/**tableView的代理*/
@property (nonatomic, weak)id <MainTableViewDelegate> mainTV_delegate;

#pragma mark - 方法

/**init方法不可用，请使用initWithFrame:style:*/
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - PageCell相关的方法

/**复用机制得到Cell*/
- (PageCell *(^)(void))ReusablePageCell;

@end

NS_ASSUME_NONNULL_END
