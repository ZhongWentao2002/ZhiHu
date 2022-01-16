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
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        /**自己被选中后不显示任何东西*/
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**配置自己的数据为无数据状态*/
        self.Default();
        /**加载到自己的contentView上*/
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.hintLab];
        [self.contentView addSubview:self.pictureView];
        /**高度数据初始化*/
        
    }
    return self;
}

#pragma mark - 链式编程

/**无数据状态
 * 这种状态将存在于 加载数据前 和 无限滚动加载数据前
 * 复用池机制将自动调用一次
 * 请在与复用池匹配的else中手动调用一次
 *
 * 数据：titleLab显示空文本，灰色，单行灰
 * hintlab显示空文本，灰色
 * backgroundColor
 */
- (PageCell *(^)(void))Default{
    return ^PageCell *(){
        self.titleLab.text = @"";
        self.titleLab.backgroundColor = [UIColor grayColor];
        self.hintLab.text = @"";
        self.hintLab.backgroundColor = [UIColor grayColor];
        self.pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageDefault"]];
        return self;
    };
}

/**自定义title的文字*/
- (PageCell *(^)(NSString *))title{
    return ^PageCell *(NSString *str){
        self.titleLab.text = str;
        return self;
    };
}

/**自定义hint的文字*/
- (PageCell *(^)(NSString *))hint{
    return ^PageCell *(NSString *str){
        self.hintLab.text = str;
        return self;
    };
}

/**自定义picture*/
- (PageCell *(^)(NSString *))picture{
    return ^PageCell *(NSString *url){
        self.pictureView;
        return self;
    };
}

@end
