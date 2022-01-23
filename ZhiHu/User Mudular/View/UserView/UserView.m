//
//  UserView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/22.
//

#import "UserView.h"

static BOOL load;

#pragma mark - UserView方法实现

@implementation UserView

#pragma mark - 初始化方法

/**重写initWithFrame*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImgView];
        [self addSubview:self.loadBtn];
    }
    return self;
}

#pragma mark - 懒加载

/**懒加载imgView*/
- (UIImageView *)headImgView{
    if (_headImgView == nil) {
        CGFloat conten = 20;
        CGFloat width = self.frame.size.width - 2 * conten;
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(conten, 100, width, width)];
        _headImgView.layer.cornerRadius = width / 2;
        _headImgView.clipsToBounds = YES;
        
        _headImgView.layer.borderWidth = 3;
        _headImgView.layer.borderColor = [UIColor orangeColor].CGColor;
        
        if (load == NO) {
            _headImgView.image = [UIImage imageNamed:@"SSR_default"];
        }
        else{
            _headImgView.image = [UIImage imageNamed:@"SSR_light"];
        }
    }
    return _headImgView;
}

/**懒加载button*/
- (UIButton *)loadBtn{
    if (_loadBtn == nil) {
        CGFloat conten = 50;
        CGFloat width = self.frame.size.width - 2 * conten;
        CGFloat y = self.headImgView.frame.origin.y + self.headImgView.frame.size.height + conten;
        _loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(conten, y, width, conten)];
        _loadBtn.layer.cornerRadius = conten / 2;
        _loadBtn.clipsToBounds = YES;
        _loadBtn.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        [_loadBtn setTitle:@"登  录" forState:UIControlStateNormal];
        [_loadBtn setTitle:@"退  出" forState:UIControlStateSelected];
        if (load == NO) {
            _loadBtn.selected = NO;
            _loadBtn.backgroundColor = [UIColor orangeColor];
        }
        else{
            _loadBtn.selected = YES;
            _loadBtn.backgroundColor = [UIColor grayColor];
        }
        [_loadBtn addTarget:self action:@selector(tapLoad:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadBtn;
}

#pragma mark - 方法

/**是否已经登录*/
+ (NSString *)ImageNameWhereIsLoaded{
    if (load == YES) {
        return @"SSR_light";
    }
    return @"SSR_default";
}

#pragma mark - 其他

- (void)tapLoad:(UIButton *)btn{
    btn.selected = !btn.selected;
    load = !load;
    if (btn.selected == YES) {
        btn.backgroundColor = [UIColor grayColor];
        self.headImgView.image = [UIImage imageNamed:@"SSR_light"];
    }
    else{
        btn.backgroundColor = [UIColor orangeColor];
        self.headImgView.image = [UIImage imageNamed:@"SSR_default"];
    }
}

- (void)loadData{
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
}

@end
