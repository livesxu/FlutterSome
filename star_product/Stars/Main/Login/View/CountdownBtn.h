//
//  CountdownBtn.h
//  Shuzan
//
//  Created by ChangB on 2017/12/6.
//  Copyright © 2017年 Shujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownBtn : UIButton

/**
 开始计数

 @param hander 计数实时回调
 @param done 计数完成
 */
- (void)startCountingDownWith:(void(^)(NSInteger))hander completed:(void(^)(void))done;
/// 停止计数
- (void)stopCount;
/// 设置btn不可用状态
- (void)setBtnDisableWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor backgroundImg:(UIImage *)bgImg;
/// 设置btn可用状态
- (void)setBtnEnableWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor backgroundImg:(UIImage *)bgImg;
@end
