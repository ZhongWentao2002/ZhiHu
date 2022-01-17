//
//  MainViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainViewController.h"

#import "SafeBarView.h"

#import "MainTableView.h"

#import "SourseStory.h"

#pragma mark - 模块封装

@interface MainViewController ()
<SourseStoryDelegate, MainTableViewDelegate>

/**SafeBar的顶视图*/
@property (nonatomic, strong) SafeBarView *safeView;

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

/**链式创建方法*/
+ (MainViewController *(^)(UIViewController <MainDelegate> *))Create_withDelegate{
    return ^MainViewController *(UIViewController <MainDelegate> *t){
        MainViewController *vc = [[MainViewController alloc] init];
        vc.delegate = t;
        return vc;
    };
}

#pragma mark - 生命周期

/**加载视图，addSubview*/
- (void)loadView{
    [super loadView];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.view addSubview:self.safeView];
    
    [self.view addSubview:self.mainTableView];
}

/**自己的视图已经加载*/
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    /**网络请求，加载数据*/
    [self.sourse getLastest:^{
            [self.mainTableView reloadData];
    }];
}

/**视图将要出现，可以做一些内容反馈*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    /*---------------------------------------待实现-----------------------------------------**/
    
}

/**视图已经出现，做banner页启动timer用*/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    /*---------------------------------------待实现-----------------------------------------**/
    
}

#pragma mark - 懒加载

/**safeView懒加载*/
- (SafeBarView *)safeView{
    if (_safeView == nil) {
        /**计算可用高度*/
        _safeView = [[SafeBarView alloc] init];
        CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGRect tvRect = self.view.frame;
        tvRect.size.height = statusHeight + 37;
        _safeView.frame = tvRect;
    }
    return _safeView;
}

/**主页视图懒加载*/
- (MainTableView *)mainTableView{
    if (_mainTableView == nil) {
        /**计算可靠高度，留足40给hearderView*/
        CGRect tvRect = self.view.frame;
        CGRect safeRect = self.safeView.frame;
        tvRect.origin.y = safeRect.origin.y + safeRect.size.height;
        tvRect.size.height -= tvRect.origin.y;
        _mainTableView = [[MainTableView alloc] initWithFrame:tvRect style:UITableViewStyleGrouped];
        /**数据源代理将交给数据源处理*/
        _mainTableView.dataSource = self.sourse;
        _mainTableView.mainTV_delegate = self;
    }
    return _mainTableView;
}

/**主页数据懒加载，代理交给自己*/
- (SourseStory *)sourse{
    if (_sourse == nil) {
        _sourse = SourseStory.Create().Self_Delegate(self);
    }
    return _sourse;
}

#pragma mark - <SourseStoryDelegate>

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UITableViewCell *)tableView:(UITableView *)tableView
                     ForSourse:(Story * _Nullable)story{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return story == nil ?
        self.mainTableView.ReusablePageCell():
        self.mainTableView.ReusablePageCell()
            .Title_text(story.title)
            .Hint_text(story.hint)
            .Picture_URLString(story.image);
}

#pragma mark - <MainTableViewDelegate>

/**将WillDisplayCell的indexpath转交出去，当显示footer时调用*/
- (void)MainTableViewWillDisplaySection:(NSInteger)section{
    /**是否正在网络请求*/
    static BOOL Loading = NO;
    /**如果没有网络请求才判断*/
    if (Loading == NO) {
        if (section == self.sourse.sectionStories.count - 1){
            Loading = YES;
            [self.sourse getBefore:^{
                [self.mainTableView reloadData];
                Loading = NO;
            }];
        }
    }
}

/**获取indexPath的date*/
- (NSString *)titleForSection:(NSInteger)section{
    /**返回YYYYMMDD日期*/
    if (section == self.sourse.sectionStories.count) {
        return nil;
    }
    NSString *sectionDate = self.sourse.sectionStories[section].date;
    NSInteger month = [[sectionDate substringWithRange:NSMakeRange(4, 2)] integerValue];
    NSInteger day = [[sectionDate substringFromIndex:6] integerValue];
    return [NSString stringWithFormat:@"%ld月%ld日", month, day];
}

/**得到单击事件，应执行跳转操作*/
- (void)tapAtIndexPath:(NSIndexPath *)indexPath{
    Story *aStory = self.sourse.DailyStories_inSection(indexPath.section).Story_inRow(indexPath.row);
    [self.navigationController pushViewController:[self.delegate VC_pushedFromCell_withID:aStory.ID url:aStory.url] animated:YES];
}

@end