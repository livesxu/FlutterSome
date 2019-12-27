
//

#import "MainTabBarViewController.h"

#define kBarVCs @[@"MineViewController",@"TaskViewController",@"StarViewController",@"MarketViewController",@"CommunityViewController"]

#define kBarTitles @[@"我的",@"任务",@"明星",@"商场",@"社区"]

#define kBarImgs @[@"tab_home_n",@"tab_job_n",@"tab_star_n",@"tab_market_n",@"tab_community_n"]

#define kBarSelectedImgs @[@"tab_home_s",@"tab_job_p",@"tab_star_p",@"tab_market_n",@"tab_community_p"]

@interface MainTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self childrenCreate];
    
    self.delegate = self;
}

-(void)childrenCreate {
    
    for (NSInteger i=0; i < kBarVCs.count; i++) {
        
        Class BaseClass = NSClassFromString(kBarVCs[i]);
        
        BaseViewController *baseVC = [BaseClass new];

        //设置文本
        baseVC.tabBarItem.title = kBarTitles[i];
        //设置默认图标
        baseVC.tabBarItem.image = (kBarImgs[i] && ((NSString *)kBarImgs[i]).length) ? [UIImage imageNamed:kBarImgs[i]] : nil;
        //设置选中图标
        baseVC.tabBarItem.selectedImage = (kBarSelectedImgs[i] && ((NSString *)kBarSelectedImgs[i]).length) ? [[UIImage imageNamed:kBarSelectedImgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] : nil;
//        设置tabBar
        self.tabBar.tintColor = mainColor;
        
        MainNaviController *naviVC=[[MainNaviController alloc]initWithRootViewController:baseVC];
        
        [self addChildViewController:naviVC];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController.tabBarItem.title isEqual:kBarTitles[3]]) {
        
        LXRouteMap(@"star://MarketViewController.push");
        return NO;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;{
    
    if (self.selectedIndex == 2) {
        
        NSString *itemTitle = viewController.tabBarItem.title;
        if ([itemTitle isEqual:@"发布"]) {
            
            NSLog(@"发布事件");
        } else {
            viewController.tabBarItem.title = @"发布";
        }
        
    } else {
        
        UITabBarItem *item = tabBarController.tabBar.items[2];
        
        item.title = kBarTitles[2];
    }
}

@end
