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

//日期，个数，@{@"1":@story1,...};

/**传当天时间，如果找到了则返回*/
- (void)requestStoriesBeforeDate:(NSString *)date
       successWithDailyStories:(void (^)(DailyStories *aStories))success
          getStoriesSaveToFile:(DailyStories * _Nonnull(^)(NSString *getDate))notFound {
    // 1.得到要找的路径
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dateFile = [caches stringByAppendingPathComponent:date];
    // 2.寻找路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL hadFile = [fileManager fileExistsAtPath:dateFile];
    // 3.1.成功则反序列化回掉
    if (hadFile) {
        // 准备数据
        NSMutableData *data = [NSMutableData data];
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        // 取得数据
        NSMutableArray <Story *> *ma = [[NSMutableArray alloc] init];
        NSInteger count = [unArchiver decodeIntegerForKey:@"number"];
        for (NSInteger i = 0; i < count; i++) {
            Story *aStory = [unArchiver decodeObjectOfClass:[Story class] forKey:[NSString stringWithFormat:@"%ld", i]];
            [ma addObject:aStory];
        }
        [unArchiver finishDecoding];
        // 赋值数据
        DailyStories *aDaily = [[DailyStories alloc] init];
        aDaily.date = date;
        aDaily.stories = [ma copy];
        // 回掉数据
        success(aDaily);
    }
    // 3.2.不成功则先网络请求，返回自己后保存至文档
    else {
        // 准备数据
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        // 取得数据
        NSDate *date = [[NSDate alloc] init];
        NSDateFormatter *a;
        
//        DailyStories *theStories =
    }
}

- (void)encodeCell {
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.date forKey:self.date];
    NSInteger count = self.stories.count;
    for (NSInteger i = 0; i < count; i++) {
        Story *aStory = self.stories[i];
        [archiver encodeObject:aStory forKey:[NSString stringWithFormat:@"%ld", i]];
    }
    [archiver finishEncoding];
    [data writeToFile:caches atomically:YES];
}
@end
