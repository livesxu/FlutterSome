//
//  MarketViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "MarketViewController.h"

@interface MarketViewController ()

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    self.fd_prefersNavigationBarHidden=YES;
    
    [self childrenCreate];
}

-(void)childrenCreate {
    
    NSArray *barVCs = @[@"MarketHomeViewController",@"MarketWallViewController",@"MarketMineCenterViewController",@"MarketShopViewController"];
    
    NSArray *barTitles = @[@"星钻商城",@"星愿墙",@"个人中心",@"店铺主页"];
    
    NSArray *barImgs = @[@"tab_market_home_n",@"tab_market_wishwall_n",@"tab_market_profile_n",@"tab_market_shop_n"];
    
    NSArray *barSelectedImgs = @[@"tab_market_home_p",@"tab_market_wishwall_p",@"tab_market_profile_p",@"tab_market_shop_n"];
    
    for (NSInteger i=0; i < barVCs.count; i++) {
        
        Class BaseClass = NSClassFromString(barVCs[i]);
        
        BaseViewController *baseVC = [BaseClass new];
        
        //设置文本
        baseVC.tabBarItem.title = barTitles[i];
        //设置默认图标
        baseVC.tabBarItem.image = (barImgs[i] && ((NSString *)barImgs[i]).length) ? [UIImage imageNamed:barImgs[i]] : nil;
        //设置选中图标
        baseVC.tabBarItem.selectedImage = (barSelectedImgs[i] && ((NSString *)barSelectedImgs[i]).length) ? [[UIImage imageNamed:barSelectedImgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] : nil;
        //        设置tabBar
        self.tabBar.tintColor = mainColor;
        
        MainNaviController *naviVC=[[MainNaviController alloc]initWithRootViewController:baseVC];
        
        [self addChildViewController:naviVC];
    }
}

/**
 加载数据
 */
- (void)loadData;{
    
}
#pragma mark - Change Values


#pragma mark - Delegate


#pragma mark - Lazy load


@end
