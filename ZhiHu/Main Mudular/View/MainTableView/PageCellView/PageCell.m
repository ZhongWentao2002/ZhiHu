//
//  PageCell.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "PageCell.h"

#import <UIImageView+AFNetworking.h>

#pragma mark - PageCell方法实现

@implementation PageCell

#pragma mark - 初始化

/**采用default状态，@“PageCell”复用*/
- (instancetype)init {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageCellReuseIdentifier];
}

/**采用default状态，@“PageCell”复用*/
- (instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageCellReuseIdentifier];
}

/**重写注册cell的方法
 * 采用复用池机制时调用
 * 将固定除titleHeight的布局属性
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        /**自己被选中后不显示任何东西*/
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/**创建复用池cell*/
+ (PageCell *)CreateReusableCell{
    /**创建资源池类型*/
    PageCell *cell = [[PageCell alloc]
                      initWithStyle:UITableViewCellStyleDefault
                      reuseIdentifier:PageCellReuseIdentifier];
    /**设置基础宽度*/
    cell.frame = CGRectMake(0, 0, MainScreenWidth, 0);
    /**加载到自己的contentView上*/
    [cell.contentView addSubview:cell.pictureView];
    [cell.contentView addSubview:cell.titleLab];
    [cell.contentView addSubview:cell.hintLab];
    /**初始化状态*/
    return cell.Default;
}

#pragma mark - 赋值

/**自定义title的文字*/
- (PageCell *)TitleWithtext:(NSString *)str{
    NSLog(@"\n%@ - %s", [self class], __func__);
 
    self.titleLab.text = str;
    self.titleLab.backgroundColor = [UIColor clearColor];
    
    // 计算高度
    CGRect tRect = self.titleLab.frame;
    /**取得字典*/
    NSDictionary *font =
        @{NSFontAttributeName :
              [UIFont boldSystemFontOfSize:self.titleLab.font.pointSize]};
    /*计算cgrect(0,0,width,autoHeight)*/
    CGRect rect = [self.titleLab.text
                   boundingRectWithSize:CGSizeMake(tRect.size.width, 0)
                                options:NSStringDrawingUsesFontLeading
                                       |NSStringDrawingUsesLineFragmentOrigin
                             attributes:font context:nil];
    tRect.size.height = rect.size.height;
    self.titleLab.frame = tRect;
    
    // 重新布局hint的高度
    CGRect hRect = self.hintLab.frame;
    hRect.origin.y = tRect.origin.y + tRect.size.height;
    self.hintLab.frame = hRect;
    return self;
}

/**title文字颜色，NO黑，YES灰*/
- (PageCell *)isWatched:(BOOL)watched{
    if (watched == 0) {
        self.titleLab.textColor = [UIColor blackColor];
    }
    else{
        self.titleLab.textColor = [UIColor grayColor];
    }
    return self;
}

/**自定义hint的文字*/
- (PageCell *)HintWithtext:(NSString *)str{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    self.hintLab.text = str;
    self.hintLab.textColor = [UIColor grayColor];
    self.hintLab.backgroundColor = [UIColor clearColor];
    return self;
}

/**自定义picture*/
- (PageCell *)PictureWithURLString:(NSString *)url{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.pictureView
     setImageWithURL:[NSURL URLWithString:url]
     placeholderImage:[UIImage imageNamed:@"ImageDefault"]];
    
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
- (PageCell *)Default{
    self.titleLab.text = @"";
    self.titleLab.backgroundColor = [UIColor darkGrayColor];
    
    self.hintLab.text = @"";
    self.hintLab.backgroundColor = [UIColor grayColor];
    
    self.pictureView.image = [UIImage imageNamed:@"ImageDefault"];
    return self;
}

#pragma mark - 懒加载

- (UIImageView *)pictureView {
    if (_pictureView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
     
        _pictureView = [[UIImageView alloc] init];
        _pictureView.backgroundColor = [UIColor grayColor];
        _pictureView.image = [UIImage imageNamed:@"ImageDefault"];
        
        _pictureView.width = _pictureView.height = 100;
        _pictureView.right = self.contentView.right - 20;
        _pictureView.top = self.contentView.top + 20;
    }
    return _pictureView;
}

/**懒加载titleLab*/
- (UILabel *)titleLab{
    if (_titleLab == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
     
        _titleLab = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
        _titleLab.backgroundColor = [UIColor darkGrayColor];
        
        [[[_titleLab
         Left_toPointX:self.left offset:15]
         Right_toPointX:self.pictureView.left offset:15]
         Top_toPointY:self.pictureView.top offset:0];
        _titleLab.height = 70;
    }
    return _titleLab;
}

/**懒加载hintLab*/
- (UILabel *)hintLab{
    if (_hintLab == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _hintLab = [[UILabel alloc] init];
        _hintLab.font = [UIFont systemFontOfSize:16];
        _hintLab.backgroundColor = [UIColor grayColor];
        
        [_hintLab Top_toPointY:self.titleLab.bottom offset:10];
        _hintLab.x = self.titleLab.x;
        _hintLab.width = self.titleLab.width;
        _hintLab.height = 30;
    }
    return _hintLab;
}


@end
