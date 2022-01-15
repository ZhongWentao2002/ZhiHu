//
//  DailyStories.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import <Foundation/Foundation.h>

@class Story;

NS_ASSUME_NONNULL_BEGIN

@interface DailyStories : NSObject

/**保存当天日期*/
@property (nonatomic, copy) NSString *date;

/**保存每天的新闻*/
@property (nonatomic, copy) NSArray <Story *> *stories;

@end

NS_ASSUME_NONNULL_END
