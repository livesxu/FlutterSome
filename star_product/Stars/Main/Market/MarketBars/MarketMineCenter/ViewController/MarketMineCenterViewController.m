//
//  MarketMineCenterViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "MarketMineCenterViewController.h"

@interface MarketMineCenterViewController ()

@end

@implementation MarketMineCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    self.title = @"个人中心";
    [self addBack];
}

- (void)back {
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
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
