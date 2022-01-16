//
//  MainViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainViewController.h"

#import "MainTableView.h"

#import "SourseStory.h"

#pragma mark - 模块封装

@interface MainViewController ()
<SourseStoryDelegate>

/**主页的视图*/
@property (nonatomic, strong) MainTableView *mainTableView;

/**主页的数据*/
@property (nonatomic, copy) SourseStory <UITableViewDataSource> *sourse;

@end

#pragma mark - 方法实现

@implementation MainViewController

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

/**主页视图懒加载*/
- (MainTableView *)mainTableView{
    if (_mainTableView == nil) {
        /**计算可靠高度，留足40给hearderView*/
        CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGRect tvRect = self.view.frame;
        tvRect.origin.y += statusHeight + 40;
        tvRect.size.height -= tvRect.origin.y;
        _mainTableView = [[MainTableView alloc] initWithFrame:tvRect style:UITableViewStyleGrouped];
        /**数据源代理将交给数据源处理*/
        _mainTableView.dataSource = self.sourse;
    }
    return _mainTableView;
}

/**主页数据懒加载*/
- (SourseStory *)sourse{
    if (_sourse == nil) {
        _sourse = [[SourseStory alloc] initWithDelegate:self];
    }
    return _sourse;
}

#pragma mark - <SourseStoryDelegate>

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UITableViewCell *)tableView:(UITableView *)tableView
                     ForSourse:(Story * _Nullable)story{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return story == nil ? self.mainTableView.cellDefault() : self.mainTableView.cellDefault().title(story.title).hint(story.hint).picture(story.image);
}

/**去寻找title所需要的高度*/
- (double)heightForTitle:(NSString *)title{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return 80;
}

@end
