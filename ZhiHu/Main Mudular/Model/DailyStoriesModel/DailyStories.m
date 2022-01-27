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

/**简单初始化方法，无数据加载*/
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.date = [NSString string];
        self.stories = [[NSArray alloc] init];
    }
    return self;
}

/**Top创建
 * 传入将转为Story类型的数组
 * top数据将不使用date，可用不用复值
 * 封装性：MutableArray检测
 */
- (instancetype)initTopWithTop_stories:(NSArray *)storiesArray{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        NSMutableArray *storyMA = [[NSMutableArray alloc] init];
        for (NSDictionary *storyDic in storiesArray) {
            // Top
            
            Story *aStory = [[Story alloc] initTopDic:storyDic];
            
            [storyMA addObject:aStory];
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
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.date = date;
        NSMutableArray *storyMA = [[NSMutableArray alloc] init];
        for (NSDictionary *storyDic in storiesArray) {
            // Cell
            Story *aStory = [[Story alloc] initCellDic:storyDic];
            
            [storyMA addObject:aStory];
        }
        self.stories = [storyMA copy];
    }
    return self;
}

/**提供一个快速访问Story到的方法，给定story的下标*/
- (Story  * _Nullable)StoryAtRow:(NSInteger)row {
    return row <= self.stories.count ? self.stories[row] : nil;
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
    [[NetTool shareTool]
     Lastest:^(NSDictionary * _Nonnull dic) {
        /**创建并回掉Top*/
        setTop([[DailyStories alloc] initTopWithTop_stories:dic[@"top_stories"]]);
        /**创建并回掉Cell*/
        addCell([[DailyStories alloc] initCellWithDate:dic[@"date"] Cell_stories:dic[@"stories"]]);
    }];
}

/**Before请求
 * 请求最近一次数据，将由NetTool传入
 * 得到字典
 * 将用date和stories组成Cell类型回掉
 */
+ (void)GetBeforeDate:(NSString *)date
                 Cell:(void(^)(DailyStories *))addCell{
    /**网络请求*/
    [[NetTool shareTool]
     BeforeDate:date
     Add:^(NSDictionary * _Nonnull dic) {
        /**创建并回掉Cell*/
        addCell([[DailyStories alloc] initCellWithDate:dic[@"date"] Cell_stories:dic[@"stories"]]);
    }];
}

@end
