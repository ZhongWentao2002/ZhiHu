//
//  UIView+Frame.h
//  Encapsulation
//
//  Created by SSR on 2022/1/24.
//

/**<UIView+Frame.h>
 * 已将MianScreen的可用属性用define表示
 *
 * 将类扩展UIView的Frame
 * 快速取值和赋值
 *
 * 布局将采用Windows拉伸方法
 *
 */

#import <UIKit/UIKit.h>

#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

NS_ASSUME_NONNULL_BEGIN

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

/**frame.origin.x + frame.size.width*/
@property (nonatomic) CGFloat right;

/**frame.origin.y + frame.size.height*/
@property (nonatomic) CGFloat bottom;

@end

#pragma mark - Layout扩展

/**Layout扩展
 * 将按照Widows拉伸方法
 * 所有的操作将对此UIView本身Frame作用
 * 并不会自动改变大小或睁开控件
 * 返回值返回自己，可以实现伪链式
 */

@interface UIView (Layout)

/**frame.origin.x*/
@property (nonatomic) CGFloat left;

/**frame.origin.y*/
@property (nonatomic) CGFloat top;

/**距离左边某点(x,0)多少距离*/
- (UIView *)Left_toPointX:(CGFloat)left Set_offset:(CGFloat)leftSpace;

/**距离上面某点(0,y)多少距离*/
- (UIView *)Top_toPointY:(CGFloat)top Set_offset:(CGFloat)topSpace;

/**距离右边某点(x,0)多少距离*/
- (UIView *)Right_toPointX:(CGFloat)right Set_offset:(CGFloat)rightSpace;

/**距离底部某点(0,y)多少距离*/
- (UIView *)Bottom_toPointY:(CGFloat)bottom Set_offset:(CGFloat)bottomSpace;

@end

NS_ASSUME_NONNULL_END
