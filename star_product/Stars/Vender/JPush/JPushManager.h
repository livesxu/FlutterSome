//
//  JPushManager.h
//  Shuzan
//
//  Created by Xu小波 on 2017/11/28.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPushManager : NSObject

/**
 初始化推送平台
 */
+ (instancetype)manager;

/**
 注册Jpush推送
 */
- (void)registerJpush:(NSDictionary*)launchOptions;


/**
 处理推送结果

 @param userInfo info
 */
- (void)dealNotification:(NSDictionary *)userInfo;


/**
 消息处理

 @param toUrl 处理链接
 @param msgId 消息id
 */
- (void)jpushHandleUrl:(NSString *)toUrl MsgId:(NSString *)msgId;

//#pragma mark - 本地通知 -
//
///**
// 添加本地通知
// */
//- (void)addLocalNotiID:(NSString *)identifier title:(NSString *)notiTitle;

@end
