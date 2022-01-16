//
//  SourseStory.m
//  ZhiHu
//
//  Created by SSR on 2022/1/16.
//

#import "SourseStory.h"

@implementation SourseStory

#pragma mark - 初始化方法

/**调用init时必须在外部制定delegate！！！*/
- (instancetype)init{
    self = [super init];
    if (self) {
        self.topStories = [[DailyStories alloc] init];
        self.sectionStories = [[NSMutableArray alloc] init];
    }
    return self;
}

/**空Sourse的init方法
 * topStories会有基础加载
 * sectionStories会有基础加载
 */
- (instancetype)initWithDelegate:(id <SourseStoryDelegate>)delegate{
    self = [super init];
    if (self) {
        self.topStories = [[DailyStories alloc] init];
        self.sectionStories = [[NSMutableArray alloc] init];
        self.delegate = delegate;
    }
    return self;
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

#pragma mark - <StoryDelegate>

- (double)heightForTitle:(nonnull NSString *)title {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return [self.delegate heightForTitle:title];
}

@end
