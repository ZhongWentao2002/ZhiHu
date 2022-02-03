//
//  SafeBarView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

#import "SafeBarView.h"

#pragma mark - SafeBar类扩展

@interface SafeBarView ()

/**用于日期的view*/
@property (nonatomic, strong) UIView *todayView;

@end

#pragma mark - SafeBar视图

@implementation SafeBarView

#pragma mark - 初始化方法

/**init方法*/
- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.todayView];
        [self addSubview:self.line];
        [self addSubview:self.headImgView];
        [self addSubview:self.titleLab];
    }
    return self;
}

/**重写加载部分数据*/
- (void)reloadData{
    self.headImgView.image = [UIImage imageNamed:[self.delegate safeBarNeedHeadImage]];
}

#pragma mark - 懒加载

/**日期*/
- (UIView *)todayView{
    if (_todayView == nil) {
        _todayView = [[UILabel alloc] init];
        
        _todayView.top = StatusBarHeight;
        [[_todayView
         Bottom_toPointY:self.bottom offset:5]
         Left_toPointX:self.left offset:15];
        _todayView.width = _todayView.height;
        
        [_todayView addSubview:self.dayLab];
        [_todayView addSubview:self.monthLab];
    }
    return _todayView;
}

/**天*/
- (UILabel *)dayLab{
    if (_dayLab == nil) {
        _dayLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _dayLab.textAlignment = NSTextAlignmentCenter;
        _dayLab.userInteractionEnabled = NO;
        _dayLab.font = [UIFont boldSystemFontOfSize:23];
        //找日期
        NSDate *date =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        /**日期*/
        [formatter setDateFormat:@"d"];
        NSString *day = [formatter stringFromDate:date];
        _dayLab.text = [NSString stringWithFormat:@"%@", day];
        
        _dayLab.width = self.todayView.width;
        _dayLab.height = self.todayView.height / 2;
    }
    return _dayLab;
}

/**月*/
- (UILabel *)monthLab{
    if (_monthLab == nil) {
        _monthLab = [[UILabel alloc] initWithFrame:self.dayLab.frame];
        
        _monthLab.textAlignment = NSTextAlignmentCenter;
        _monthLab.font = [UIFont boldSystemFontOfSize:17];
        _monthLab.userInteractionEnabled = NO;
        
        _monthLab.top = self.dayLab.bottom;
        [_monthLab Bottom_toPointY:self.todayView.SuperBottom offset:0];
        //找日期
        NSDate *date =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        /**日期*/
        [formatter setDateFormat:@"M"];
        NSString *month = [self monthTransform:[[formatter stringFromDate:date] integerValue]];
        _monthLab.text = [NSString stringWithFormat:@"%@月", month];
    }
    return _monthLab;
}

/**将数字转文字*月*/
- (NSString *)monthTransform:(NSInteger)month{
    switch (month) {
        case 1:
            return @"一";
        case 2:
            return @"二";
        case 3:
            return @"三";
        case 4:
            return @"四";
        case 5:
            return @"五";
        case 6:
            return @"六";
        case 7:
            return @"七";
        case 8:
            return @"八";
        case 9:
            return @"九";
        case 10:
            return @"十";
        case 11:
            return @"十一";
        case 12:
            return @"十二";
        default:
            return nil;
    }
    return nil;
}

/**线*/
- (UILabel *)line{
    if (_line == nil) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor grayColor];
        _line.userInteractionEnabled = NO;
        
        _line.top = self.todayView.top;
        _line.left = self.todayView.right + 10;
        _line.width = 3;
        _line.height = self.todayView.height;
    }
    return _line;
}

/**懒加载imageView*/
- (UIImageView *)headImgView{
    if (_headImgView == nil) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.image = [UIImage imageNamed:@"SSR_default"];
        _headImgView.userInteractionEnabled = YES;
        
        _headImgView.width = _headImgView.height = 50;
        _headImgView.right = self.right - 10;
        _headImgView.bottom = self.bottom - 5;
        
        _headImgView.layer.cornerRadius = _headImgView.width / 2;
        _headImgView.layer.borderWidth = 2;
        _headImgView.layer.borderColor = [UIColor orangeColor].CGColor;
        _headImgView.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(safeBarImageViewTaped)];
        [_headImgView addGestureRecognizer:tap];
    }
    return _headImgView;
}

/**懒加载titleLab*/
- (UILabel *)titleLab{
    if(_titleLab == nil){
        _titleLab = [[UILabel alloc] init];
        
        [[_titleLab
         Left_toPointX:self.line.right offset:10]
         Right_toPointX:self.headImgView.left offset:10];
        _titleLab.top = self.todayView.top;
        _titleLab.height = self.todayView.height;
        
        _titleLab.font = [UIFont boldSystemFontOfSize:27];
        _titleLab.text = @"SSR - 知乎日报";
        _titleLab.userInteractionEnabled = NO;
    }
    return _titleLab;
}

@end
