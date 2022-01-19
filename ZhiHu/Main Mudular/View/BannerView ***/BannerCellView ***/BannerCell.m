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

/**注册时，会通过这个实例化*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        NSLog(@"\n]t%@", NSStringFromCGRect(frame));
        
        [self addSubview:self.pictureView];
        [self addSubview:self.hintLab];
        [self addSubview:self.titleLab];
    }
    return self;
}

/**绘制内部控件*/
- (BannerCell *(^)(CGRect))CellDrawRect{
    return ^BannerCell *(CGRect cellRect){
        self.pictureView.frame = cellRect;
        
        
        
        return self;
    };
}

#pragma mark - 懒加载

/**懒加载pictureView，以免bug*/
- (UIImageView *)pictureView{
    if (_pictureView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageDefault"]];
        _pictureView.frame = self.contentView.frame;
        _pictureView.backgroundColor = [UIColor grayColor];
    }
    return _pictureView;
}

/**懒加载titleLab*/
- (UILabel *)titleLab{
    if (_titleLab == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
     
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = self.titleRect;
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
        _titleLab.backgroundColor = [UIColor darkGrayColor];
    }
    return _titleLab;
}

/**懒加载hintLab*/
- (UILabel *)hintLab{
    if (_hintLab == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _hintLab = [[UILabel alloc] init];
        _hintLab.frame = self.hintRect;
        _hintLab.font = [UIFont systemFontOfSize:16];
        _hintLab.backgroundColor = [UIColor grayColor];
    }
    return _hintLab;
}

#pragma mark - 链式编程

/**自定义title的文字*/
- (BannerCell *(^)(NSString *))Title_text{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^BannerCell *(NSString *str){
        self.titleLab.text = str;
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
                                 attributes:font context:nil];
        tRect.size.height = rect.size.height;
        self.titleLab.frame = tRect;
        
        // 重新布局hint的高度
        CGRect hRect = self.hintLab.frame;
        hRect.origin.y = tRect.origin.y + tRect.size.height;
        self.hintLab.frame = hRect;
        return self;
    };
}

/**自定义hint的文字*/
- (BannerCell *(^)(NSString *))Hint_text{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^BannerCell *(NSString *str){
        self.hintLab.text = str;
        self.hintLab.textColor = [UIColor grayColor];
        self.hintLab.backgroundColor = [UIColor clearColor];
        return self;
    };
}

/**自定义picture*/
- (BannerCell *(^)(NSString *))Picture_URLString{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^BannerCell *(NSString *url){
        [self.pictureView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ImageDefault"]];
        return self;
    };
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
- (BannerCell *(^)(void))Default{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^BannerCell *(){
        self.titleLab.text = @"";
        self.titleLab.backgroundColor = [UIColor darkGrayColor];
        
        self.hintLab.text = @"";
        self.hintLab.backgroundColor = [UIColor grayColor];
        
        self.pictureView.image = [UIImage imageNamed:@"ImageDefault"];
        return self;
    };
}

@end

#pragma mark - BannerCell (CGRect)方法实现

@implementation BannerCell (CGRect)

#pragma mark - 懒加载

/**hint的Rect*/
- (CGRect)hintRect{
    static BOOL hadMake = NO;
    static CGFloat x, y, width, height;
    if (hadMake == NO) {
        CGRect aRect = self.contentView.frame;
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGFloat content = 10;
        CGRect rect = CGRectMake(content, 0, aRect.size.width - 2 * content, 40);
        rect.origin.y = aRect.size.height - rect.size.height;
    }
    return CGRectMake(x, y, width, height);
}

/**title的Rect*/
- (CGRect)titleRect{
    static BOOL hadMake = NO;
    static CGFloat x, y, width, height;
    if (hadMake == NO) {
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGFloat content = 15;
        height = 70;
        x = content;
        y = self.pictureView.frame.origin.y;
        width = self.pictureView.frame.origin.x - 1.5 * content;
    }
    return CGRectMake(x, y, width, height);
}

@end
