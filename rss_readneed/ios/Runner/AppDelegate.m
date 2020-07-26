#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()<FlutterStreamHandler>

@property (nonatomic, strong) FlutterEngine *flutterEngine;

@property (nonatomic, strong) FlutterMethodChannel *methodChannel;

@property (nonatomic, strong) FlutterEventChannel *eventChannel;

@property (nonatomic,   copy) FlutterEventSink eventSink;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    //bug注册
    [Bugly startWithAppId:@"b90f003c9f"];
    
    FlutterViewController *flutterVC = (FlutterViewController *)self.window.rootViewController;
    
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:@"channel" binaryMessenger:flutterVC.engine.binaryMessenger];
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqual:@"_bug_"]) {//报错
            NSDictionary *dic = call.arguments;
            [Bugly reportExceptionWithCategory:3 name:dic[@"name"] reason:dic[@"obj"] callStack:dic[@"stack"] extraInfo:@{} terminateApp:NO];
        }
        
    }];
    
    
//    FlutterViewController *flutterVC = (FlutterViewController *)self.window.rootViewController;
//    self.eventChannel = [FlutterEventChannel eventChannelWithName:@"scheme_open_url" binaryMessenger:flutterVC.engine.binaryMessenger];
//    [self.eventChannel setStreamHandler:self];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events; {
    
    self.eventSink = events;
    
    return nil;
}

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments; {
    
    return nil;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;{
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;{
    
//    self.eventSink(url.description);//注释传值方案，直接将内容写入到剪切板
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:url.description];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0);{
    
//    self.eventSink(url.description);//注释传值方案，直接将内容写入到剪切板
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:url.description];
    
    return YES;
 }

@end
