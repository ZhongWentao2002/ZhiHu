//
//  AppDelegate.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "AppDelegate.h"

/**管理Controller*/
#import "ViewController.h"

/**新闻Controller*/
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**当application完成从 启动选项 字典中加载*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] initWithDelegate:[[ViewController alloc] init]]];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
