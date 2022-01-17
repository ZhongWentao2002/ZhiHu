//
//  Story.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "Story.h"

#pragma mark - 方法实现

@implementation Story

#pragma mark - 初始化方法

/**Top类型字典转模型
 * Top类型字典至少包含如下：
 * title:NSString
 * hint:NSString
 * image:NSString
 * image_hue:NSString
 * url:NSString
 */
- (instancetype)initTopDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.title = dic[@"title"];
        self.hint = dic[@"hint"];
        self.image = dic[@"image"];
        self.image_hue = dic[@"image_hue"];
        self.ID = [dic[@"id"] longValue];
        self.url = dic[@"url"];
    }
    return self;
}

/**Cell类型字典转模型
 * Cell类型字典至少包含如下：
 * title:NSString
 * hint:NSString
 * image:NSArray -> NSString有nil情况
 * image_hue:NSString
 * url:NSString
 */
- (instancetype)initCellDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.title = dic[@"title"];
        self.hint = dic[@"hint"];
        NSArray *images = dic[@"images"];
        if (images) {
            self.image = images[0];
        }
        self.image_hue = dic[@"image_hue"];
        self.ID = [dic[@"id"] longValue];
        self.url = dic[@"url"];
    }
    return self;
}

#pragma mark - 链式编程

/**类方法创建*/
+ (Story *(^)(void))Create{
    return ^(){
        Story *aStory = [[Story alloc] init];
        return aStory;
    };
}

/**title赋值*/
- (Story *(^)(NSString *))Title_String{
    return ^(NSString *title){
        self.title = title;
        return self;
    };
}

/**hint赋值*/
- (Story *(^)(NSString *))Hint_String{
    return ^(NSString *hint){
        self.hint = hint;
        return self;
    };
}

/**image，根据Ary赋值*/
- (Story *(^)(NSArray *))Image_URLArray{
    return ^(NSArray *imgAry){
        self.image = (imgAry == nil ? nil : imgAry[0]);
        return self;
    };
}

/**image，根据具体url赋值*/
- (Story *(^)(NSString *))Image_URLString{
    return ^(NSString *imgURLStr){
        self.image = imgURLStr;
        return self;
    };
}

/**image_hue赋值*/
- (Story *(^)(NSString *))Image_hue_String{
    return ^(NSString *imghueStr){
        self.image_hue = imghueStr;
        return self;
    };
}

/**ID，根据传入数字的String得到Intager*/
- (Story *(^)(NSString *))ID_String{
    return ^(NSString *IDStr){
        self.ID = [IDStr intValue];
        return self;
    };
}

/**url赋值*/
- (Story *(^)(NSString *))URL_String{
    return ^(NSString *urlStr){
        self.url = urlStr;
        return self;
    };
}

@end
