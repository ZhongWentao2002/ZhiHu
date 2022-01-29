//
//  News.m
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

#import "News.h"

#pragma mark - 方法实现

@implementation News

#pragma mark - 链式

/**Create操作*/
+ (News *)CreateWithID:(NSInteger)ID{
    News *aNew = [[News alloc] init];
    aNew.ID = ID;
    return aNew;
}

#pragma mark - 方法

/**网络请求*/
- (void)getNewsHTTP:(void(^)(void))loadHTTP Request:(void(^)(NSString *))loadRequest{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    /**网络请求*/
    [[NetTool shareTool]
     NewsID:self.ID
     HTTP:^(NSDictionary * _Nonnull dic) {
        /**HTTP请求成功*/
        self.body = dic[@"body"];
        self.css = dic[@"css"][0];
        self.image = dic[@"image"];
        self.image_hue = dic[@"image_hue"];
        self.js = dic[@"js"][0];
        self.title = dic[@"title"];
        self.url = dic[@"url"];
        
        loadHTTP();
        }
     tryRequest:^{
        /**将url交还回去，如果是nil也交还*/
        loadRequest(self.url);
    }];
}

@end
