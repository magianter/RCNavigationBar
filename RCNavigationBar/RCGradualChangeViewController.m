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
@end

@implementation RCGradualChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.title = @"gradual";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
    self.tableView.backgroundColor = [UIColor redColor];
    
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerImageHeight)];
    headerImage.image = [UIImage imageNamed:@"download.jpeg"];
    self.tableView.tableHeaderView = headerImage;
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"contentOffset.y==%f",scrollView.contentOffset.y);
//    CGFloat navigationBarAndStatusBar = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
//
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 200;
//
//        if (scrollView.contentOffset.y > -navigationBarAndStatusBar && scrollView.contentOffset.y < sectionHeaderHeight+navigationBarAndStatusBar) {
//            scrollView.contentInset = UIEdgeInsetsMake(-navigationBarAndStatusBar - scrollView.contentOffset.y, 0, 0, 0);
//        }else if (scrollView.contentOffset.y >= sectionHeaderHeight + navigationBarAndStatusBar) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight-navigationBarAndStatusBar, 0, 0, 0);
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
