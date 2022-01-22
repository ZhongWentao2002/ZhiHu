//
//  UserTopView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/22.
//

#import "UserTopView.h"

@implementation UserTopView

#pragma mark - 初始化

/**重写initWithFrame*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
    }
    return self;
}

#pragma mark - 懒加载

/**懒加载backBtn*/
- (UIButton *)backBtn{
    if (_backBtn == nil) {
        CGRect rect = CGRectMake(20, 0, 35, 35);
        rect.origin.y = self.frame.size.height - rect.size.height;
        _backBtn = [[UIButton alloc] initWithFrame:rect];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"BackItem"] forState:UIControlStateNormal];
        [_backBtn addTarget:self.delegate action:@selector(UserTopView_tapBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
