//
//  LoadViewController.m
//  ZhiHu
//
//  Created by SSR on 2022/1/18.
//

#import "LoadViewController.h"

@interface LoadViewController ()

@end

@implementation LoadViewController

#pragma mark - 初始化方法

/**基本初始化方法，外部不可用使用*/
- (instancetype)init{
    self = [super init];
    NSLog(@"\n%@ - %s", [self class], __func__);
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**链式创建方法*/
+ (LoadViewController *(^)(UIViewController <LoadDelegate> *))Create_withDelegate{
    return ^LoadViewController *(UIViewController <LoadDelegate> * t){
        LoadViewController *vc = [[LoadViewController alloc] init];
        vc.delegate = t;
        return vc;
    };
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
