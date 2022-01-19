//
//  SourseStory.h
//  ZhiHu
//
//  Created by SSR on 2022/1/16.
//

/**SourseStory
 * 所有的主页数据都将归到这个数据中心
 * 传递和代理都将写在这个文件
 * 遵循<UITableViewDataSource, UICollectionViewDataSource>
 * 提供完美的source数据解决方案
 */

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>

#import "DailyStories.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 代理

/**Sourse代理*/
@protocol SourseStoryDelegate <NSObject>

@required//必须实现

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UITableViewCell *)tableView:(UITableView *)tableView
                     ForSourse:(Story * _Nullable)story;

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                            ForIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - 属性

@interface SourseStory : NSObject
<UITableViewDataSource, UICollectionViewDataSource>

#pragma mark - 基本数据属性

/**banner内容*/
@property (nonatomic, strong) DailyStories *topStories;

/**table内容*/
@property (nonatomic, strong)NSMutableArray <DailyStories *> *sectionStories;

#pragma mark - 其他数据属性

/**代理*/
@property (nonatomic, weak)id <SourseStoryDelegate> delegate;

#pragma mark - 链式编程

/**创建*/
+ (SourseStory *(^)(void))Create;

/**代理*/
- (SourseStory *(^)(id <SourseStoryDelegate>))Self_Delegate;

/**得到section数据*/
- (DailyStories *(^)(NSInteger))DailyStories_inSection;

#pragma mark - 网络请求

/**Lastest请求*/
- (void)getLastestTop:(void(^)(void))reloadTop
                 Cell:(void(^)(void))reloadCell;

/**Before请求*/
- (void)getBefore:(void(^)(void))reloadSection;

@end

NS_ASSUME_NONNULL_END
