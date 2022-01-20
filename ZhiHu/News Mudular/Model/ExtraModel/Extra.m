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
+ (Extra *(^)(NSInteger))Create_withID_Integer{
    return ^Extra *(NSInteger ID){
        Extra *data = [[Extra alloc] init];
        data.ID = ID;
        data.comments = 0;
        data.popularity = 0;
        return data;
    };
}

/**comments*/
- (Extra *(^)(NSInteger))Comments_Integer{
    return ^Extra *(NSInteger commen){
        self.comments = commen;
        return self;
    };
}

/**popularity*/
- (Extra *(^)(NSInteger))Popularity_Integer{
    return ^Extra *(NSInteger popular){
        self.popularity = popular;
        return self;
    };
}

/**得到网络请求*/
- (void)getExtra:(void(^)(void))load{
    [[NetTool shareTool]
     ExtraID:self.ID
     Data:^(NSDictionary * _Nonnull dic) {
        self.Comments_Integer([dic[@"comments"] longValue])
            .Popularity_Integer([dic[@"poppularity"] longValue]);
        load();
    }];
}

@end
