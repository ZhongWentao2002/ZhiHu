//
//  NetTool.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "NetTool.h"

@implementation NetTool

#pragma mark - 初始化方法

/**单例模块*/
- (instancetype)init{
    self = [[self class] shareTool];
    return self;
}

/**单例模块*/
+ (NetTool *)shareTool{
    /**单例net*/
    static NetTool *net;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**baseURL在头文件已说明*/
        NSURL *baseURL = [NSURL URLWithString:@"https://news-at.zhihu.com/api/3"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        net = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    });
    return net;
}

#pragma mark - 网络请求

/**Latest数据
 * URL：new/Latest
 * 请求Latest数据
 * 返回NSDictionary
 * 注意：不做对dictionary的进一步操作
 */
- (void)Lastest:(void(^)(NSDictionary *))create{
    /**网络请求*/
    [self 
     GET:@"news/latest"
     parameters:nil
     headers:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n%@ - %s - success", [self class], __func__);
        NSLog(@"\n%@", responseObject);
        
        /**得到数据就回掉*/
        create(responseObject);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n%@ - %s - failure", [self class], __func__);
        NSLog(@"\n%@", error);
    }];
}

/**Before数据
 * URL：stories/before/日期
 * 请求Before数据
 * 返回NSDictionary
 * 注意：不做对dictionary的进一步操作
 */
- (void)BeforeDate:(NSString *)date
               Add:(void(^)(NSDictionary *))add{
    /**网络请求*/
    [self
     GET:[NSString stringWithFormat:@"stories/before/%@", date]
     parameters:nil
     headers:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n%@ - %s - success", [self class], __func__);
        NSLog(@"\n%@", responseObject);
        
        /**得到数据就回掉*/
        add(responseObject);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n%@ - %s - failure", [self class], __func__);
        NSLog(@"\n%@", error);
    }];
}

/**News数据
 * URL：story-extra/新闻id
 * 请求News数据
 * 返回NSDictionary
 * 如果得不到数据，告诉应尝试Request
 * 注意：不做对dictionary的进一步操作
 */
- (void)NewsID:(NSInteger)ID
          HTTP:(void(^)(NSDictionary *))show
    tryRequest:(void(^)(void))request{
    /**网络请求*/
    [self
     GET:[NSString stringWithFormat:@"story-extra/%ld", ID]
     parameters:nil
     headers:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n%@ - %s - success", [self class], __func__);
        NSLog(@"\n%@", responseObject);
        
        /**HTTP数据加载*/
        show(responseObject);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n%@ - %s - failure", [self class], __func__);
        NSLog(@"\n%@", error);
        
        /**应该尝试request请求*/
        request();
    }];
}

@end
