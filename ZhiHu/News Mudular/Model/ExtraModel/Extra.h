//
//  Extra.h
//  ZhiHu
//
//  Created by SSR on 2022/1/20.
//

/**Extra数据
 * 得到新闻的其他数据
 * 拥有评论数和点赞数
 * 可以根据ID去创建一个Extra类
 * 并可以根据ID去网络请求数据
 */

#import <Foundation/Foundation.h>

#import "NetTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface Extra : NSObject

/**保存传入的ID*/
@property (nonatomic) NSInteger ID;

/**总评论*/
@property (nonatomic) NSInteger comments;

/**点赞数*/
@property (nonatomic) NSInteger popularity;

#pragma mark - 初始化方法

/**类方法初始化*/
+ (Extra *(^)(NSInteger))Create_withID_Integer;

/**comments*/
- (Extra *(^)(NSInteger))Comments_Integer;

/**popularity*/
- (Extra *(^)(NSInteger))Popularity_Integer;

/**得到网络请求*/
- (void)getExtra:(void(^)(void))load;

@end

NS_ASSUME_NONNULL_END
