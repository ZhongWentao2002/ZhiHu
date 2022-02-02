//
//  ZhiHuPage.m
//  ZhiHu
//
//  Created by SSR on 2022/2/1.
//

#import "ZhiHuPage.h"

#pragma mark - 扩展属性

@interface ZhiHuPage ()

/**滑动开始的p值*/
@property (nonatomic) CGFloat p;

/**最宽的宽度*/
@property (nonatomic) CGFloat currentWidth;

/**控件保存的位置*/
@property (nonatomic, strong) NSMutableArray <UILabel *> *labs;

@end

#pragma mark - ZhiHuPage实现

@implementation ZhiHuPage

#pragma mark - 初始化方法

/**重写init，会根据(0,0,100,10)创建*/
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 100, 10)];
}

/**最根本的创建方法*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pages = 5;
        _currentPage = 1;
        _currentColor = [UIColor whiteColor];
        _space = 5;
        
        [self labsWithNum:_pages];
        [self layWithInit];
    }
    return self;
}

#pragma mark - 创建控件

- (UILabel *)createLabWithNum:(NSInteger)i {
    UILabel *aLab = [[UILabel alloc] init];
    // currentPage + currentColor
    if (i == self.currentPage - 1) {
        aLab.backgroundColor = self.currentColor;
    }
    else {
        aLab.backgroundColor = [self.currentColor colorWithAlphaComponent:0.5];
    }
    // lay without left
    [[aLab
     Top_toPointY:self.SuperTop offset:0]
     Bottom_toPointY:self.SuperBottom offset:0];
    aLab.width = aLab.height;
    // corner and clips
    aLab.layer.cornerRadius = aLab.height / 2;
    aLab.clipsToBounds = YES;
    return aLab;
}

/**其他属性必须拥有，这种创建方法才能O(n)*/
- (void)labsWithNum:(NSInteger)num {
    // lab is nil
    if (self.labs == nil) {
        for (NSInteger i = 0; i < num; i++) {
            // create Lab
            UILabel *aLab = [self createLabWithNum:i];
            // add to view & object
            [self addSubview:aLab];
            [self.labs addObject:aLab];
        }
    }
    // lab had some labs
    else {
        self.pages = num;
    }
}

/**指定page的时候创建控件*/
- (void)setPages:(NSInteger)pages {
    // pages enable
    pages = (pages < 2 ? _pages : pages);
    if (_pages == pages) {
        return;
    }
    // page changed
    NSInteger oldCount = _pages;
    _pages = pages;
    // - create lab
    if (pages > oldCount) {
        for (NSInteger i = oldCount; i <= pages; i++) {
            // create Lab
            UILabel *aLab = [self createLabWithNum:i];
            // lay
            aLab.left = (i - 1) * (self.width + self.space);
            // add to view & object
            [self addSubview:aLab];
            [self.labs addObject:aLab];
        }
    }
    // - delete lab
    else {
        for (NSInteger i = oldCount; i >= pages; i--) {
            // get Lab
            UILabel *aLab = self.labs[i - 1];
            // remove to view & object
            [aLab removeFromSuperview];
            [self.labs removeObject:aLab];
        }
    }
}

#pragma mark - 布局控件

/**基本布局控件*/
- (void)layWithInit {
    // from 0 to currentPage - 2 that make those left
    for (NSInteger i = 0; i < self.currentPage - 1; i++) {
        UILabel *aLab = self.labs[i];
        aLab.left = i * (self.width + self.space);
    }
    // from currentPage to pages - 1 that make those right
    for (NSInteger i = self.pages - 1; i >= self.currentPage; i--) {
        UILabel *aLab = self.labs[i];
        aLab.right = (self.pages - i - 1) * (self.width + self.space);
    }
    // currentPage that autowidth
    {
        UILabel *aLab = self.labs[self.currentPage - 1];
        [aLab Left_toPointX:self.labs[self.currentPage - 2].right offset:self.space];
        [aLab Right_toPointX:self.labs[self.currentPage].left offset:self.space];
    }
}

/**手动指定currentPage时*/
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    [self layWithInit];
}

/**改变size的时候就要布局*/
- (void)setSize:(CGSize)size {
    if (CGSizeEqualToSize(self.frame.size, size)) {
        return;
    }
    [super setSize:size];
    [self layWithInit];
}

#pragma mark - 颜色间距

/**手动设置color的改变*/
- (void)setCurrentColor:(UIColor *)currentColor {
    if (_currentColor == currentColor) {
        return;
    }
    _currentColor = [currentColor colorWithAlphaComponent:1];
    for (NSInteger i = 0; i < self.pages; i++) {
        // is current page
        if (i == self.currentPage - 1) {
            self.labs[i].backgroundColor = [_currentColor colorWithAlphaComponent:0.5];
        }
        // not current page
        else {
            self.labs[i].backgroundColor = _currentColor;
        }
    }
}

/**手动设置space*/
- (void)setSpace:(CGFloat)space {
    space = (space < 0 ? _space : space);
    if (_space == space) {
        return;
    }
    _space = space;
    [self layWithInit];
}

#pragma mark - 方法

/**请在scrollViewWillBeginDragging中调用此方法，并传入offset*/
- (void)ScrollBegin:(CGPoint)offset {
    self.p = offset.x;
}

/**请在scrollViewDidScroll中调用此方法，并传入offset*/
- (void)Scrolling:(CGPoint)offset {
    // total x > p, right
    if (offset.x > self.p) {
        
    }
    
}

/**请在scrollViewDidEndScrollingAnimation中调用此方法，并传入offset*/
- (void)ScrollingEnd:(CGPoint)offset {
    if (offset.x > self.p) {
        _currentPage = (_currentPage + 1) % _pages;
    }
    else if (offset.x < self.p) {
        _currentPage = (_currentPage + _pages - 1) % _pages;
    }
    else
        return;
}

@end
