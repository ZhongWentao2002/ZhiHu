//
//  DailyStories.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**DailyStories
 * 所有有关Story的封装都将在这里
 * 封装性：将一定且必须拥有Story模型 和 NetTool网络请求工具
 * 这个Model将传递自己
 * 按需求，我们将分别提供Top和Cell型数据
 * 但每个Top和Cell都将为DailyStories模型
 * 需求：Top不需要date数据，date为nil
 */

#import <Foundation/Foundation.h>

/**与自己耦合性相关的模型*/
#import "Story.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - DailyStories属性

@interface DailyStories : NSObject
<StoryDelegate>

#pragma mark - 基本数据属性

/**保存当天日期*/
@property (nonatomic, copy) NSString *date;

/**保存每天的新闻*/
@property (nonatomic, copy) NSArray <Story *> *stories;

#pragma mark - 其他数据属性

/**代理，转交代理或其他*/
@property (nonatomic, weak) id <StoryDelegate> delegate;

#pragma mark - 初始化方法

/**Top创建
 * 传入将转为Story类型的数组
 * top数据将不使用date，可用不用复值
 * 封装性：MutableArray检测
 */
- (instancetype)initTopWithTop_stories:(NSArray *)storiesArray;

/**Cell创建
 * 传入将转为Story类型的数组
 * Cell将传入date和将转为Story类型的数组
 * 封装性：MutableArray检测
 */
- (instancetype)initCellWithDate:(NSString *)date
                    Cell_stories:(NSArray *)storiesArray;

#pragma mark - 网络请求

/**Lastest请求
 * 请求最近一次数据，将由NetTool传入
 * 得到date, stories, top_stories
 * 将用date和top_stories组成Top类型回掉
 * 将用date和stories组成Cell类型回掉
 */
+ (void)GetLastestTop:(void(^)(DailyStories *))setTop
                 Cell:(void(^)(DailyStories *))addCell;

@end

NS_ASSUME_NONNULL_END
