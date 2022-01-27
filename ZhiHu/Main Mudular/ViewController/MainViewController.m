//
//  MainViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainViewController.h"

#import "UIView+Frame.h"

#import "SafeBarView.h"
#import "PageControl.h"
#import "BannerView.h"
#import "MainTableView.h"

#import "SourseStory.h"


#pragma mark - 模块封装

@interface MainViewController ()
<SourseStoryDelegate, BannerViewDelegate, SafeBarViewDelegate, MainTableViewDelegate>

/**SafeBar的顶视图*/
@property (nonatomic, strong) SafeBarView *safeView;

/**banner视图*/
@property (nonatomic, strong) BannerView *bannerView;

/**PageControl视图*/
@property (nonatomic, strong) PageControl *pageControl;

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
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 生命周期

/**加载视图，addSubview*/
- (void)loadView{
    [super loadView];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.view addSubview:self.safeView];
    
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.tableHeaderView = self.bannerView;
    
    [self.mainTableView addSubview:self.pageControl];
}

/**自己的视图已经加载*/
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.safeView reloadData];
    
    /**网络请求，加载数据*/
    [self.sourse
     getLastestTop:^{
        self.pageControl.numberOfPages = self.sourse.topStories.stories.count;
        [self.bannerView reloadData];
    }
     Cell:^{
        [self.mainTableView reloadData];
    }];
}

/**视图将要出现，可以做一些内容反馈*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.safeView reloadData];
    
    [self.mainTableView reloadData];
    
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
        _safeView = [[SafeBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, StatusBarHeight + 50)];
        _safeView.delegate = self;
    }
    return _safeView;
}

/**banner懒加载*/
- (BannerView *)bannerView{
    if (_bannerView == nil) {
        CGFloat width = self.view.frame.size.width;
        _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _bannerView.dataSource = self.sourse;
        _bannerView.Banner_delegate = self;
        _bannerView.clipsToBounds = NO;
    }
    return _bannerView;
}

/**pageControl懒加载*/
- (PageControl *)pageControl{
    if (_pageControl == nil) {
        CGRect bRect = self.mainTableView.tableHeaderView.frame;
        CGRect rect = CGRectMake(0, 0, 160, 10);
        rect.origin.x = bRect.size.width - rect.size.width;
        rect.origin.y = bRect.size.height - rect.size.height - 15;
        _pageControl = [[PageControl alloc] initWithFrame:rect];
    }
    return _pageControl;
}

/**主页视图懒加载*/
- (MainTableView *)mainTableView{
    if (_mainTableView == nil) {
        /**创建，并且为group样式*/
        _mainTableView =
        [[MainTableView alloc]
            initWithFrame:CGRectMake
                 (0, self.safeView.bottom, self.view.width,
                  MainScreenHeight - self.safeView.height)
            style:UITableViewStyleGrouped];
        /**数据源代理将交给数据源处理*/
        _mainTableView.dataSource = self.sourse;
        _mainTableView.MainTableView_delegate = self;
    }
    return _mainTableView;
}

/**主页数据懒加载，代理交给自己*/
- (SourseStory *)sourse{
    if (_sourse == nil) {
        _sourse = [[SourseStory alloc] init];
        _sourse.delegate = self;
    }
    return _sourse;
}

#pragma mark - <SourseStoryDelegate>

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UITableViewCell *)SourseStory_CellForSourse:(Story *)story {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return story == nil ?
    [self.mainTableView getReusablePageCell] :
    [[[[[self.mainTableView getReusablePageCell]
     TitleWithtext:story.title]
      isWatched:story.watched]
     HintWithtext:story.hint]
     PictureWithURLString:story.image];
}

/**根据story去创建一个cell，如果没有story，则得到nil*/
- (UICollectionViewCell *)SourseStory_ItemForIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    DailyStories *top_stories = self.sourse.topStories;
    if (top_stories.stories.count == 0) {
        return [self.bannerView getReusableBannerCell:indexPath];
    }
    Story *aStory = top_stories.stories[indexPath.item];
    
    return [[[[self.bannerView getReusableBannerCell:indexPath]
            TitleWithText:aStory.title]
            HintWithText:aStory.hint]
            Picture_URLString:aStory.image];
}

#pragma mark - <BannerViewDelegate>

/**单击了cell传出indexpath*/
- (void)BannerView_tapAtIndexPath:(NSIndexPath *)indexPath{
    
    Story *aStory = [[self.sourse
                     DailyStories_atCellSection:indexPath.section]
                     StoryAtRow:indexPath.row];
    
    [self.navigationController
     pushViewController:[self.delegate
                         MainVC_pushedFromBanner_forID:aStory.ID
                         url:aStory.url]
     animated:YES];
}

/**已停止滑动*/
- (void)BannerView_endedScollAtIndexPath:(NSIndexPath *)indexPath{
    self.pageControl.currentPage = indexPath.item;
}

#pragma mark - <MainTableViewDelegate>

/**得到section，当显示footer时调用*/
- (void)MainTableView_WillDisplaySection:(NSInteger)section{
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
- (NSString *)MainTableView_titleForSection:(NSInteger)section{
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
- (void)MainTableView_selectedAtIndexPath:(NSIndexPath *)indexPath{
    Story *aStory = [[self.sourse
                     DailyStories_atCellSection:indexPath.section]
                     StoryAtRow:indexPath.row];
    aStory.watched = YES;
    
    [self.navigationController
     pushViewController:[self.delegate
                         MainVC_pushedFromCell_forID:aStory.ID
                         URL:aStory.url]
     animated:YES];
}

/**滑动了TableView*/
- (void)MainTableView_scrollingWithOffset:(CGPoint)offset{
    
    BannerCell *cell = self.bannerView.visibleCells[0];
    CGRect pRect = cell.pictureView.frame;
    pRect.origin.y = offset.y;
    pRect.size.height = cell.contentView.frame.size.height - offset.y;
    
    cell.pictureView.frame = pRect;
}

#pragma mark - <SafeBarViewDelegate>

/**单击safeBar时会调用此代理*/
- (void)safeBarTaped{
    /**应该跳转到新闻页*/
    [self.mainTableView setContentOffset:CGPointMake(0,0) animated:YES];
}

/**单击imageview时会调用此代理*/
- (void)safeBarImageViewTaped{
    /**应该跳转到用户页*/
    [self.navigationController pushViewController:[self.delegate MainVC_pushedForTapHeadView] animated:YES];
}

/**头像的请求*/
- (NSString *)safeBarNeedHeadImage{
    return [self.delegate MainVC_needHeadImage];
}

@end
