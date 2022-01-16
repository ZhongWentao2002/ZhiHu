//
//  MainTableView.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTableView : UITableView
/**代理*/
<UITableViewDelegate>

/**init方法不可用，请使用initWithFrame:style:*/
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
