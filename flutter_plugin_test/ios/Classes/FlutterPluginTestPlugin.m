#import "FlutterPluginTestPlugin.h"

@implementation FlutterPluginTestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin_name_match"
            binaryMessenger:[registrar messenger]];
  FlutterPluginTestPlugin* instance = [[FlutterPluginTestPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"showMsg" isEqualToString:call.method]) {
      
      NSString *msg = call.arguments;
      
      result([msg stringByAppendingString:@"ppiOSpp"]);
      
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
