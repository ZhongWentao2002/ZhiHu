//
//  SourseStory.h
//  ZhiHu
//
//  Created by SSR on 2022/1/16.
//

/**SourseStory
 * 所有的主页数据都将归到这个数据中心
 * 传递和代理都将写在这个文件
 * 遵循<UITableViewDataSource>
 * 提供完美的source数据解决方案
 * 部分类似返回UITableViewCell的协议将转交一次！
 * 必须实现以下代理：
 * - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

 */

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>

#import "DailyStories.h"

NS_ASSUME_NONNULL_BEGIN

@interface SourseStory : NSObject
<UITableViewDataSource>

/**banner内容*/
@property (nonatomic, copy) DailyStories *topStories;

/**table内容*/
@property (nonatomic, copy)NSMutableArray <DailyStories *> *sectionStories;

/**代理*/
@property (nonatomic, weak)id <UITableViewDataSource> delegate;

@end

NS_ASSUME_NONNULL_END
