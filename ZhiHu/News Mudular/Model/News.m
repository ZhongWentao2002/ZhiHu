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
+ (News *(^)(NSInteger))Create_withID{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSInteger ID){
        News *aNew = [[News alloc] init];
        aNew.ID = ID;
        return aNew;
    };
}

/**body赋值*/
- (News *(^)(NSString *))Body_HTTPString{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSString *http){
        self.body = http;
        return self;
    };
}

/**css赋值*/
- (News *(^)(NSArray *))CSS_URLArray{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSArray *cssA){
        NSString *css = cssA[0];
        self.css = css;
        return self;
    };
}

/**image赋值*/
- (News *(^)(NSString *))Image_URLString{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSString *url){
        self.image = url;
        return self;
    };
}

/**image_hue赋值*/
- (News *(^)(NSString *))Image_hue_String{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSString *img_hue){
        self.image_hue = img_hue;
        return self;
    };
}

/**js赋值*/
- (News *(^)(NSArray *))JS_URLArray{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSArray *jsA){
        NSString *js = jsA[0];
        self.js = js;
        return self;
    };
}

/**title赋值*/
- (News *(^)(NSString *))Title_String{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSString *title){
        self.title = title;
        return self;
    };
}

/**url赋值*/
- (News *(^)(NSString *))URL_URLString{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^News *(NSString *url){
        self.url = url;
        return self;
    };
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
        self.Body_HTTPString(dic[@"body"])
            .CSS_URLArray(dic[@"css"])
            .Image_URLString(dic[@"image"])
            .Image_hue_String(dic[@"image_hue"])
            .JS_URLArray(dic[@"js"])
            .Title_String(dic[@"title"])
            .URL_URLString(dic[@"url"]);
        loadHTTP();
        }
     tryRequest:^{
        /**将url交还回去，如果是nil也交还*/
        loadRequest(self.url);
    }];
}

@end
