//
//  BannerCell.m
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import "BannerCell.h"

#import <UIImageView+AFNetworking.h>

#pragma mark - BannerCell方法实现

@implementation BannerCell

#pragma mark - 初始化

/**重写init*/
- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenWidth)];
}

/**注册时，会通过这个实例化*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        NSLog(@"\n\tBanner - Item%@", NSStringFromCGRect(frame));
        
        [self.contentView addSubview:self.pictureView];
        [self.contentView addSubview:self.hintLab];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

#pragma mark - 懒加载

/**懒加载pictureView，以免bug*/
- (UIImageView *)pictureView{
    if (_pictureView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageDefault"]];
        _pictureView.contentMode = UIViewContentModeScaleAspectFill;
        _pictureView.frame = self.contentView.frame;
        _pictureView.backgroundColor = [UIColor grayColor];
        
        _pictureView.x = _pictureView.y = 0;
        _pictureView.width = _pictureView.width = self.contentView.width;
    }
    return _pictureView;
}

/**懒加载hintLab*/
- (UILabel *)hintLab{
    if (_hintLab == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _hintLab = [[UILabel alloc] init];
        _hintLab.font = [UIFont systemFontOfSize:18];
        _hintLab.backgroundColor = [UIColor darkGrayColor];
        
        _hintLab.x = 15;
        _hintLab.height = 40;
        _hintLab.bottom = self.contentView.bottom - 15;
        [_hintLab Right_toPointX:self.contentView.width offset:15];
    }
    return _hintLab;
}

/**懒加载titleLab*/
- (UILabel *)titleLab{
    if (_titleLab == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
     
        _titleLab = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont boldSystemFontOfSize:25];
        _titleLab.backgroundColor = [UIColor orangeColor];
        
        _titleLab.x = self.hintLab.x;
        _titleLab.width = self.hintLab.width;
        _titleLab.height = 60;
        _titleLab.bottom = self.hintLab.top;
    }
    return _titleLab;
}

#pragma mark - 赋值

/**自定义title的文字*/
- (BannerCell *)TitleWithText:(NSString *)str{
    NSLog(@"\n%@ - %s", [self class], __func__);
    NSLog(@"\n\t%@", str);
    
    self.titleLab.text = str;
    self.titleLab.textColor = [UIColor whiteColor];
    self.titleLab.backgroundColor = [UIColor clearColor];
    
    // 计算高度
    CGRect tRect = self.titleLab.frame;
    /**取得字典*/
    NSDictionary *font =
        @{NSFontAttributeName : [UIFont boldSystemFontOfSize:self.titleLab.font.pointSize]};
    /*计算cgrect(0,0,width,autoHeight)*/
    CGRect rect = [self.titleLab.text
                   boundingRectWithSize:CGSizeMake(tRect.size.width, 0)
                                options:NSStringDrawingUsesFontLeading
                                       |NSStringDrawingUsesLineFragmentOrigin
                             attributes:font
                                context:nil];
    tRect.size.height = rect.size.height;
    tRect.origin.y = self.hintLab.frame.origin.y - rect.size.height;
    self.titleLab.frame = tRect;
    return self;
}

/**自定义hint的文字*/
- (BannerCell *)HintWithText:(NSString *)str{
    NSLog(@"\n%@ - %s", [self class], __func__);

    self.hintLab.text = str;
    self.hintLab.textColor = [UIColor whiteColor];
    self.hintLab.backgroundColor = [UIColor clearColor];
    return self;
}

/**自定义picture*/
- (BannerCell *)Picture_URLString:(NSString *)url{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.pictureView setImageWithURL:[NSURL URLWithString:url]
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
- (BannerCell *)Default{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    self.titleLab.text = @"";
    self.titleLab.backgroundColor = [UIColor orangeColor];
    
    self.hintLab.text = @"";
    self.hintLab.backgroundColor = [UIColor darkGrayColor];
    
    self.pictureView.image = [UIImage imageNamed:@"ImageDefault"];
    return self;
}

@end
