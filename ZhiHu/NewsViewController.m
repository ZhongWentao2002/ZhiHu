//
//  NewsViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import "NewsViewController.h"

#include "News.h"

@interface NewsViewController ()

/**持有一个webView*/
@property (nonatomic) WKWebView *webView;

/**持有一个数据源*/
@property (nonatomic, strong) News *sourse;

@end

@implementation NewsViewController


#pragma mark - 初始化方法

/**基本初始化方法，外部不可用使用*/
- (instancetype)init{
    self = [super init];
    NSLog(@"\n%@ - %s", [self class], __func__);
    if (self) {
        self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

/**链式创建方法*/
+ (NewsViewController *(^)(UIViewController <NewsDelegate> *))Create_withDelegate{
    return ^NewsViewController *(UIViewController <NewsDelegate> *t){
        NewsViewController *vc = [[NewsViewController alloc] init];
        vc.delegate = t;
        return vc;
    };
}

/**创建时需要id*/
- (NewsViewController *(^)(NSInteger))ID_Integer{
    return ^NewsViewController *(NSInteger num){
        
        return self;
    };
}

/**创建时需要url*/
- (NewsViewController *(^)(NSURL *))URL_String{
    return ^NewsViewController *(NSURL *url){
        
        return self;
    };
}


#pragma mark - 生命周期

/**视图将要出现*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
}

#pragma mark - 懒加载



@end
