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
        self.alwaysBounceVertical = NO;
        /**不显示竖条*/
        self.alwaysBounceHorizontal = NO;
    }
    return self;
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
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
}

// Variable height support

/**每一个cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return 150;
}

/**每一个header的高度
 * 测试
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return section == 0 ? 0 : 30;
}

/**每一个的尾部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return 30;
}

// Section

/**因为要显示日期，所以自定义headerview*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

/**测试*/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    headerView.backgroundColor = [UIColor greenColor];
    return headerView;
}

/**选中后应跳转页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
}

@end
