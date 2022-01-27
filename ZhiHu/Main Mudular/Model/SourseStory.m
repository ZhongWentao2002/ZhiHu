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

/**快速返回cell的DailyStories*/
- (DailyStories * _Nullable)DailyStories_atCellSection:(NSInteger)section {
    return (self.sectionStories == nil ||
            section >= self.sectionStories.count) ?
                nil :
                self.sectionStories[section];
}

#pragma mark - 网络请求

/**Lastest请求*/
- (void)getLastestTop:(void(^)(void))reloadTop
                 Cell:(void(^)(void))reloadCell{
    /**网络请求*/
    [DailyStories
     GetLastestTop:^(DailyStories * _Nonnull topSourse) {
        // Set Top
        self.topStories = topSourse;
        reloadTop();
    }
     Cell:^(DailyStories * _Nonnull cellSourse) {
        // Add Cell
        [self.sectionStories addObject:cellSourse];
        reloadCell();
    }];
}

/**Before请求*/
- (void)getBefore:(void(^)(void))reloadSection{
    /**网络请求*/
    [DailyStories
     GetBeforeDate:self.sectionStories.lastObject.date
     Cell:^(DailyStories * _Nonnull cellSourse) {
        // Add Cell
        [self.sectionStories addObject:cellSourse];
        reloadSection();
    }];
}

#pragma mark - <UITableViewDataSource>

/**返回一共有几天
 * 只是起到显示表单的作用
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"\n%@ - %s", [self class], __func__);
    NSLog(@"\n\tself.sectionStories.count = %ld", self.sectionStories.count);
    
    return self.sectionStories.count + 1;
}

/**返回当天一共有几条
 * 如果无数据，则返回6个默认数据
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    NSLog(@"\n\tself.sectionStories.count = %ld", self.sectionStories.count);
    
    return self.sectionStories.count == section ? 6 : self.sectionStories[section].stories.count;
}

/**根据story去set一个cell，应交给代理去做
 * 若没有Story，则代理得到nil
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return [self.delegate SourseStory_CellForSourse:
            [[self
             DailyStories_atCellSection:indexPath.section]
             StoryAtRow:indexPath.row]];
}

#pragma mark - <UICollectionViewDataSource>

/**根据story去set一个cell，应交给代理去做
 * 若没有Story，则代理得到nil
 * 因为collection靠indexpath注册
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n%@ - %s", [self class], __func__);
    NSLog(@"\n\tindexPath : %ld - %ld", indexPath.section, indexPath.item);

    return [self.delegate SourseStory_ItemForIndexPath:indexPath];
}

/**返回个数，默认是5组*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"\n%@ - %s", [self class], __func__);
    NSLog(@"\n\tself.topStories.stories.count = %ld", self.topStories.stories.count);
    
    return self.topStories.stories.count == 0 ? 5 :self.topStories.stories.count;
}

@end
