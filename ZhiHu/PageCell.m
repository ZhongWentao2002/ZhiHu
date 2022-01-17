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

#pragma mark - 初始化和布局

/**重写注册cell的方法
 * 采用复用池机制时调用
 * 将固定除titleHeight的布局属性
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        /**自己被选中后不显示任何东西*/
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**加载到自己的contentView上*/
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.hintLab];
        [self.contentView addSubview:self.pictureView];
        /**配置自己的数据为无数据状态*/
        self.Default();
        /**高度数据初始化*/
        
    }
    return self;
}


/**链式创建，如果有则直接拿，如果没有则创建，默认default状态*/
+ (PageCell *(^)(UITableView *))ReusableCellFromSuperTableView{
    
    return ^PageCell *(UITableView *superTableView){
        static NSString *PageCellIdentify = @"PageCell";
        /**向资源池访问*/
        PageCell *aCell = [superTableView dequeueReusableCellWithIdentifier:PageCellIdentify];
        /**如果资源池无数据则需要创建*/
        if (aCell == nil) {
            /**创建资源池类型*/
            aCell = [[PageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageCellIdentify];
        }
        else{
            /**直接赋值*/
            aCell.Default();
        }
        return aCell;
    };
}

#pragma mark - 懒加载

/**懒加载pictureView，以免bug*/
- (UIImageView *)pictureView{
    if (_pictureView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageDefault"]];
        _pictureView.frame = self.pictureRect;
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
        _titleLab.frame = self.titleRect;
        _hintLab.font = [UIFont systemFontOfSize:16];
        _hintLab.backgroundColor = [UIColor grayColor];
    }
    return _hintLab;
}

#pragma mark - 链式编程

/**自定义title的文字*/
- (PageCell *(^)(NSString *))Title_text{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *str){
        self.titleLab.text = str;
        self.titleLab.backgroundColor = [UIColor clearColor];
        return self;
    };
}

/**自定义hint的文字*/
- (PageCell *(^)(NSString *))Hint_text{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *str){
        self.hintLab.text = str;
        self.hintLab.backgroundColor = [UIColor clearColor];
        return self;
    };
}

/**自定义picture*/
- (PageCell *(^)(NSString *))Picture_URLString{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *url){
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
- (PageCell *(^)(void))Default{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(){
        self.titleLab.text = @"";
        self.titleLab.backgroundColor = [UIColor darkGrayColor];
        self.titleLab.frame = self.titleRect;
        
        self.hintLab.text = @"";
        self.hintLab.backgroundColor = [UIColor grayColor];
        self.hintLab.frame = self.hintRect;
        
        self.pictureView.image = [UIImage imageNamed:@"ImageDefault"];
        self.pictureView.frame = self.pictureRect;
        return self;
    };
}

#
@end

#pragma mark - PageCell (CGRect)方法实现

@implementation PageCell (CGRect)

#pragma mark - 懒加载

/**picture的Rect*/
- (CGRect)pictureRect{
    static BOOL hadMake = NO;
    if (hadMake == NO) {
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGRect thisRect = self.contentView.frame;
        CGRect rect;
        CGFloat content = 10;
        CGFloat size = 120;
        rect = CGRectMake(0, content, size, size);
        rect.origin.x = thisRect.size.width - content - size;
        return rect;
    }
    return self.pictureRect;
}

/**title的Rect*/
- (CGRect)titleRect{
    static BOOL hadMake = NO;
    if (hadMake == NO) {
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGRect rect;
        CGFloat content = 10;
        CGFloat height = 70;
        rect = CGRectMake(content / 2, self.pictureRect.origin.y, 0, height);
        rect.size.width = self.pictureRect.origin.x - content;
        return rect;
    }
    return self.pictureRect;
}

- (CGRect)hintRect{
    static BOOL hadMake = NO;
    if (hadMake == NO) {
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGFloat content = 10;
        CGRect rect;
        CGFloat height = 40;
        rect = CGRectMake(self.titleRect.origin.x, self.titleRect.origin.y + self.titleRect.size.height + content / 2, self.titleRect.size.width, height);
        return rect;
    }
    return self.hintRect;
}

#pragma mark - 初始化

/**将布局这些控件，已优化*/
+ (void(^)(void))MakeCGRect{
    return ^(){
        
    };
}

@end
