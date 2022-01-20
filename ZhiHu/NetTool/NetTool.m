//
//  NetTool.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "NetTool.h"

static NetTool *net = nil;

@implementation NetTool

#pragma mark - 初始化方法

/**单例模块*/
- (instancetype)init{
    /**单例net*/
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        net = [super init];
        /**baseURL在头文件已说明*/
        NSURL *baseURL = [NSURL URLWithString:@"https://news-at.zhihu.com/api/3"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        net = [[NetTool alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    });
    return net;
}

/**单例模块*/
+ (NetTool *)shareTool{
    return [[self alloc] init];
}

/**单例模块*/
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        net = [super allocWithZone:zone];
    });
    return net;
}

/**单例模块*/
- (id)copyWithZone:(NSZone *)zone{
    return net;
}

/**单例模块*/
- (id)mutableCopyWithZone:(NSZone *)zone{
    return net;
}

#pragma mark - 网络请求

#pragma mark Latest

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

#pragma mark - Before

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

#pragma mark News

/**News数据
 * URL：news/文章id
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
     GET:[NSString stringWithFormat:@"news/%ld", ID]
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

#pragma mark - Extra

/**Extra数据请求
 * URL：story-extra/该新闻id
 * 请求Extra数据
 * 返回NSDictionary
 * 注意：不做对dictionary的进一步操作
 */
- (void)ExtraID:(NSInteger)ID
           Data:(void(^)(NSDictionary *))load{
    [self
     GET:[NSString stringWithFormat:@"story-extra/%ld", ID]
     parameters:nil
     headers:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n%@ - %s - success", [self class], __func__);
        NSLog(@"\n%@", responseObject);
        
        // 获得数据，回掉load
        load(responseObject);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n%@ - %s - failure", [self class], __func__);
        NSLog(@"\n%@", error);
    }];
}
@end
