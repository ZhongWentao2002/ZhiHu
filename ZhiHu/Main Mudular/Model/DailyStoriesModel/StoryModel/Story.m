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
        self.watched = NO;
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
        self.watched = NO;
    }
    return self;
}

@end
