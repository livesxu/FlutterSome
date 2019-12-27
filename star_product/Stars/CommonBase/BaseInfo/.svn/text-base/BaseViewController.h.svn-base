
//

#import <UIKit/UIKit.h>
#import "NaviStandCopy.h"
#import "MJRefresh.h"

#define kErrorImage @""
#define kNoResultImage @""

#define kNaviH (StatebarHeight() + Layout(44))

typedef NS_ENUM(NSInteger, BaseShowStatus) {
    BaseShowStatusDefault = 0,
    BaseShowStatusLoading,
    BaseShowStatusError,
    BaseShowStatusNoResult
};

@interface BaseViewController : UIViewController

@property (nonatomic,assign) BOOL isInteractivePopEnable;//是否可以手势返回

@property (nonatomic,strong) NaviStandCopy *naviStand;//导航栏

- (void)staticViewsWithoutNib;

- (void)addBack;

/**
 初始化数据
 */
- (void)onceDataInitialization;

/**
 ViewDidLoad 加载数据
 */
- (void)loadData;

/**
 willAppear 修改数据
 */
- (void)changeViewsValue;

/**
 返回
 */
- (void)back;

#pragma mark - MJRefresh
- (void)setUpRefreshWithScrollView:(UIScrollView *)scrollView;

- (void)setUpHeaderRefreshWithScrollView:(UIScrollView *)scrollView;

- (void)setUpFooterRefreshWithScrollView:(UIScrollView *)scrollView;

- (void)headerRefresh:(MJRefreshNormalHeader *)header;

- (void)footerRefresh:(MJRefreshAutoNormalFooter *)footer;

#pragma mark - addTapHideKeyBoard
-(void)addTapHideKeyBoard:(UIView *)view;

@end
