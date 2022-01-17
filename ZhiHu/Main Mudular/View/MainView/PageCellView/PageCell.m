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
        
    }
    return self;
}



/**链式创建，如果有则直接拿，如果没有则创建，默认default状态*/
+ (PageCell *(^)(UITableView *))ReusableCellFromSuperTableView{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(UITableView *superTableView){
        static NSString *PageCellIdentify = @"PageCell";
        /**向资源池访问*/
        PageCell *aCell = [superTableView dequeueReusableCellWithIdentifier:PageCellIdentify];
        /**如果资源池无数据则需要创建*/
        if (aCell == nil) {
            /**创建资源池类型*/
            aCell = [[PageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageCellIdentify];
            /**设置基础宽度*/
            aCell.frame = CGRectMake(0, 0, superTableView.frame.size.width, 0);
            /**加载到自己的contentView上*/
            [aCell.contentView addSubview:aCell.pictureView];
            [aCell.contentView addSubview:aCell.titleLab];
            [aCell.contentView addSubview:aCell.hintLab];
        }
        /**初始化状态*/
        aCell.Default();
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
        _hintLab.frame = self.hintRect;
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
- (PageCell *(^)(NSString *))Hint_text{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *str){
        self.hintLab.text = str;
        self.hintLab.textColor = [UIColor grayColor];
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
        
        self.hintLab.text = @"";
        self.hintLab.backgroundColor = [UIColor grayColor];
        
        self.pictureView.image = [UIImage imageNamed:@"ImageDefault"];
        return self;
    };
}

@end

#pragma mark - PageCell (CGRect)方法实现

@implementation PageCell (CGRect)

#pragma mark - 懒加载

/**picture的Rect*/
- (CGRect)pictureRect{
    static BOOL hadMake = NO;
    static CGFloat x, y, width, height;
    if (hadMake == NO) {
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGRect thisRect = self.contentView.frame;
        CGFloat content = 20;
        CGFloat size = 100;
        x = thisRect.size.width - content - size;
        y = content;
        width = height = size;
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

- (CGRect)hintRect{
    static BOOL hadMake = NO;
    static CGFloat x, y, width, height;
    if (hadMake == NO) {
        hadMake = YES;
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        CGFloat content = 10;
        CGRect titleRect = self.titleRect;
        height = 30;
        x = titleRect.origin.x;
        y = titleRect.origin.y + titleRect.size.height + content / 2;
        width = titleRect.size.width;
    }
    return CGRectMake(x, y, width, height);
}

@end
