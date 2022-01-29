//
//  UIView+Frame.h
//  Encapsulation
//
//  Created by SSR on 2022/1/24.
//

/**<UIView+Frame.h>
 * 将所有可能用到的Frame计算方式都写在这里
 * 不断的更新计算的方式和需求
 * Stretch将采用拉伸布局
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**全屏的define类型*/
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

/**刘海的define类型*/
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

/**父控件的define类型*/
#define SuperTop 0
#define SuprLeft 0
#define SuperRight width
#define SuperBottom height

/**枚举对其的方向*/
typedef NS_OPTIONS(NSUInteger, EdgeSide) {
    EdgeSideLeft = 1 << 0,
    EdgeSideTop = 1 << 1,
    EdgeSideRight = 1 << 2,
    EdgeSideBottom = 1 << 3
};


#pragma mark - Frame扩展

/**Frame扩展
 * 将采用Frame的数据
 * 可以直接赋值和取值
 * 也可以采取链式语法赋值
 */

@interface UIView (Frame)

// origin

/**frame.origin.x*/
@property (nonatomic, assign) CGFloat x;

/**frame.origin.y*/
@property (nonatomic) CGFloat y;

/**frame.origin*/
@property (nonatomic) CGPoint origin;

// size

/**frame.size.width*/
@property (nonatomic) CGFloat width;

/**frame.size.height*/
@property (nonatomic) CGFloat height;

/**frame.size*/
@property (nonatomic) CGSize size;

/**center.x*/
@property (nonatomic) CGFloat centerX;

/**center.y*/
@property (nonatomic) CGFloat centerY;

// other

/**frame.origin.x*/
@property (nonatomic) CGFloat left;

/**frame.origin.y*/
@property (nonatomic) CGFloat top;

/**frame.origin.x + frame.size.width*/
@property (nonatomic) CGFloat right;

/**frame.origin.y + frame.size.height*/
@property (nonatomic) CGFloat bottom;

@end

#pragma mark - Stretch扩展

/**Stretch扩展
 * 在同一父控件下，采用
 * 不可以使用自己的父控件Point值
 * 将按照Widows拉伸方法
 * 例：LeftTo将向左拉伸到某点的右边offset距离
 * 并不会自动改变大小或睁开控件
 * 返回值返回自己，可以实现伪链式
 */

@interface UIView (Stretch)

/**距离左边某点(x,0)多少距离*/
- (UIView *)Left_toPointX:(CGFloat)left offset:(CGFloat)leftSpace;

/**距离上面某点(0,y)多少距离*/
- (UIView *)Top_toPointY:(CGFloat)top offset:(CGFloat)topSpace;

/**距离右边某点(x,0)多少距离*/
- (UIView *)Right_toPointX:(CGFloat)right offset:(CGFloat)rightSpace;

/**距离底部某点(0,y)多少距离*/
- (UIView *)Bottom_toPointY:(CGFloat)bottom offset:(CGFloat)bottomSpace;

/**总共的方法*/
- (UIView *)Edge:(EdgeSide)edge toPointP:(CGFloat)p offset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
