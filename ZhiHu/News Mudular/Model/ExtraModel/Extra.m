//
//  Extra.m
//  ZhiHu
//
//  Created by SSR on 2022/1/20.
//

#import "Extra.h"

@implementation Extra

#pragma mark - 初始化方法

/**类方法初始化*/
+ (Extra *)CreateWithID:(NSInteger)ID {
    Extra *data = [[Extra alloc] init];
    data.ID = ID;
    data.comments = 0;
    data.popularity = 0;
    return data;
}

/**得到网络请求*/
- (void)getExtra:(void(^)(void))load{
    [[NetTool shareTool]
     ExtraID:self.ID
     Data:^(NSDictionary * _Nonnull dic) {
        self.comments = [dic[@"comments"] longValue];
        self.popularity = [dic[@"popularity"] longValue];
        load();
    }];
}

@end
