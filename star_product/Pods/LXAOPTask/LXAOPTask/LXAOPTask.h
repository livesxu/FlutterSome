//
//  AOPTask.h
//  Shuzan
//
//  Created by Xu小波 on 2018/2/7.
//  Copyright © 2018年 Shujin. All rights reserved.
//注意点：1.hook最好在控制器留下痕迹，否则很容易造坑 - 我一般使用taskHold
//      2.aspects 类hook 都会被保存到NSObject应用上，AspectTracker为防止同一方法被多次hook，导致 类hook 方法都不能一样，可以像截图处理，但                                    需手动保证类方法不被多次hook
//hook格式:
/* taskConfig:
 @{
    @"className1":@{@"HookSEL":HandlerBlock,
                    @"HookSEL1":HandlerBlock1,
                    },
    @"className2":@{@"HookSEL":HandlerBlock,
                    @"HookSEL1":HandlerBlock1,
                    },
 }
 
 
 */

#import <UIKit/UIKit.h>

#import <Aspects/Aspects.h>

//#define AOPTaskEventSELName @"AOPTaskEventHookSEL"
//#define AOPTaskEventHandlerBlock @"AOPTaskEventHandlerBlock"

typedef void (^AspectHandlerBlock)(id<AspectInfo> aspectInfo);

@interface LXAOPTask : NSObject

+ (void)performTask:(NSDictionary *)taskConfig;

@end
