//
//  NewsViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import "NewsViewController.h"

#import "NewsView.h"
#import "ExtraView.h"

#import "News.h"
#import "Extra.h"

#pragma mark - 模块封装

@interface NewsViewController ()
<ExtraViewDelegate>

#pragma mark - Web

/**持有一个webView*/
@property (nonatomic, strong) NewsView *webView;

/**持有一个数据源*/
@property (nonatomic, strong) News *newsSourse;

#pragma mark - Extra

/**持有一个view*/
@property (nonatomic, strong) ExtraView *extraView;

/**持有一个数据源*/
@property (nonatomic, strong) Extra *extraSourse;

@end

#pragma mark - NewsViewController方法实现

@implementation NewsViewController


#pragma mark - 初始化方法

- (instancetype)initWithID:(NSInteger)ID URL:(NSString * _Nullable )url{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.newsSourse = News.Create_withID(ID).URL_URLString(url);
        
        self.extraSourse = Extra.Create_withID_Integer(ID);
    }
    return self;
}

/**创建的方法*/
+ (NewsViewController *)createWithDelegate:(UIViewController <NewsDelegate> *)delegate
                                        ID:(NSInteger)ID URL:(NSString * _Nullable )url{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    NewsViewController *vc = [[NewsViewController alloc] initWithID:ID URL:url];
    vc.delegate = delegate;
    
    vc.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return vc;
}


#pragma mark - 生命周期

/**加载视图*/
- (void)loadView{
    [super loadView];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.view addSubview:self.extraView];
    [self.view addSubview:self.webView];
}

/**视图将要出现*/
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.newsSourse
     getNewsHTTP:^{
        // HTTP
        NSLog(@"\n%s - HTTP", __func__);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsSourse.url]]];
        
        }
     Request:^(NSString * theURL) {
        // Request
        NSLog(@"\n%s - Request", __func__);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:theURL]]];
    }];
    
    [self.extraSourse
     getExtra:^{
        //得到数据
        
    }];
}

#pragma mark - 懒加载

/**懒加载全屏Webview*/
- (NewsView *)webView{
    if (_webView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGRect viewRect = self.view.frame;
        CGRect eRect = self.extraView.frame;
        CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        viewRect.origin.y = statusHeight;
        viewRect.size.height -= viewRect.origin.y + eRect.size.height;
        
        _webView = [[NewsView alloc] initWithFrame:viewRect];
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

/**懒加载extraView */
- (ExtraView *)extraView{
    if (_extraView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGRect viewRect = self.view.frame;
        CGRect rect = CGRectMake(0, 0, viewRect.size.width, 70);
        rect.origin.y = viewRect.size.height - rect.size.height;
        _extraView = [[ExtraView alloc] initWithFrame:rect];
    }
    return _extraView;
}

#pragma mark - <UIControlEvents>

/**单击了返回按钮*/
- (void)ExtraView_tapBackItem{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**单击了评论按钮*/
- (void)ExtraView_tapCommentItem{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    /**----------------------------待实现----------------------------*/
}

/**单击了点赞按钮*/
- (void)ExtraView_tapPopuliarItem{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    
}

/**单击了收藏按钮*/
- (void)ExtraView_tapCollectItem{
    NSLog(@"\n%@ - %s", [self class], __func__);

    
}

/**单击了转发按钮*/
- (void)ExtraView_tapRelayItem{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    /**----------------------------待实现----------------------------*/
}

@end
