//
//  UIDevice+CurrentDevice.h
//  Shuzan
//
//  Created by Livespro on 2016/12/19.
//  Copyright © 2016年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define lxStateHeight StatebarHeight()
#define lxIsPhoneX isIphoneHair()
#define lxBottomAreaHeight (isIphoneHair() ? 34.0 : 0)

@interface UIDevice (CurrentDevice)

//获取设备型号
NSString *iphoneTypeGet(void);

/**
 状态栏高度 - 如果开热点，高度不包含在内 - 需要监听UIApplicationDidChangeStatusBarFrameNotification比对操作

 @return 状态栏高度
 */
CGFloat StatebarHeight(void);

/**
 是否刘海屏 - x系列

 @return bool
 */
BOOL isIphoneHair(void);

/**
 网络是否连接

 @return 网络是否连接
 */
BOOL isConnectionAvailable(void);

@end
