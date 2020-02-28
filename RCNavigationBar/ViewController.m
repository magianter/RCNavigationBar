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

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, strong) NSArray       *cellDataArray;

@property (nonatomic, strong) NSArray       *viewControllersData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //右侧item
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 100, 100, 100);
    [leftButton setTitle:@"rightItem" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = leftItem;
    
    //Title
    self.navigationItem.title = @"RCNavigationBar";
    
    //添加TableView
    [self.view addSubview:self.tableView];
    
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
    UIViewController *vc = [self.viewControllersData[indexPath.row] new];
    [self.navigationController pushViewController:vc animated:YES];
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
        _cellDataArray = @[@"Gradient rolling"];
    }
    return _cellDataArray;
}

- (NSArray *)viewControllersData {
    if (!_viewControllersData) {
        _viewControllersData = @[RCGradualChangeViewController.self];
    }
    return _viewControllersData;
}
@end
