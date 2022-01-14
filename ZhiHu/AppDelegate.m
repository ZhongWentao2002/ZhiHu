//
//  AppDelegate.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] initWithDelegate:[[ViewController alloc] init]]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
