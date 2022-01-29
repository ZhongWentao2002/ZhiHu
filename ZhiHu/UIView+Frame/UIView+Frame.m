//
//  UIView+Frame.m
//  Encapsulation
//
//  Created by SSR on 2022/1/24.
//

#import "UIView+Frame.h"

#pragma mark - Frame扩展

@implementation UIView (Frame)

#pragma mark origin

// frme.origin

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

// frame.origin.x

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

// frame.origin.y

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

#pragma mark size

// frame.size

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

// frame.size.width

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

// frame.size.height

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

#pragma mark center

// center.x

- (void)setCenterX:(CGFloat)centerX {
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerX {
    return self.center.x;
}

// center.y

- (void)setCenterY:(CGFloat)centerY {
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerY {
    return self.center.y;
}

#pragma mark other

// right (frame.origin.x + frame.size.width)

- (void)setRight:(CGFloat)right {
    CGFloat x = right - self.frame.size.width;
    self.x = x;
}

- (CGFloat)right {
    return self.origin.x + self.size.width;
}

// bottom (frame.origin.y + frame.size.height)

- (void)setBottom:(CGFloat)bottom {
    CGFloat y = bottom - self.frame.size.height;
    self.y = y;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

// left (frame.origin.x)

- (void)setLeft:(CGFloat)left {
    self.x = left;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

// top (frame.origin.y)

- (void)setTop:(CGFloat)top {
    self.y = top;
}

- (CGFloat)top {
    return self.frame.origin.y;
}


@end

#pragma mark - Stretch扩展

@implementation UIView (Stretch)

/**距离左边某点(x,0)多少距离*/
- (UIView *)Left_toPointX:(CGFloat)left offset:(CGFloat)leftSpace {
    self.width -= leftSpace;
    self.x = left + leftSpace;
    return self;
}

/**距离上面某点(0,x)多少距离*/
- (UIView *)Top_toPointY:(CGFloat)top offset:(CGFloat)topSpace {
    self.height -= topSpace;
    self.y = top + topSpace;
    return self;
}

/**距离右边某点(x,0)多少距离*/
- (UIView *)Right_toPointX:(CGFloat)right offset:(CGFloat)rightSpace {
    self.width = right - self.x - rightSpace;
    return self;
}

/**距离底部某点(0,x)多少距离*/
- (UIView *)Bottom_toPointY:(CGFloat)bottom offset:(CGFloat)bottomSpace {
    self.height = bottom - self.y - bottomSpace;
    return self;
}

/**总共的方法*/
- (UIView *)Edge:(EdgeSide)edge toPointP:(CGFloat)p offset:(CGFloat)offset {
    if (edge & EdgeSideTop) {
        [self Top_toPointY:p offset:offset];
    }
    if (edge & EdgeSideLeft) {
        [self Left_toPointX:p offset:offset];
    }
    if (edge & EdgeSideRight) {
        [self Right_toPointX:p offset:offset];
    }
    if (edge & EdgeSideBottom) {
        [self Bottom_toPointY:p offset:offset];
    }
    return self;
}

@end
