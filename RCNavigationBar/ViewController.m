//
//  ViewController.m
//  RCNavigationBar
//
//  Created by renchao on 2020/2/21.
//  Copyright © 2020 renchao. All rights reserved.
//

#import "ViewController.h"
#import "TestNaviBarViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *naviButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.naviButton.frame = CGRectMake(100, 100, 100, 100);
    self.naviButton.backgroundColor = [UIColor redColor];
    [self.naviButton addTarget:self action:@selector(jumpToNaiviVC) forControlEvents:UIControlEventTouchUpInside];
    [self.naviButton setTitle:@"testCode" forState:UIControlStateNormal];
    [self.view addSubview:self.naviButton];
    
    //右侧item
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 100, 100, 100);
    [leftButton setTitle:@"right" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = leftItem;
    
    //Title
    self.navigationItem.title = @"RCNavigationBar";
//    self.navigationItem.prompt = @"prompt";
    
}

- (void)jumpToNaiviVC {
    TestNaviBarViewController *naviVC = [[TestNaviBarViewController alloc]init];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backBarButtonItem;
    [self.navigationController pushViewController:naviVC animated:nil];
    
}
@end
