//
//  UIView+ShowStatus.h
//  Stars
//
//  Created by Xu小波 on 2017/12/16.
//  Copyright © 2017年 Livesxu. All rights reserved.
// 状态页面

#import <UIKit/UIKit.h>

typedef void(^RetryAction)(void);

typedef NS_ENUM(NSInteger, CommonShowStatus) {
    
    CommonShowStatusNomal = 0,
    CommonShowStatusError,
};

@interface UIView (ShowStatus)

@property ( nonatomic ) CGRect    statusRect;//状态范围 - 若是需要调整，请设置状态之前设置

@property ( nonatomic ) CommonShowStatus statusFlag;//状态标识 0:正常状态 1:error

@property (nonatomic  ) RetryAction retryAction;


/**
 显示error界面

 @param retry 重试操作
 */
- (void)showErrorRetry:(RetryAction)retry;

@end
