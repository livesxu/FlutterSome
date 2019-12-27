//
//  AppDelegate+Notification.h
//  Shuzan
//
//  Created by Xu小波 on 2017/11/28.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Notification)

- (void)lx_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)lx_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)lx_application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
