//
//  DailyStories.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "DailyStories.h"
#import "NetTool.h"

@implementation DailyStories

#pragma mark - 初始化方法

/**Top创建
 * 传入将转为Story类型的数组
 * top数据将不使用date，可用不用复值
 * 封装性：MutableArray检测
 */
- (instancetype)initTopWithTop_stories:(NSArray *)storiesArray{
    self = [super init];
    if (self) {
        NSMutableArray *storyMA = [[NSMutableArray alloc] init];
        for (NSDictionary *storyDic in storiesArray) {
            /**注意这里用的initTopDic*/
            [storyMA addObject:[[Story alloc] initTopDic:storyDic]];
        }
        self.stories = [storyMA copy];
    }
    return self;
}

/**Cell创建
 * 传入将转为Story类型的数组
 * Cell将传入date和将转为Story类型的数组
 * 封装性：MutableArray检测
 */
- (instancetype)initCellWithDate:(NSString *)date
                     Cell_stories:(NSArray *)storiesArray{
    self = [super init];
    if (self) {
        self.date = date;
        NSMutableArray *storyMA = [[NSMutableArray alloc] init];
        for (NSDictionary *storyDic in storiesArray) {
            /**注意这里用的initCellDic:delegate*/
            [storyMA addObject:[[Story alloc] initCellDic:storyDic delegate:self]];
        }
        self.stories = [storyMA copy];
    }
    return self;
}

#pragma mark - 网络请求

/**Lastest请求
 * 请求最近一次数据，将由NetTool传入
 * 得到date, stories, top_stories
 * 将用date和top_stories组成Top类型回掉
 * 将用date和stories组成Cell类型回掉
 */
+ (void)GetLastestTop:(void(^)(DailyStories *))setTop
                 Cell:(void(^)(DailyStories *))addCell{
    /**网络请求，得到了可用的dic*/
    [NetTool GetLatestNewsSuccess:^(NSDictionary * _Nonnull dic) {
        /**创建并回掉Top*/
        setTop([[self alloc] initTopWithTop_stories:dic[@"top_stories"]]);
        /**创建并回掉Cell*/
        addCell([[self alloc] initCellWithDate:dic[@"date"] Cell_stories:dic[@"stories"]]);
    }];
}

#pragma mark - <StoryDelegate>

/**提供title，返回doubel类型数据并封装*/
- (double)heightForTitle:(NSString *)title{
    /**因为自己不知道，所以传递一次*/
    return [self.delegate heightForTitle:title];
}

@end
