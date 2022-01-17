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

#pragma mark - 链式编程

/**类方法创建*/
+ (Story *(^)(void))Create;

/**title赋值*/
- (Story *(^)(NSString *))Title_String;

/**hint赋值*/
- (Story *(^)(NSString *))Hint_String;

/**image，根据Ary赋值*/
- (Story *(^)(NSArray *))Image_URLArray;

/**image，根据具体url赋值*/
- (Story *(^)(NSString *))Image_URLString;

/**image_hue赋值*/
- (Story *(^)(NSString *))Image_hue_String;

/**ID，根据传入数字的String得到Intager*/
- (Story *(^)(NSString *))ID_String;

/**url赋值*/
- (Story *(^)(NSString *))URL_String;

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
