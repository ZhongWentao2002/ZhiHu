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
        self.delegate = self;
    }
    return self;
}

#pragma mark - PageCell创建方法

/**链式创建*/
- (PageCell *(^)(void))create{
    return ^PageCell *(){
        static NSString *PageCellIdentify = @"PageCell";
        /**向资源池访问*/
        PageCell *aCell = [self dequeueReusableCellWithIdentifier:PageCellIdentify];
        /**如果资源池无数据则需要创建*/
        if (aCell == nil) {
            aCell = [[PageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageCellIdentify];
            aCell.frame = CGRectMake(0, 0, self.frame.size.width, 0);
        }
        else{
            aCell.Default();
        }
        return aCell;
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

/**选中后应跳转页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
}

@end
