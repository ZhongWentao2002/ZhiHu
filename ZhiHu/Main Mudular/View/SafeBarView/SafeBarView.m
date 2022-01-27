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
         Bottom_toPointY:self.bottom Set_offset:5]
         Left_toPointX:self.left Set_offset:15];
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
        [formatter setDateFormat:@"dd"];
        NSString *day = [NSString stringWithFormat:@"%ld",[[formatter stringFromDate:date] integerValue]];
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
        //找日期
        NSDate *date =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        /**日期*/
        [formatter setDateFormat:@"MM"];
        NSString *month = [self monthTransform:[[formatter stringFromDate:date] integerValue]];
        _monthLab.text = [NSString stringWithFormat:@"%@", month];
    }
    return _monthLab;
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
         Left_toPointX:self.line.right Set_offset:10]
         Right_toPointX:self.headImgView.left Set_offset:10];
        _titleLab.top = self.todayView.top;
        _titleLab.height = self.todayView.height;
        
        _titleLab.font = [UIFont boldSystemFontOfSize:27];
        _titleLab.text = @"SSR - 知乎日报";
        _titleLab.userInteractionEnabled = NO;
    }
    return _titleLab;
}

@end
