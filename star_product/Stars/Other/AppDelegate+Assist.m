//
//  AppDelegate+Assist.m
//  Stars
//
//  Created by Livespro on 2016/12/21.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "AppDelegate+Assist.h"
#import "UserCenter.h"
#import "MainTabBarViewController.h"
#import "LoginViewController.h"
@implementation AppDelegate (Assist)

//设置引导页和广告页
- (void)GuideAndLaunchAction {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

//    self.window.rootViewController = [[MainTabBarViewController alloc]init];
 
    self.window.rootViewController = [MainNaviController.alloc initWithRootViewController:LoginViewController.new];
}

@end
