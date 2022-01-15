//
//  MainViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainViewController.h"

#import "MainTableView.h"

#import "DailyStories.h"

@interface MainViewController ()

/**主页的视图*/
@property (nonatomic, strong) MainTableView *mainTableView;

@end

@implementation MainViewController

#pragma mark - 初始化方法

/**基本初始化方法，外部不可用使用*/
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**指定manageVC为自己代理，封装性良好*/
- (instancetype)initWithDelegate:(UIViewController <MainDelegate> *)manageVC{
    NSLog(@"\n%@ - %s", [self class], __func__);
    self = [self init];
    self.delegate = manageVC;
    return self;
}

#pragma mark - 生命周期

/**加载视图*/
- (void)loadView{
    [super loadView];
    NSLog(@"\n%@ - %s", [self class], __func__);
    [self.view addSubview:self.mainTableView];
}

/**自己的视图已经加载*/
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n%@ - %s", [self class], __func__);
}

/**视图将要出现，可以做一些内容反馈*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
}

/**视图已经出现，做banner页启动timer用*/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
}

#pragma mark - 懒加载
- (MainTableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[MainTableView alloc] init];
    }
    return _mainTableView;
}

@end
