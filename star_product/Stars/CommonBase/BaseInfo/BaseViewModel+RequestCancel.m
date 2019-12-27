//
//  BaseViewModel+RequestCancel.m
//  Stars
//
//  Created by Xu小波 on 2017/11/23.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "BaseViewModel+RequestCancel.h"

#import <objc/runtime.h>

@interface BaseViewModel ()

@property (nonatomic, strong) NSMutableArray *lxContainRequest;

@end

@implementation BaseViewModel (RequestCancel)

- (void)setLxContainRequest:(NSMutableArray *)lxContainRequest{
    
    objc_setAssociatedObject(self, @selector(lxContainRequest), lxContainRequest, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)lxContainRequest{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)autoCancelRequestWith:(id)requestId;{
    
    if (!self.lxContainRequest) {
        
        self.lxContainRequest = [NSMutableArray array];
    }
    
    [self.lxContainRequest addObject:requestId];
}

+ (void)load{
    
    [self aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        
        BaseViewModel *viewModel = info.instance;
        
        if (viewModel.lxContainRequest) {
            
            for (id requestId in viewModel.lxContainRequest) {
                
                if ([requestId isKindOfClass:[CommonRequestApi class]]) {
                    
                    [requestId stop];
                }
            }
        }
        
    } error:nil];
}

@end
