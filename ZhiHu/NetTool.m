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

@end
