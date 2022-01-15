//
//  PageCell.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "PageCell.h"

@implementation PageCell

/**重写注册cell的方法
 * 采用复用池机制时调用
 * 将固定除titleHeight的布局属性
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        /**选中后不显示任何东西*/
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**加载到自己的contentView上*/
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.hintLab];
        [self.contentView addSubview:self.pictureView];
        /**高度数据初始化*/
        
    }
    return self;
}

/**无数据状态
 * 这种状态将存在于 加载数据前 和 无限滚动加载数据前
 * 复用池机制将自动调用一次
 * 请在与复用池匹配的else中手动调用一次
 *
 * 数据：titleLab显示空文本，灰色，单行灰
 * hintlab显示空文本，灰色
 * backgroundColor
 */
- (void)cellDefault{
    self.titleLab.text = @"";
    self.titleLab.backgroundColor = [UIColor grayColor];
    self.hintLab.text = @"";
    self.hintLab.backgroundColor = [UIColor grayColor];
    self.pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageDefault"]];
}

@end
