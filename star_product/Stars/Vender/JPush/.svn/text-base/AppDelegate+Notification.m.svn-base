////
////  AppDelegate+Notification.m
////  Shuzan
////
////  Created by Xu小波 on 2017/11/28.
////  Copyright © 2017年 FZ. All rights reserved.
////
//
//#import "AppDelegate+Notification.h"
//
//#import "JPUSHService.h"
//#import "JPushManager.h"
//
//@implementation AppDelegate (Notification)
//
//- (void)lx_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//    
//    if (![UserCenter center].storeInfo.deviceTokenString) {
//        
//        NSMutableString *deviceTokenString1=[[NSMutableString alloc]init];
//        
//        const char *bytes = deviceToken.bytes;
//        
//        NSUInteger iCount = deviceToken.length;
//        
//        for (int i = 0; i < iCount; i++) {
//            
//            [deviceTokenString1 appendFormat:@"%02x", bytes[i]&0x000000FF];
//        }
//        
//        NSLog(@"%@",deviceTokenString1);
//        
//        [UserCenter center].storeInfo.deviceTokenString = deviceTokenString1;
//    }
//    
//}
//
//- (void)lx_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//    
//}
//
//
////iOS7及以上系统，收到通知
//- (void)lx_application:(UIApplication *)application
//        didReceiveRemoteNotification:(NSDictionary *)userInfo
//        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    [JPUSHService handleRemoteNotification:userInfo];
//    
//    //通知处理
//    [[JPushManager manager] dealNotification:userInfo];
//    
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//@end
