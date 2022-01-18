//
//  SafeBarView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

#import "SafeBarView.h"

#pragma mark - SafeBar

@implementation SafeBarView

#pragma mark - 初始化方法

/**init方法*/
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**链式创建Create*/
+ (SafeBarView *(^)(id <SafeBarViewDelegate>))Create_withDelegate{
    return ^SafeBarView *(id <SafeBarViewDelegate> delegate){
        SafeBarView *vc = [[SafeBarView alloc] init];
        vc.delegate = delegate;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:vc.delegate action:@selector(safeBarTaped)];
        [vc addGestureRecognizer:tap];
        [vc addSubview:vc.todayLab];
        [vc addSubview:vc.line];
        [vc addSubview:vc.headImgView];
        [vc addSubview:vc.titleLab];
        return vc;
    };
}

/**frame链式语法*/
- (SafeBarView *(^)(CGRect))Frame_CGRect{
    return ^SafeBarView *(CGRect rect){
        self.frame = rect;
        self.todayLab.frame = [self todayLabRect];
        self.line.frame = [self lineRect];
        self.headImgView.frame = [self headRect];
        self.titleLab.frame = [self titleRect];
        return self;
    };
}

#pragma mark - 懒加载

/**日期*/
- (UILabel *)todayLab{
    if (_todayLab == nil) {
        _todayLab = [[UILabel alloc] init];
        _todayLab.numberOfLines = 2;
        _todayLab.textAlignment = NSTextAlignmentCenter;
        _todayLab.font = [UIFont boldSystemFontOfSize:18];
        _todayLab.userInteractionEnabled = NO;
        //找日期
        NSDate *date =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        /**日期*/
        [formatter setDateFormat:@"dd"];
        NSString *day = [NSString stringWithFormat:@"%ld",[[formatter stringFromDate:date] integerValue]];
        /**月份*/
        [formatter setDateFormat:@"MM"];
        NSString *month = [self monthTransform:[[formatter stringFromDate:date]integerValue]];
        _todayLab.text = [NSString stringWithFormat:@"%@\n%@", day, month];
    }
    return _todayLab;
}

/**将数字转文字*月*/
- (NSString *)monthTransform:(NSInteger)month{
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray *chineseNumeralsArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    NSString *chinese = [dictionary objectForKey:[NSString stringWithFormat:@"%ld", month]];
    return chinese;
}

/**线*/
- (UILabel *)line{
    if (_line == nil) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor grayColor];
        _line.userInteractionEnabled = NO;
    }
    return _line;
}

/**懒加载imageView*/
- (UIImageView *)headImgView{
    if (_headImgView == nil) {
        _headImgView = [[UIImageView alloc] initWithFrame:[self headRect]];
        _headImgView.layer.cornerRadius = _headImgView.frame.size.width / 2;
        _headImgView.clipsToBounds = YES;
        _headImgView.image = [UIImage imageNamed:@"ImageDefault"];
        _headImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(safeBarImageViewTaped)];
        [_headImgView addGestureRecognizer:tap];
    }
    return _headImgView;
}

/**懒加载titleLab*/
- (UILabel *)titleLab{
    if(_titleLab == nil){
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:27];
        _titleLab.text = @"SSR  知乎日报";
        _titleLab.userInteractionEnabled = NO;
    }
    return _titleLab;
}

#pragma mark - 尺寸计算

/**todayLab的计算*/
- (CGRect)todayLabRect{
    CGRect safebarRect = self.frame;
    CGRect rect;
    rect.size.width = rect.size.height = 50;
    rect.origin.x = 15;
    rect.origin.y = safebarRect.size.height - rect.size.width;
    return rect;
}

/**line的计算*/
- (CGRect)lineRect{
    CGRect todayRect = self.todayLab.frame;
    CGFloat content = 10;
    CGRect rect;
    rect.origin.x = todayRect.origin.x + todayRect.size.width + content;
    rect.origin.y = todayRect.origin.y;
    rect.size.width = 5;
    rect.size.height = todayRect.size.height - 2;
    return rect;
}

/**headImgView的计算*/
- (CGRect)headRect{
    CGRect safebarRect = self.frame;
    CGFloat content = 5;
    CGRect rect;
    rect.size.width = rect.size.height = 45;
    rect.origin.x = safebarRect.size.width - 20 - rect.size.width;
    rect.origin.y = safebarRect.size.height - rect.size.height - content;
    return rect;
}

/**title的计算*/
- (CGRect)titleRect{
    CGRect lineRect = self.line.frame;
    CGFloat content = 10;
    CGRect rect;
    rect.origin.x = lineRect.origin.x + lineRect.size.width + content;
    rect.origin.y = lineRect.origin.y;
    rect.size.height = lineRect.size.height;
    rect.size.width = self.headImgView.frame.origin.x - lineRect.origin.x - content;
    return rect;
}

@end