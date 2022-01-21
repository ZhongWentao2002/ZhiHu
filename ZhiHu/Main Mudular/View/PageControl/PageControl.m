//
//  PageControl.m
//  ZhiHu
//
//  Created by SSR on 2022/1/21.
//

#import "PageControl.h"

@implementation PageControl

/**重写initWithFrame*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfPages = 5;//初始化是5个
        self.currentPage = 0;//默认选中第0个
        self.pageIndicatorTintColor = [UIColor yellowColor];
        self.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return self;
}

@end
