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
 */

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>

#import "DailyStories.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 代理

/**此代理和Story相关，必须遵守StoryDelegate协议*/
@protocol SourseStoryDelegate <NSObject>

@required//必须实现

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UITableViewCell *)tableView:(UITableView *)tableView
                     ForSourse:(Story * _Nullable)story;

@end

#pragma mark - 属性

@interface SourseStory : NSObject
<UITableViewDataSource>

#pragma mark - 基本数据属性

/**banner内容*/
@property (nonatomic, strong) DailyStories *topStories;

/**table内容*/
@property (nonatomic, copy)NSMutableArray <DailyStories *> *sectionStories;

#pragma mark - 其他数据属性

/**代理*/
@property (nonatomic, weak)id <SourseStoryDelegate> delegate;

#pragma mark - 链式编程

/**创建*/
+ (SourseStory *(^)(void))Create;

/**代理*/
- (SourseStory *(^)(id <SourseStoryDelegate>))Self_Delegate;

@end

NS_ASSUME_NONNULL_END
