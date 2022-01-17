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
            Story *astory = Story.Create()
                .Title_String(storyDic[@"title"])
                .Hint_String(storyDic[@"hint"])
                .Image_URLString(storyDic[@"image"])
                .Image_hue_String(storyDic[@"image_hue"])
                .ID_String(storyDic[@"id"])
                .URL_String(storyDic[@"url"]);
            [storyMA addObject:astory];
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
        for (NSDictionary *dic in storiesArray) {
            // Cell
            Story *aStory = Story.Create()
                .Title_String(dic[@"title"])
                .Hint_String(dic[@"hint"])
                .Image_URLArray(dic[@"images"])
                .ID_String(dic[@"ID"])
                .URL_String(dic[@"url"]);
            [storyMA addObject:aStory];
        }
        self.stories = [storyMA copy];
    }
    return self;
}

#pragma mark - 链式创建

/**创建*/
+ (DailyStories *(^)(void))Create{
    return ^DailyStories *(){
        return [[DailyStories alloc] init];
    };
}

/**Top，传值类型为Array*/
- (DailyStories *(^)(NSArray *))Top_Array{
    return ^(NSArray * storiesArray){
        NSMutableArray *storyMA = [[NSMutableArray alloc] init];
        for (NSDictionary *storyDic in storiesArray) {
            // Top
            Story *astory = Story.Create()
                .Title_String(storyDic[@"title"])
                .Hint_String(storyDic[@"hint"])
                .Image_URLString(storyDic[@"image"])
                .Image_hue_String(storyDic[@"image_hue"])
                .ID_String(storyDic[@"id"])
                .URL_String(storyDic[@"url"]);
            [storyMA addObject:astory];
        }
        self.stories = [storyMA copy];
        return self;
    };
}

/**Cell*/
- (DailyStories *(^)(NSString *, NSArray *))Cell_Date_Array{
    return ^(NSString *date, NSArray *storiesArray){
        self.date = date;
        NSMutableArray *storyMA = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in storiesArray) {
            // Cell
            Story *aStory = Story.Create()
                .Title_String(dic[@"title"])
                .Hint_String(dic[@"hint"])
                .Image_URLArray(dic[@"images"])
                .ID_String(dic[@"ID"])
                .URL_String(dic[@"url"]);
            [storyMA addObject:aStory];
        }
        self.stories = [storyMA copy];
        return self;
    };
}

/**得到下标为Row的story*/
- (Story *(^)(NSInteger))Story_inRow{
    return ^Story *(NSInteger row){
        return row <= self.stories.count ? self.stories[row] : nil;
    };
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
        setTop(DailyStories.Create().Top_Array(dic[@"top_stories"]));
        /**创建并回掉Cell*/
        addCell(DailyStories.Create().Cell_Date_Array(dic[@"date"], dic[@"stories"]));
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
        addCell(DailyStories.Create().Cell_Date_Array(dic[@"date"], dic[@"stories"]));
    }];
}

@end
