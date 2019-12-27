//
//  AOPTask.m
//  Shuzan
//
//  Created by Xu小波 on 2018/2/7.
//  Copyright © 2018年 Shujin. All rights reserved.
//

#import "LXAOPTask.h"

@implementation LXAOPTask

+ (void)performTask:(NSDictionary *)taskConfig;{
    
    //HookSel
    for (NSString *className in taskConfig) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = taskConfig[className];
        
        for (NSString *hookSel in config) {
            
            SEL selector = NSSelectorFromString(hookSel);
            AspectHandlerBlock block = config[hookSel];
            
            [clazz aspect_hookSelector:selector
                           withOptions:AspectPositionAfter
                            usingBlock:^(id<AspectInfo> aspectInfo) {
                                block(aspectInfo);
                            } error:NULL];
        }
    }
}

@end
