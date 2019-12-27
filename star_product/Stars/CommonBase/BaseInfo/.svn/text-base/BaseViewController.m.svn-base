
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,copy) NSString *onceDataControl;//控制数据只加载一次的control

@end

@implementation BaseViewController

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
        
    NSLog(@"%@ - delloc",NSStringFromClass([self class]));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.memoryCache removeAllObjects];
}

//static Views without use nib
- (void)loadView {
    [super loadView];
    
    self.fd_prefersNavigationBarHidden=YES;
    
    [self.view addSubview:self.naviStand];
    self.naviStand.backgroundColor=naviColor;
    self.view.backgroundColor=pageColor;
    
    if (self.navigationController.viewControllers.count) {
        if (self.navigationController.viewControllers[0] != self) {
            
            [self addBack];
        }
    }
    
    [self staticViewsWithoutNib];
}

//设置title
- (void)setTitle:(NSString *)title{
    
    self.naviStand.title = title;
}

- (NSString *)title{
    
    return self.naviStand.title;
}

- (void)staticViewsWithoutNib {
    
}

/**
 添加返回
 */
- (void)addBack{
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
    back.frame=CGRectMake(0, 0, 22, 22);
    back.tag = 1002;
    
    back.isOverStepTouch = YES;
    back.hitTestEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.naviStand addSubview:back];
    
    [self.naviStand.leftButtons addObject:back];
}

/**
 返回
 */
- (void)back {
    
    if (self.navigationController.viewControllers.count) {
        if (self.navigationController.viewControllers[0] != self) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)setIsInteractivePopEnable:(BOOL)isInteractivePopEnable{
    
    self.fd_interactivePopDisabled = !isInteractivePopEnable;
}

- (NaviStandCopy *)naviStand{
    if (!_naviStand) {
        _naviStand=[[NaviStandCopy alloc]initWithTitle:@""];
        
    }
    return _naviStand;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.onceDataControl=@"1";
    [self loadData];
    
}

- (void)loadData {
    
}

- (NSString *)onceDataControl {
    if (!_onceDataControl) {
        
        [self onceDataInitialization];
    }
    return _onceDataControl;
}
//数据初始化，本身属性或者数据初始化,防止viewDidUnload之后重走view加载数据丢失---当然最好使用懒加载！
- (void)onceDataInitialization {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeViewsValue];
}

- (void)changeViewsValue{
    
}

#pragma mark - ShowHint
- (void)showHint:(NSString *)msg {
    
    if (!self.view.window || ![self isViewLoaded]) return;
    
    [self.view showHint:msg];
}

- (void)showLayerHint:(NSString *)msg {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [keyWindow showHint:msg];
}

#pragma mark - MJRefresh
- (void)setUpRefreshWithScrollView:(UIScrollView *)scrollView {
    
    [self setUpHeaderRefreshWithScrollView:scrollView];
    [self setUpFooterRefreshWithScrollView:scrollView];
  
}

- (void)setUpHeaderRefreshWithScrollView:(UIScrollView *)scrollView {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(headerRefresh:)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    scrollView.mj_header = header;
    
}
- (void)setUpFooterRefreshWithScrollView:(UIScrollView *)scrollView {
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(footerRefresh:)];
    footer.automaticallyHidden = YES;
    footer.stateLabel.hidden = YES;
    scrollView.mj_footer = footer;
}

- (void)headerRefresh:(MJRefreshNormalHeader *)header {
    
}

- (void)footerRefresh:(MJRefreshAutoNormalFooter *)footer {
    
}

#pragma mark - addTapHideKeyBoard
-(void)addTapHideKeyBoard:(UIView *)view {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideKeyBoard:)];
    [view addGestureRecognizer:singleTap];
}
-(void)tapHideKeyBoard:(UITapGestureRecognizer *)tap{
    
    [tap.view endEditing:YES];
}

@end
