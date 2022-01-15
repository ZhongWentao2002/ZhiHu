//
//  Story.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**Story模型
 * Story为cell单行显示的数据
 * 这里将直接保存所有可用数据
 * 所有的转换都将由字典告诉我们
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Story代理

@protocol StoryDelegate <NSObject>

@optional//必须实现

/**提供title，返回doubel类型数据并封装*/
- (double) heightForTitle:(NSString *)title;

@end

#pragma mark - Story属性

@interface Story : NSObject

#pragma mark 基本数据属性

/**title新闻标题*/
@property (nonatomic, copy) NSString *title;

/**hint作者信息*/
@property (nonatomic, copy) NSString *hint;

/**image预览图片*/
@property (nonatomic, copy) NSString *image;

#pragma mark - 其他数据属性

/**image_hue，用于top_stories类型*/
@property (nonatomic, copy) NSString *image_hue;

/**id内容id*/
@property (nonatomic) NSInteger ID;

/**url详情页保留*/
@property (nonatomic, copy) NSString *url;

/**代理，任何类型，只要给我提供数据的类型*/
@property (nonatomic, weak) id <StoryDelegate> delegate;

#pragma mark - 被封装的基本属性

/**title的高度，将由代理完成*/
@property (nonatomic, readonly) double titleHeight;

#pragma mark - 初始化方法

/**Top类型字典转模型
 * Top类型字典至少包含如下：
 * title:NSString
 * hint:NSString
 * image:NSString
 * image_hue:NSString
 * url:NSString
 */
- (instancetype)initTopDic:(NSDictionary *)dic;

/**Cell类型字典转模型
 * Cell类型字典至少包含如下：
 * title:NSString
 * hint:NSString
 * image:NSArray -> NSString有nil情况
 * image_hue:NSString
 * url:NSString
 */
- (instancetype)initCellDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
