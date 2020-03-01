//
//  RCNavigationBar.h
//  RCNavigationBar
//
//  Created by renchao on 2020/2/28.
//  Copyright © 2020 renchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TableViewHeaderHeightType) {
    tableViewHeaderLow = 0,
    tableViewHeaderMiddle,
    tableViewHeaderHight,
};

typedef void (^navigationBarItemBlock)(UIViewController *controller);

@interface RCNavigationBar : NSObject

/**require method*/
+ (RCNavigationBar *)shareInstanceManager;

- (void)manageNavigationBarWithController:(UIViewController *)baseController;

- (void)manageSliderSettingWithScrollView:(UITableView *)scrollView;

/**optional method*/
- (void)setHeaderHeightType:(TableViewHeaderHeightType)headerHeightType;

- (void)setNaivigationBarTransluent:(BOOL)isTransluent;

- (void)setnavigationBarIsShowSeperatedLine:(BOOL)isShowSeperatedLine;

- (void)setNavigationBarBackgroundImageWithColor:(UIColor *)backgroundcolor withColorAlpha:(CGFloat)colorAlpha barMetrics:(UIBarMetrics)barMetrics;

- (void)setTableViewHeaderImage:(UIImageView *)headerImageView;

- (void)setNavigationBarStyle:(UIBarStyle )barStyle;

- (void)setNavigationBarAlpha:(CGFloat)alphaFloat;


/// 滚动时导航栏渐变 *** 此方法必须和leftItemButton属性配合使用
/// @param slideView 滚动视图（UItableview）
/// @param viewHeight TableView.tableHeaderView 高度
- (void)scrollView:(UIScrollView *)slideView changeScrollViewGradualWithHeaderViewHeight:(CGFloat)viewHeight;

- (void)setNavigationBarLeftCustomView:(UIView *)leftCunstomView;


/// 左侧返回按钮
@property (nonatomic, strong) UIButton *leftItemButton;
@end

NS_ASSUME_NONNULL_END
