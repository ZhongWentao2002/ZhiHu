//
//  News.h
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

/**News
 * 保存一个New的基本信息
 * html加载方法，css图片，js注册
 */

#import <Foundation/Foundation.h>

#include "NetTool.h"

NS_ASSUME_NONNULL_BEGIN

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
+ (News *(^)(NSInteger))Create_withID;

/**body赋值*/
- (News *(^)(NSString *))Body_HTTPString;

/**css赋值*/
- (News *(^)(NSArray *))CSS_URLArray;

/**image赋值*/
- (News *(^)(NSString *))Image_URLString;

/**image_hue赋值*/
- (News *(^)(NSString *))Image_hue_String;

/**js赋值*/
- (News *(^)(NSArray *))JS_URLArray;

/**title赋值*/
- (News *(^)(NSString *))Title_String;

/**url赋值*/
- (News *(^)(NSString *))URL_URLString;

#pragma mark - 方法

/**网络请求*/
- (void)getNewsHTTP:(void(^)(void))loadHTTP Request:(void(^)(void))loadRequest;

@end

NS_ASSUME_NONNULL_END
