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
    return NewsViewController.Create_withDelegate(self);
}

@end
