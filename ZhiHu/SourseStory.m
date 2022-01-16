//
//  SourseStory.m
//  ZhiHu
//
//  Created by SSR on 2022/1/16.
//

#import "SourseStory.h"

@implementation SourseStory

/**保证里面有数据的初始化方法*/
- (instancetype)init{
    self = [super init];
    if (self) {
        self.topStories = [[DailyStories alloc] init];
        self.sectionStories = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - <UITableViewDataSource>

/**返回一共有几天
 * 如果无数据，则返回1组数据
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    NSInteger sections = self.sectionStories.count;
    return sections == 0 ? 1 : sections;
}

/**返回当天一共有几条
 * 如果无数据，则返回6个数据
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return self.sectionStories.count == 0 ? 6 : self.sectionStories[section].stories.count;
}

/**根据story去set一个cell，应交给代理去做*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    
    return [self.delegate
            tableView:tableView
            ForSourse:(self.sectionStories.count == 0 ? nil : self.sectionStories[indexPath.section].stories[indexPath.row])];
}

@end
