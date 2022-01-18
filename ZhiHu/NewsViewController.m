//
//  NewsViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import "NewsViewController.h"

#import "NewsView.h"

#import "News.h"

@interface NewsViewController ()

/**持有一个webView*/
@property (nonatomic) NewsView *webView;

/**持有一个数据源*/
@property (nonatomic, strong) News *sourse;

@end

@implementation NewsViewController


#pragma mark - 初始化方法

- (instancetype)initWithID:(NSInteger)ID URL:(NSString * _Nullable )url{
    self = [super init];
    if (self) {
        self.sourse = News.Create_withID(ID).URL_URLString(url);
    }
    return self;
}

/**创建的方法*/
+ (NewsViewController *)createWithDelegate:(UIViewController <NewsDelegate> *)delegate
                                        ID:(NSInteger)ID URL:(NSString * _Nullable )url{
    NewsViewController *vc = [[NewsViewController alloc] initWithID:ID URL:url];
    vc.delegate = delegate;
    return vc;
}


#pragma mark - 生命周期

/**加载视图*/
- (void)loadView{
    [super loadView];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.view addSubview:self.webView];
}

/**视图将要出现*/
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.sourse
     getNewsHTTP:^{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.sourse.url]]];
        
        }
     Request:^(NSString * theURL) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:theURL]]];
    }];
}

#pragma mark - 懒加载

/**懒加载全屏Webview*/
- (NewsView *)webView{
    if (_webView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _webView = [[NewsView alloc] initWithFrame:self.view.frame];
        _webView.backgroundColor = [UIColor blueColor];
    }
    return _webView;
}

/**懒加载sourse*/
- (News *)sourse{
    if (_sourse == nil) {
        _sourse = [[News alloc] init];
    }
    return _sourse;
}

@end
