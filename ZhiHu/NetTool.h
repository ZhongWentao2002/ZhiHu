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


@end

NS_ASSUME_NONNULL_END
