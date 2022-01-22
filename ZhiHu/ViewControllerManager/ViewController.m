//
//  ViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - <MainDelegate>

/**得到id和url，跳转新闻中心模块*/
- (UIViewController *)VC_pushedFromCell_withID:(NSInteger)ID url:(NSString *)url{
    return [NewsViewController createWithDelegate:self ID:ID URL:url];
}

/**跳转到用户页*/
- (UIViewController *)VC_pushedFromHeadView{
    return UserViewController
            .Create_withDelegate(self);
}

/**得到单击了Banner的push页面，传出id和url*/
- (UIViewController *)VC_pushedFromBanner_withID:(NSInteger)ID url:(NSString *)url{
    return [NewsViewController createWithDelegate:self ID:ID URL:url];
}

@end
