//
//  PageCell.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "PageCell.h"

#import <UIImageView+AFNetworking.h>



#pragma mark -  类扩展（被封装的类）

@interface PageCell ()

/**封装titleHeight*/
@property (nonatomic) CGFloat titleHeight;

@end

#pragma mark - 方法实现

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

/**layout方法，布局各个视图*/
- (void)layout{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    CGRect thisRect = self.contentView.frame;
    CGFloat content = 10;
    
    CGRect pictureRect;
    CGRect titleRect;
    CGRect hintRect;
    // pictureView
    {
        CGFloat size = 120;
        pictureRect = CGRectMake(0, content, size, size);
        pictureRect.origin.x = thisRect.size.width - content - size;
        self.pictureView.frame = pictureRect;
    }
    
    // titleLab
    {
        CGFloat height = 70;
        titleRect = CGRectMake(content / 2, pictureRect.origin.y, 0, height);
        titleRect.size.width = pictureRect.origin.x - content;
        self.titleLab.frame = titleRect;
    }
    
    // hintLab
    {
        CGFloat height = 40;
        hintRect = CGRectMake(titleRect.origin.x, titleRect.origin.y + titleRect.size.height + content / 2, titleRect.size.width, height);
        self.hintLab.frame = hintRect;
    }
    
}

/**title的CGRect*/
- (void)CGRectForTitle{
    
}

#pragma mark - 懒加载

/**懒加载pictureView，以免bug*/
- (UIImageView *)pictureView{
    if (_pictureView == nil) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        
        _pictureView.backgroundColor = [UIColor grayColor];
        _pictureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageDefault"]];
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
    }
    return _hintLab;
}

#pragma mark - 链式编程

#pragma mark 模式链式

/**无数据状态
 * 这种状态将存在于 加载数据前 和 无限滚动加载数据前
 * 复用池机制将自动调用一次
 * 请在与复用池匹配的else中手动调用一次
 *
 * 数据：titleLab显示空文本，灰色，单行灰
 * hintlab显示空文本，灰色
 * backgroundColor
 */
- (void(^)(void))Default{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^(){
        self.titleLab.text = @"";
        self.titleLab.backgroundColor = [UIColor darkGrayColor];
        self.hintLab.text = @"";
        self.hintLab.backgroundColor = [UIColor grayColor];
        self.pictureView.image = [UIImage imageNamed:@"ImageDefault"];
        return;
    };
}

/**frame的layout*/
- (PageCell *(^)(CGFloat))width{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(CGFloat width){
        self.frame = CGRectMake(0, 0, width, 0);
        self.contentView.frame = self.frame;
        [self layout];
        return self;
    };
}

#pragma mark 属性链式

/**自定义title的文字*/
- (PageCell *(^)(NSString *))title{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *str){
        self.titleLab.text = str;
        self.titleLab.backgroundColor = [UIColor clearColor];
        return self;
    };
}

/**自定义hint的文字*/
- (PageCell *(^)(NSString *))hint{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *str){
        self.hintLab.text = str;
        self.hintLab.backgroundColor = [UIColor clearColor];
        return self;
    };
}

/**自定义picture*/
- (PageCell *(^)(NSString *))picture{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(NSString *url){
        [self.pictureView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ImageDefault"]];
        return self;
    };
}

/**设置titleHeight，将重新布局*/
- (PageCell *(^)(CGFloat))heightOfTitle{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^PageCell *(CGFloat height){
        /**重新布局title*/
        self.titleHeight = height;
        CGRect titleRect = self.titleLab.frame;
        titleRect.size.height = height;
        self.titleLab.frame = titleRect;
        /**重新布局hint*/
        CGRect hintRect = self.hintLab.frame;
        hintRect.origin.y = titleRect.origin.y + titleRect.size.height;
        self.hintLab.frame = hintRect;
        return self;
    };
}

/**封装的高度，只计算并附值*/
- (CGFloat (^)(NSString *))heightForTitle{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return ^CGFloat(NSString *title){
        //计算高度需要 文本 文本宽度 文本字典
        CGFloat width = self.titleLab.frame.size.width;
        NSDictionary *font =//得到字典
        @{NSFontAttributeName :[UIFont boldSystemFontOfSize:self.titleLab.font.pointSize]};
        //计算cgrect(0,0,width,autoHeight)
        CGRect rect = [self.titleLab.text
                       boundingRectWithSize:CGSizeMake(width, 0)
                       options:NSStringDrawingUsesFontLeading
                              |NSStringDrawingUsesLineFragmentOrigin
                    attributes:font
                       context:nil];
        return rect.size.height;
    };
}

@end
