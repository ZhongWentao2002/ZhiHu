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

@property (nonatomic, strong) ViewController *VCmanager;

@end

@implementation AppDelegate

/**当application完成从 启动选项 字典中加载*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.delegate = self.VCmanager;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    nav.navigationBar.hidden = YES;
    
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (ViewController *)VCmanager{
    if (_VCmanager == nil) {
        _VCmanager = [[ViewController alloc] init];
    }
    return _VCmanager;
}

@end
