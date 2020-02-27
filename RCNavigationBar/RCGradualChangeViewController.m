//
//  RCGradualChangeViewController.m
//  RCNavigationBar
//
//  Created by renchao on 2020/2/26.
//  Copyright © 2020 renchao. All rights reserved.
//

#import "RCGradualChangeViewController.h"

static NSString *const kGradualCellID = @"kGradualCellID";
static CGFloat const headerImageHeight = 200.0;

@interface RCGradualChangeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *leftCustomButton;
@end

@implementation RCGradualChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
//    self.navigationItem.title = @"gradual";
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0.0]] forBarMetrics:UIBarMetricsDefault];

//    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
    self.tableView.backgroundColor = [UIColor redColor];
    
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerImageHeight)];
    headerImage.image = [UIImage imageNamed:@"download.jpeg"];
    self.tableView.tableHeaderView = headerImage;
    
    //左侧按钮
    self.leftCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftCustomButton.frame = CGRectMake(0, 0, 42, 42);
    [self.leftCustomButton setTitle:@"back" forState:UIControlStateNormal];
    [self.leftCustomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftCustomButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftCustomButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"contentOffset.y==%f",scrollView.contentOffset.y);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y< headerImageHeight - navigationBarHeight - statusBarHeight) {
            self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0.0]] forBarMetrics:UIBarMetricsDefault];
            [self.leftCustomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            //导航栏逐渐消失
            if ((scrollView.contentOffset.y < headerImageHeight - navigationBarHeight - statusBarHeight) && (scrollView.contentOffset.y >= headerImageHeight - 2*navigationBarHeight - statusBarHeight)) {
                CGFloat hidedAlphaValue = (headerImageHeight - navigationBarHeight - statusBarHeight - scrollView.contentOffset.y)/(navigationBarHeight);
                self.navigationController.navigationBar.alpha = hidedAlphaValue;
                [self.leftCustomButton setTitleColor:[[UIColor whiteColor]colorWithAlphaComponent:hidedAlphaValue] forState:UIControlStateNormal];
            }
        }else if (scrollView.contentOffset.y >= headerImageHeight - navigationBarHeight - statusBarHeight) {
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            //导航栏逐渐显示
            CGFloat showAlphaHeight = (scrollView.contentOffset.y - (headerImageHeight - navigationBarHeight - statusBarHeight))/navigationBarHeight;
            if (showAlphaHeight >= 1.0) {
                showAlphaHeight = 1.0;
            }
            
            self.navigationController.navigationBar.alpha = showAlphaHeight;
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:showAlphaHeight]] forBarMetrics:UIBarMetricsDefault];
            [self.leftCustomButton setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:showAlphaHeight] forState:UIControlStateNormal];
        }else if (scrollView.contentOffset.y < 0) {
            self.navigationController.navigationBar.alpha = 1;
        }
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"contentOffset.y==%f",scrollView.contentOffset.y);
//    CGFloat navigationBarAndStatusBar = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
//
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 200;
//
////        if (scrollView.contentOffset.y > -navigationBarAndStatusBar && scrollView.contentOffset.y < sectionHeaderHeight+navigationBarAndStatusBar) {
////            scrollView.contentInset = UIEdgeInsetsMake(-navigationBarAndStatusBar - scrollView.contentOffset.y, 0, 0, 0);
////        }else if (scrollView.contentOffset.y >= sectionHeaderHeight + navigationBarAndStatusBar) {
////            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight-navigationBarAndStatusBar, 0, 0, 0);
////        }
//
//        //不直接用TableView.tableHeaderView
//        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0, 0, 0);
//        }else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//
//    NSLog(@"scrollView.contentInset.top===%f",scrollView.contentInset.top);
//}

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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerImageHeight)];
//    headerImage.image = [UIImage imageNamed:@"download.jpeg"];
//    return headerImage;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:kGradualCellID];
    }
    return _tableView;
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
