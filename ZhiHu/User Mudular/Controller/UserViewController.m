//
//  UserViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

#import "UserViewController.h"

#import "UserTopView.h"

#pragma mark - 被封装的模块

@interface UserViewController ()
<UserTopViewDelegate>

/**一个顶视图*/
@property (nonatomic, strong) UserTopView *topView;

@end

#pragma mark - 方法实现

@implementation UserViewController

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
+ (UserViewController *(^)(UIViewController <LoadDelegate> *))Create_withDelegate{
    return ^UserViewController *(UIViewController <LoadDelegate> * t){
        UserViewController *vc = [[UserViewController alloc] init];
        vc.delegate = t;
        return vc;
    };
}

#pragma mark - 生命周期

/**加载视图*/
- (void)loadView{
    [super loadView];
    [self.view addSubview:self.topView];
}

/**视图将要展示*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 懒加载

/**顶视图的懒加载*/
- (UserTopView *)topView{
    if (_topView == nil) {
        CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _topView = [[UserTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, statusHeight + 30)];
        _topView.delegate = self;
    }
    return _topView;
}

#pragma mark - <UserTopViewDelegate>

/**单击了返回按钮*/
- (void)UserTopView_tapBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
