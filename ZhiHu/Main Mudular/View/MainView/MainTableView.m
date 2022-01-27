//
//  MainTableView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainTableView.h"

/**顶部底部视图的高*/
#define HeadFoodHeight 20

/**cell的高*/
#define CellHeight 140

@implementation MainTableView

#pragma mark - 初始化方法

/**init返回fullScreen创建方法*/
- (instancetype)init {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    CGRect fullScreen = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
    return [self initWithFrame:fullScreen];
}

/**重写initWithFrame*/
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return [self initWithFrame:frame style:UITableViewStyleGrouped];
}

/**通过基本操作方法得知自己的尺寸，style类型应为group*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
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
    }
    return self;
}

#pragma mark - PageCell相关的方法

/**得到复用池PageCell*/
- (PageCell *)getReusablePageCell {
    PageCell *cell = [self dequeueReusableCellWithIdentifier:PageCellReuseIdentifier];
    /**如果资源池无数据则需要创建*/
    if (cell == nil) {
        cell = [PageCell CreateReusableCell];
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>

// Display customization

/**将要显示尾部的时候调用*/
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.MainTableView_delegate MainTableView_WillDisplaySection:section];
}

// Variable height

/**每一个cell的高度，140*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return CellHeight;
}

// Section

/**因为第一行没有数据，但这个会把view高度给干掉，需要注意*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return section == 0 ? 0 : HeadFoodHeight;
}

/**因为要显示日期，所以自定义headerview*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    if (section == 0) {
        return nil;
    }
    /**因为x,y,width会自动确认，只需要传入高，但高会被代理干掉*/
    UIView *headerView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, 0, HeadFoodHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    /**显示日期的Label采用不存在的frame显示*/
    UILabel *dateLab = [[UILabel alloc]
                        initWithFrame:CGRectMake(0, -10, 80, HeadFoodHeight)];
    dateLab.backgroundColor = [UIColor whiteColor];
    /**label显示的内容相关*/
    dateLab.textColor = [UIColor grayColor];
    dateLab.textAlignment = NSTextAlignmentRight;
    dateLab.text = [self.MainTableView_delegate MainTableView_titleForSection:section];
    
    [headerView addSubview:dateLab];
    return headerView;
}

/**因为要刷新表单，所以自定义FooterView*/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSLog(@"\n%@ - %s", [self class], __func__);

    /**采用一个clearColor在底层，一个白色imageView在顶层，实现假线*/
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, HeadFoodHeight)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height - 5)];
    img.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:img];
    return headerView;
}

/**选中后应跳转页面，cell的颜色改变将由我们操作，我们提供单击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    PageCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.titleLab.textColor = [UIColor grayColor];
    
    [self.MainTableView_delegate MainTableView_selectedAtIndexPath:indexPath];
}

/**scroll正在滚动的方法 banner应该放大*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= 0) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        NSLog(@"\n\t- %@", NSStringFromCGPoint(scrollView.contentOffset));
        
        [self.MainTableView_delegate MainTableView_scrollingWithOffset:scrollView.contentOffset];
    }
}

@end
