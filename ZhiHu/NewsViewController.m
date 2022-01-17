//
//  NewsViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController


#pragma mark - 初始化方法

/**基本初始化方法，外部不可用使用*/
- (instancetype)init{
    self = [super init];
    NSLog(@"\n%@ - %s", [self class], __func__);
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
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

#pragma mark - 生命周期


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
