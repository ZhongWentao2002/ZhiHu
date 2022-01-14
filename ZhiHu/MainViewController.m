//
//  MainViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/15.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - 初始化方法

- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"\n%@ - %s", [self class], __func__);
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**指定manageVC为自己代理，封装性良好*/
- (instancetype)initWithDelegate:(UIViewController <MainDelegate> *)manageVC{
    self = [self init];
    self.delegate = manageVC;
    return self;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n%@ - %s", [self class], __func__);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"\n%@ - %s", [self class], __func__);
}

@end
