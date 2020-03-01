//
//  RCGradualChangeViewController.m
//  RCNavigationBar
//
//  Created by renchao on 2020/2/26.
//  Copyright © 2020 renchao. All rights reserved.
//

#import "RCGradualChangeViewController.h"
#import "RCNavigationBar.h"

static NSString *const kGradualCellID = @"kGradualCellID";
static CGFloat const headerImageHeight = 200.0;

@interface RCGradualChangeViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *leftCustomButton;
@property (nonatomic, weak) id<UIGestureRecognizerDelegate>gestureDelegate;
@property (nonatomic, assign) TableViewHeaderHeightType headerHeaderViewHeightLevel;

@end

@implementation RCGradualChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerImageHeight)];
    headerImage.image = [UIImage imageNamed:@"download.jpeg"];
    
    //左侧按钮
    self.leftCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftCustomButton.frame = CGRectMake(0, 0, 42, 42);
    [self.leftCustomButton setTitle:@"back" forState:UIControlStateNormal];
    [self.leftCustomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftCustomButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftCustomButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    self.headerHeaderViewHeightLevel = tableViewHeaderHight;
    [[RCNavigationBar shareInstanceManager] manageNavigationBarWithController:self];
    [[RCNavigationBar shareInstanceManager] manageSliderSettingWithScrollView:self.tableView];
    [[RCNavigationBar shareInstanceManager] setNaivigationBarTransluent:YES];
    [[RCNavigationBar shareInstanceManager] setnavigationBarIsShowSeperatedLine:NO];
    [[RCNavigationBar shareInstanceManager] setNavigationBarBackgroundImageWithColor:[UIColor whiteColor] withColorAlpha:0.0 barMetrics:UIBarMetricsDefault];
    [[RCNavigationBar shareInstanceManager] setTableViewHeaderImage:headerImage];
    
    [[RCNavigationBar shareInstanceManager] setNavigationBarLeftCustomView:self.leftCustomButton];
    [RCNavigationBar shareInstanceManager].leftItemButton = self.leftCustomButton;

}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[RCNavigationBar shareInstanceManager] setNavigationBarStyle:UIBarStyleBlackTranslucent];
    [[RCNavigationBar shareInstanceManager] setNavigationBarAlpha:1.0f];
    
    self.gestureDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[RCNavigationBar shareInstanceManager] setNavigationBarStyle:UIBarStyleDefault];
    [[RCNavigationBar shareInstanceManager] setNavigationBarAlpha:1.0f];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self.gestureDelegate;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [[RCNavigationBar shareInstanceManager] scrollView:scrollView changeScrollViewGradualWithHeaderViewHeight:headerImageHeight];
}

#pragma mark - TableViewDataDelegate & TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGradualCellID forIndexPath:indexPath];
    cell.textLabel.text = @"gradualCell";
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:kGradualCellID];
    }
    return _tableView;
}

@end
