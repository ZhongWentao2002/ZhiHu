//
//  MainTableView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainTableView.h"

@implementation MainTableView

#pragma mark - 初始化方法

/**通过基本操作方法得知自己的尺寸，style类型应为group*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        /**将UITableView代理给自己*/
        self.delegate = self;
        /**不显示横条*/
        self.showsVerticalScrollIndicator = NO;
        /**不显示竖条*/
        self.showsHorizontalScrollIndicator = NO;
        /**不显示cell间线*/
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        /**加载banner页*/
        self.tableHeaderView = self.bannerView;
    }
    return self;
}

#pragma mark - 懒加载

/**banner页懒加载*/
- (BannerView *)bannerView{
    if (_bannerView == nil) {
        /**计算Banner页的大小*/
        CGFloat width = self.frame.size.width;
        _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, width, width) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        
        _bannerView.backgroundColor = [UIColor blueColor];
    }
    return _bannerView;
}

#pragma mark - PageCell相关的方法

/**复用机制得到Cell*/
- (PageCell *(^)(void))ReusablePageCell{
    return ^PageCell *(){
        return PageCell.ReusableCellFromSuperTableView(self);
    };
}

#pragma mark - <UITableViewDelegate>

// Display customization

/**将要显示尾部的时候调用*/
- (void)tableView:(UITableView *)tableView
willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.mainTV_delegate MainTableViewWillDisplaySection:section];
}

/**scroll正在滚动的方法 banner应该放大*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

// Variable height support

/**每一个cell的高度，140*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return 140;
}

// Section

/**因为第一行没有数据，但这个会把view高度给干掉，需要注意*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : 20;
}

/**因为要显示日期，所以自定义headerview*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    if (section == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, 80, 20)];
    dateLab.text = [self.mainTV_delegate titleForSection:section];
    dateLab.backgroundColor = [UIColor whiteColor];
    dateLab.textColor = [UIColor grayColor];
    dateLab.textAlignment = NSTextAlignmentRight;
    
    [headerView addSubview:dateLab];
    return headerView;
}

/**因为要刷新表单，所以自定义FooterView*/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 20)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:headerView.frame];
    img.backgroundColor = [UIColor whiteColor];
    CGRect imgRect = img.frame;
    imgRect.size.height = headerView.frame.size.height - 5;
    img.frame = imgRect;
    
    [headerView addSubview:img];
    return headerView;
}

/**选中后应跳转页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
}

@end
