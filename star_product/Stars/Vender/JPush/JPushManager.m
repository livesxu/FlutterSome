////
////  JPushManager.m
////  Shuzan
////
////  Created by Xu小波 on 2017/11/28.
////  Copyright © 2017年 FZ. All rights reserved.
////
//
//#import "JPushManager.h"
//
//#import "JPUSHService.h"
//#import <AdSupport/AdSupport.h>
//
//#import "JKNotifier.h"
//
//#import "AlertBlockTips+Authorize.h"
//
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#endif
//
//#pragma mark - 极光
//NSString *const LXJPushAppID = @"babd8e00a50b755ecde8b519";
//NSString *const LXChannel = @"iOS channel";
//
//@interface JPushManager ()<JPUSHRegisterDelegate>
//
//@end
//
//@implementation JPushManager
//
//- (void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
//}
//
//+ (instancetype)manager {
//    static JPushManager *manager;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[JPushManager alloc] init];
//    });
//    return manager;
//}
//
//- (instancetype)init {
//    if (self = [super init]) {
//
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
//        
//    }
//    return self;
//}
//
///**
// 注册推送
// */
//- (void)registerJpush:(NSDictionary*)launchOptions;{
//    
////    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
//////        2.通知鉴权 - 在消息页面做固定提示。
////        NSLog(@"没有开启推送");
////        [[[AlertBlockTips alloc]init] alertToAuthorize:LXAuthorizeUnusualStatusNoti];
////    }
//    
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    
//    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        //      NSSet<UNNotificationCategory *> *categories;
//        //      entity.categories = categories;
//        //    }
//        //    else {
//        //      NSSet<UIUserNotificationCategory *> *categories;
//        //      entity.categories = categories;
//        //    }
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    
//    // 3.0.0以前版本旧的注册方式
//    //  if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//    //#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//    //    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    //    entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
//    //    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    //#endif
//    //  } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//    //      //可以添加自定义categories
//    //      [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//    //                                                        UIUserNotificationTypeSound |
//    //                                                        UIUserNotificationTypeAlert)
//    //                                            categories:nil];
//    //  } else {
//    //      //categories 必须为nil
//    //      [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//    //                                                        UIRemoteNotificationTypeSound |
//    //                                                        UIRemoteNotificationTypeAlert)
//    //                                            categories:nil];
//    //  }
//    
//    //如不需要使用IDFA，advertisingIdentifier 可为nil
//    [JPUSHService setupWithOption:launchOptions appKey:LXJPushAppID
//                          channel:LXChannel
//                 apsForProduction:kIsProduction
//            advertisingIdentifier:advertisingId];
//}
//
//#pragma mark - 进入前台
//- (void)applicationDidBecomeActive:(NSNotification *)notification{
//    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [JPUSHService setBadge:0];
//}
//
//#pragma mark - 进入后台
//- (void)applicationDidEnterBackground:(NSNotification *)notification{
//    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//}
//
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#pragma mark- JPUSHRegisterDelegate
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//    
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
////        NSLog(@"iOS10 前台将要弹出远程通知:%@", [self logDic:userInfo]);
////        [self dealNotification:userInfo];
//        
//        NSString *toUrl = userInfo[@"toUrl"];
//        //如果是家族审核通过信息,刷新家族信息
//        if (toUrl && [NSURL URLWithString:toUrl] && [[NSURL URLWithString:toUrl].host isEqualToString:@"family.push"]) {
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshFamilysInfo" object:@{@"isRenew":@(YES)}];
//        }
//    
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//}
//
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//    
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//    
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
////        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
//        [self dealNotification:userInfo];
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    
//    completionHandler();  // 系统要求执行这个方法
//}
//#endif
//
//
//#pragma mark - 处理推送结果 -
///**
// 处理推送结果
// 
// @param userInfo info
// */
//- (void)dealNotification:(NSDictionary *)userInfo;{
//    
//    NSDictionary*dict=[userInfo objectForKey:@"aps"];
//    
//    NSString *toUrl = userInfo[@"toUrl"];
//    NSString *msgId = userInfo[@"msgId"];
//    NSString *alertString = dict[@"alert"];
//    // 应用在前台 -
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive && [UIDevice currentDevice].systemVersion.floatValue < 10.0) {
//
//        [self foregroundHandle:toUrl MsgId:msgId Alert:alertString];
//    }else{
//
//        [self jpushHandleUrl:toUrl MsgId:msgId];
//    }
//}
//
//- (void)foregroundHandle:(NSString *)toUrl MsgId:(NSString *)msgId Alert:(NSString *)alertString{
//    
//    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
//    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
//    [JKNotifier showNotifer:alertString name:appName icon:[UIImage imageNamed:@"icon.png"]];
//    
//    __weak typeof(self) weakSelf = self;
//    [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
//        
//        [weakSelf jpushHandleUrl:toUrl MsgId:msgId];
//        
//        [notifier dismiss];
//    }];
//}
//
///**
// 消息处理相关操作
//
// @param toUrl 操作url
// @param msgId 消息id
// */
//- (void)jpushHandleUrl:(NSString *)toUrl MsgId:(NSString *)msgId{
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        LXRouteMap(toUrl);
//    });
//    //
////    CommonRequestApi *api = [[CommonRequestApi alloc]init].lxRequestURL(kAPI(@"/msg/hadRead")).lxBody(@{@"msgId":msgId ? msgId:@""});
////    [api startWithNomalCompletionBlock:^(BOOL isSuccess, id responseData) {
////        NSLog(@"%@",responseData);
////    }];
//}
//
////#pragma mark - 本地通知 -
////
/////**
//// 添加本地通知
//// */
////- (void)addLocalNotiID:(NSString *)identifier title:(NSString *)notiTitle;{
////
////    JPushNotificationRequest *notiR = [[JPushNotificationRequest alloc]init];
////    notiR.requestIdentifier = [@"locationHelper_" stringByAppendingString:identifier];
////
////
////    JPushNotificationContent *notiRContent = [[JPushNotificationContent alloc]init];
////
////    notiRContent.title = notiTitle;
//////    notiRContent.body = @"";
////    notiRContent.badge = @(-1);
//////    notiRContent.sound =
////
////    notiR.content = notiRContent;
////
////    JPushNotificationTrigger *notiRT = [[JPushNotificationTrigger alloc]init];
////
////    notiRT.timeInterval = 1;
////    notiRT.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.3f];
////
////    notiR.trigger = notiRT;
////
////    notiR.completionHandler = ^(id result) {
////
////        NSLog(@"result");
////    };
////
////    [JPUSHService addNotification:notiR];
////}
//
//@end
