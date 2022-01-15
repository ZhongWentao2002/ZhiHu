//
//  Story.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**Story模型
 * Story为cell单行显示的数据
 * 这里将直接保存所有可用数据
 * 所有的转换都将由字典告诉我们
 */

#import <UIkit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Story : NSObject

/**title新闻标题*/
@property (nonatomic, copy) NSString *title;

/**hint作者信息*/
@property (nonatomic, copy) NSString *hint;

/**image预览图片*/
@property (nonatomic, copy) UIImage *image;

/**image_hue，用于top_stories类型*/
@property (nonatomic, copy) UIColor *image_hue;

/**id内容id*/
@property (nonatomic) NSInteger ID;

/**url详情页保留*/
@property (nonatomic, copy) NSURL *url;

@end

NS_ASSUME_NONNULL_END
