//
//  SourseStory.m
//  ZhiHu
//
//  Created by SSR on 2022/1/16.
//

#import "SourseStory.h"

@implementation SourseStory

#pragma mark - 初始化方法

/**原生态init方法*/
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.topStories = [[DailyStories alloc] init];
        self.sectionStories = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - 链式编程

/**创建*/
+ (SourseStory *(^)(void))Create{
    return ^SourseStory *(){
        return [[SourseStory alloc] init];
    };
}

/**代理*/
- (SourseStory *(^)(id <SourseStoryDelegate>))Self_Delegate{
    return ^SourseStory *(id <SourseStoryDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

#pragma mark - 网络请求

/**lastest请求*/
- (void)getLastest:(void(^)(void))reload{
    [DailyStories
     GetLastestTop:^(DailyStories * _Nonnull topSourse) {
        // Set Top
        self.topStories = topSourse;
        reload();
    }
     Cell:^(DailyStories * _Nonnull cellSourse) {
        // Add Cell
        [self.sectionStories addObject:cellSourse];
        reload();
    }];
}

#pragma mark - <UITableViewDataSource>

/**返回一共有几天
 * 只是起到显示表单的作用
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return self.sectionStories.count + 1;
}

/**返回当天一共有几条
 * 如果无数据，则返回6个默认数据
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return self.sectionStories.count == section ? 6 : self.sectionStories[section].stories.count;
}

/**根据story去set一个cell，应交给代理去做
 * 若没有Story，则代理得到nil
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return [self.delegate tableView:tableView ForSourse:(self.sectionStories.count == indexPath.section ? nil : self.sectionStories[indexPath.section].stories[indexPath.row])];
}


@end
