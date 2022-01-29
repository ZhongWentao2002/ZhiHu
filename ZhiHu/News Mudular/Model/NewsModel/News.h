//
//  News.h
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

/**News Model模型
 * 保存一个New的基本信息
 * image大图片
 * title标题
 * html网页body源码
 * css图片集附加载
 * js注册代码
 */

#import <Foundation/Foundation.h>

#import "NetTool.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - News模型

@interface News : NSObject

#pragma mark - 基础属性

/**ID信息*/
@property (nonatomic) NSInteger ID;

/**HTTP里面的body详情信息*/
@property (nonatomic, copy) NSString *body;

/**css网址*/
@property (nonatomic, copy) NSString *css;

/**image图片*/
@property (nonatomic, copy) NSString *image;

/**image背景*/
@property (nonatomic, copy) NSString *image_hue;

/**js网址*/
@property (nonatomic, copy) NSString *js;

/**title大标题*/
@property (nonatomic, copy) NSString *title;

/**url网址*/
@property (nonatomic, copy) NSString *url;

#pragma mark - 链式

/**Create操作*/
+ (News *)CreateWithID:(NSInteger)ID;

#pragma mark - 方法

/**网络请求*/
- (void)getNewsHTTP:(void(^)(void))loadHTTP Request:(void(^)(NSString *))loadRequest;

@end

NS_ASSUME_NONNULL_END
