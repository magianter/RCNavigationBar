//
//  TestNaviBarViewController.m
//  RCNavigationBar
//
//  Created by renchao on 2020/2/24.
//  Copyright © 2020 renchao. All rights reserved.
//

#import "TestNaviBarViewController.h"

@interface TestNaviBarViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) id<UIGestureRecognizerDelegate>gestureDelegate;

@end

@implementation TestNaviBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    //自定义返回按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"goBackBtn" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //导航栏背景图片
    //    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"download"];
    
    //    UIImage *navigationBackImage = [UIImage imageNamed:@"images.jpeg"];
    //    navigationBackImage = [navigationBackImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];   //平铺
    //    [self.navigationController.navigationBar setBackgroundImage:navigationBackImage forBarMetrics:UIBarMetricsDefault]; // 竖屏
    
    //导航栏背景颜色
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    //导航栏背景颜色 半透明  设置为NO 原点坐标以导航栏左下角为准
    self.navigationController.navigationBar.translucent = YES;
    
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
    testView.backgroundColor = [UIColor grayColor];
    //    [self.view addSubview:testView];
    
    //导航栏分割线
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //全局设置字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //这两个必须同时使用，按照Apple 官方尺寸
    //    self.navigationController.navigationBar.backIndicatorImage
    //    self.navigationController.navigationBar.backIndicatorTransitionMaskImage
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

//自定义左侧返回按钮后，侧滑无效问题修改
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.childViewControllers.count > 1) {
        self.gestureDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self.gestureDelegate;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer  {
    return self.navigationController.childViewControllers.count > 1;
}
    
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
