//
//  ViewController.m
//  RCNavigationBar
//
//  Created by renchao on 2020/2/21.
//  Copyright © 2020 renchao. All rights reserved.
//

#import "ViewController.h"
#import "TestNaviBarViewController.h"
#import "RCGradualChangeViewController.h"

static NSString  * const kCellIdentify = @"kCellIdentify";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton      *naviButton;

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, strong) NSArray       *cellDataArray;

@property (nonatomic, strong) NSArray       *viewControllersData;

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
    
    //添加TableView
    [self.view addSubview:self.tableView];
    
}

- (void)jumpToNaiviVC {
    TestNaviBarViewController *naviVC = [[TestNaviBarViewController alloc]init];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backBarButtonItem;
    [self.navigationController pushViewController:naviVC animated:nil];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify forIndexPath:indexPath];
    cell.textLabel.text = self.cellDataArray[indexPath.row];
    return cell;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[self.viewControllersData[indexPath.row] new] animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
    }
    return _tableView;
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray = @[@"渐变滚动",@"测试",@"3",@"4",@"5",@"6",@"7",
                       @"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
    }
    return _cellDataArray;
}

- (NSArray *)viewControllersData {
    if (!_viewControllersData) {
        _viewControllersData = @[RCGradualChangeViewController.self,TestNaviBarViewController.self];
    }
    return _viewControllersData;
}
@end
