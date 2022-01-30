//
//  MainTableView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**MainTableView
 * 必须设置代理
 * 自己将掌握PageCell类型，用于创建该类Cell
 * 将UITableView代理给自己
 * 不显示横滚动条
 * 不显示竖滚动条
 * 不显示cell间线
 * Cell将在循环的时候确定，所以自己将不引用
 */

#import <UIKit/UIKit.h>

#import "UIView+Frame.h"

#import "PageCell.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MainTableView代理

@protocol MainTableViewDelegate <NSObject>

@required//提醒一下下

/**将WillDisplayCell的indexpath转交出去，当显示footer时调用*/
- (void)MainTableView_WillDisplaySection:(NSInteger)section;

/**获取indexPath的date*/
- (NSString *)MainTableView_titleForSection:(NSInteger)section;

/**单击了indexPath的cell*/
- (void)MainTableView_selectedAtIndexPath:(NSIndexPath *)indexPath;

/**滑动了TableView*/
- (void)MainTableView_scrollingWithOffset:(CGPoint)offset;

@end

#pragma mark - MainTableView基本

@interface MainTableView : UITableView
/**遵守的代理*/
<UITableViewDelegate>

#pragma mark - 其他属性

/**tableView的代理*/
@property (nonatomic, weak)id <MainTableViewDelegate> MainTableView_delegate;

#pragma mark - PageCell相关的方法

/**得到复用池PageCell*/
- (PageCell *)getReusablePageCell;

@end

NS_ASSUME_NONNULL_END
