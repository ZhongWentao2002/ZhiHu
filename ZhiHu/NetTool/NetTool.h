//
//  NetTool.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**网络请求工具
 * 再次封装AFNetworking
 * 单例！！！没有任何其他数据
 * BaseURL: https://news-at.zhihu.com/api/3
 */

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetTool : AFHTTPSessionManager
<NSCopying, NSMutableCopying>

#pragma mark - 初始化方法

/**单例模块*/
+ (NetTool *)shareTool;

#pragma mark - 网络请求

/**Latest数据
 * URL：new/Latest
 * 请求Latest数据
 * 返回NSDictionary
 * 注意：不做对dictionary的进一步操作
 */
- (void)Lastest:(void(^)(NSDictionary *))create;

/**Before数据
 * URL：stories/before/日期
 * 请求Before数据
 * 返回NSDictionary
 * 注意：不做对dictionary的进一步操作
 */
- (void)BeforeDate:(NSString *)date
               Add:(void(^)(NSDictionary *))add;

/**News数据
 * URL：news/文章id
 * 请求News数据
 * 返回NSDictionary
 * 如果得不到数据，告诉应尝试Request
 * 注意：不做对dictionary的进一步操作
 */
- (void)NewsID:(NSInteger)ID
          HTTP:(void(^)(NSDictionary *))show
    tryRequest:(void(^)(void))request;

/**Extra数据请求
 * URL：story-extra/该新闻id
 * 请求Extra数据
 * 返回NSDictionary
 * 注意：不做对dictionary的进一步操作
 */
- (void)ExtraID:(NSInteger)ID
           Data:(void(^)(NSDictionary *))load;

@end

NS_ASSUME_NONNULL_END
