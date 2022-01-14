//
//  ViewController.h
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

/**管理类
 * 作用：管理每一个模块
 * 实现：模块会通过代理得知push的对象
 * 注意：管理类没有生命周期，只有代理
 */

#import <UIKit/UIKit.h>

/**新闻Controller*/
#import "MainViewController.h"

@interface ViewController : UIViewController
/**遵循的代理*/
<MainDelegate>

@end

