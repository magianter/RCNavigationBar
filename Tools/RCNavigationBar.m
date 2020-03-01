//
//  RCNavigationBar.m
//  RCNavigationBar
//
//  Created by renchao on 2020/2/28.
//  Copyright © 2020 renchao. All rights reserved.
//

#import "RCNavigationBar.h"

@interface RCNavigationBar ()
@property (nonatomic, assign) TableViewHeaderHeightType headerHeightType;
@property (nonatomic, strong) UIViewController  *baseController;
@property (nonatomic, strong) UITableView      *baseTableView;
@property (nonatomic, strong) UIView            *leftItemCustomView;

@end

@implementation RCNavigationBar

+ (RCNavigationBar *)shareInstanceManager {
    static RCNavigationBar *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RCNavigationBar alloc]init];
    });
    return manager;
}

- (void)initRCNavigationBarBaseStatusWithManager:(RCNavigationBar *)manager {
    manager.headerHeightType = tableViewHeaderHight;
}

- (void)manageNavigationBarWithController:(UIViewController *)controller {
    self.baseController = controller;
}

- (void)manageSliderSettingWithScrollView:(UITableView *)scrollView {
    self.baseTableView = scrollView;
    self.baseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

- (void)setNaivigationBarTransluent:(BOOL)isTransluent {
    if (self.baseController) {
        self.baseController.navigationController.navigationBar.translucent = isTransluent;
    }
}

- (void)setHeaderHeightType:(TableViewHeaderHeightType)headerHeightType {
    self.headerHeightType = headerHeightType;
}

- (void)setnavigationBarIsShowSeperatedLine:(BOOL)isShowSeperatedLine {
    if (isShowSeperatedLine == NO) {
        self.baseController.navigationController.navigationBar.shadowImage = [UIImage new];
    }
}

- (void)setNavigationBarBackgroundImageWithColor:(UIColor *)backgroundcolor withColorAlpha:(CGFloat)colorAlpha barMetrics:(UIBarMetrics)barMetrics {
    [self.baseController.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[backgroundcolor colorWithAlphaComponent:colorAlpha]] forBarMetrics:barMetrics];
}

- (void)setTableViewHeaderImage:(UIImageView *)headerImageView {
    UIImageView *imageView = headerImageView;
    self.baseTableView.tableHeaderView = imageView;
}

- (void)setNavigationBarStyle:(UIBarStyle )barStyle {
    self.baseController.navigationController.navigationBar.barStyle = barStyle;
}

- (void)setNavigationBarAlpha:(CGFloat)alphaFloat {
    self.baseController.navigationController.navigationBar.alpha = alphaFloat;
}

- (void)setNavigationBarLeftCustomView:(UIView *)leftCunstomView {
    self.leftItemCustomView = leftCunstomView;
     UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItemCustomView];
    self.baseController.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)scrollView:(UIScrollView *)slideView changeScrollViewGradualWithHeaderViewHeight:(CGFloat)viewHeight {
    UIScrollView * scrollView = slideView;
    CGFloat headerViewHeight = viewHeight;
    CGFloat navigationBarHeight = self.baseController.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < headerViewHeight - navigationBarHeight - statusBarHeight) {
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [self setNavigationBarStyle:UIBarStyleBlackTranslucent];
//        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0.0]] forBarMetrics:UIBarMetricsDefault];
        [self setNavigationBarBackgroundImageWithColor:[UIColor whiteColor] withColorAlpha:0.0 barMetrics:UIBarMetricsDefault];
        if (self.leftItemButton) {
            [self.leftItemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        //导航栏逐渐消失
        if ((scrollView.contentOffset.y < headerViewHeight - navigationBarHeight - statusBarHeight) && (scrollView.contentOffset.y >= headerViewHeight - 2*navigationBarHeight - statusBarHeight)) {
            CGFloat hidedAlphaValue = (headerViewHeight - navigationBarHeight - statusBarHeight - scrollView.contentOffset.y)/(navigationBarHeight);
//            self.navigationController.navigationBar.alpha = hidedAlphaValue;
            [self setNavigationBarAlpha:hidedAlphaValue];
            if (self.leftItemButton) {
                [self.leftItemButton setTitleColor:[[UIColor whiteColor]colorWithAlphaComponent:hidedAlphaValue] forState:UIControlStateNormal];
            }
            
        }
    }else if (scrollView.contentOffset.y >= headerViewHeight - navigationBarHeight - statusBarHeight) {
//        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        [self setNavigationBarStyle:UIBarStyleDefault];
        //导航栏逐渐显示
        CGFloat showAlphaHeight = (scrollView.contentOffset.y - (headerViewHeight - navigationBarHeight - statusBarHeight))/navigationBarHeight;
        if (showAlphaHeight >= 1.0) {
            showAlphaHeight = 1.0;
        }
        
//        self.navigationController.navigationBar.alpha = showAlphaHeight;
        [self setNavigationBarAlpha:showAlphaHeight];
//        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:showAlphaHeight]] forBarMetrics:UIBarMetricsDefault];
        [self setNavigationBarBackgroundImageWithColor:[UIColor whiteColor] withColorAlpha:showAlphaHeight barMetrics:UIBarMetricsDefault];
        if (self.leftItemButton) {
            [self.leftItemButton setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:showAlphaHeight] forState:UIControlStateNormal];
        }
        
    }else if (scrollView.contentOffset.y < 0) {
//        self.navigationController.navigationBar.alpha = 1;
        [self setNavigationBarAlpha:1.0];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
