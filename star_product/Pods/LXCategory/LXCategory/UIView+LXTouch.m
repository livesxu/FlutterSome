//
//  UIImageView+LXTouch.m

//  Created by Xu小波 on 2018/12/5.
//  Copyright © 2018年 Xu小波. All rights reserved.
//

#import "UIView+LXTouch.h"
#import <objc/runtime.h>

static const int gr_key;
static const int gr_action_key;
static const int action_callInterval_key;

@implementation UIView (LXTouch)

- (NSTimeInterval)callInterval {
    
    return ((NSNumber *)objc_getAssociatedObject(self, &action_callInterval_key)).doubleValue;
}

- (void)setCallInterval:(NSTimeInterval)callInterval {
    
    objc_setAssociatedObject(self, &action_callInterval_key, @(callInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TouchBlock)touchAction {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTouchAction:(TouchBlock)touchAction {
    
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:[self lxTouchGr]];
    
    objc_setAssociatedObject(self, @selector(touchAction), touchAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)lxTouchGr {
    
    UITapGestureRecognizer *gr_temp = objc_getAssociatedObject(self, &gr_key);
    if (!gr_temp) {
        
        gr_temp = [[UITapGestureRecognizer alloc]init];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        LXTargetBlockItem *actionItem = objc_getAssociatedObject(self, &gr_action_key);
        if (!actionItem) {
            //添加方法
            class_addMethod([LXTargetBlockItem class], @selector(view_gr_invoke:), (IMP)view_gr_invoke, "v@:@");
            
            actionItem = [[LXTargetBlockItem alloc]init];
            actionItem.callInterval = self.callInterval > 0 ? self.callInterval : 0 ;
            __weak typeof(self) weakSelf = self;
            actionItem.block = ^(id selInfo) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                UITapGestureRecognizer *touchGr = selInfo;
                strongSelf.touchAction(touchGr.view,[touchGr locationInView:touchGr.view]);
            };
            objc_setAssociatedObject(self, &gr_action_key, actionItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [gr_temp addTarget:actionItem action:@selector(view_gr_invoke:)];
#pragma clang diagnostic pop
        
        objc_setAssociatedObject(self, &gr_key, gr_temp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return gr_temp;
}

void view_gr_invoke(id self, SEL _cmd, id sender) {
    
    LXTargetBlockItem *self_temp = self;
    
    // --- 回调间隔操作 --->
    if (self_temp.callInterval > 0) {
        
        NSTimeInterval callTime = [[NSDate date] timeIntervalSince1970];
        if (self_temp.lastCall > 0 && (callTime - self_temp.lastCall) < self_temp.callInterval) {
            
            return;
        }
        self_temp.lastCall = callTime;
    }
    // <--- 回调间隔操作 ---
    
    if (self_temp.block) {
        
        self_temp.block(sender);
    }
}

- (void)lx_addActionWithBlock:(TouchBlock)block {
    
    self.touchAction = block;
}

@end

static const int event_block_targets_key;

@implementation UIControl (LXTouch)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (NSMutableArray *)lx_allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &event_block_targets_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &event_block_targets_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        //建立集合时给target添加方法
        class_addMethod([LXTargetBlockItem class], @selector(control_event_invoke:), (IMP)control_event_invoke, "v@:@");
    }
    return targets;
}

/**
 间隔 - 响应式事件 添加/替换
 
 @param controlEvents controlEvents
 @param intervalTime 响应间隔时间
 @param block Action
 */
- (void)lx_addActionWithControlEvents:(UIControlEvents)controlEvents
                         callInterval:(NSTimeInterval)intervalTime
                                block:(void (^)(id sender))block {
    if (!controlEvents) return;
    LXTargetBlockItem *actionItem = [[LXTargetBlockItem alloc]init];
    actionItem.tag = controlEvents;
    actionItem.callInterval = intervalTime > 0 ? intervalTime : ( self.callInterval > 0 ? self.callInterval : 0 );
    actionItem.block = ^(id selInfo) {
        block(selInfo);
    };
    [self lx_addTarget:actionItem action:@selector(control_event_invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self lx_allUIControlBlockTargets];
    [targets addObject:actionItem];
}
#pragma clang diagnostic pop

void control_event_invoke(id self, SEL _cmd, id sender) {
    
    LXTargetBlockItem *self_temp = self;
    
    // --- 回调间隔操作 --->
    if (self_temp.callInterval > 0) {
        
        NSTimeInterval callTime = [[NSDate date] timeIntervalSince1970];
        if (self_temp.lastCall > 0 && (callTime - self_temp.lastCall) < self_temp.callInterval) {
            
            return;
        }
        self_temp.lastCall = callTime;
    }
    // <--- 回调间隔操作 ---
    
    if (self_temp.block) {
        
        self_temp.block(sender);
    }
}

- (void)lx_addActionWithControlEvents:(UIControlEvents)controlEvents
                                block:(void (^)(id sender))block {
    
    [self lx_addActionWithControlEvents:controlEvents callInterval:0 block:block];
}

- (void)lx_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
              forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)lx_removeActionWithControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self lx_allUIControlBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LXTargetBlockItem *target = obj;
        
        if (target.tag == controlEvents) {
            
            [self removeTarget:target action:NULL forControlEvents:controlEvents];
            [targets removeObject:target];
            
            *stop = YES;
        }
    }];
}

/**
 点击事件 - UIControlEventTouchUpInside
 
 @param block block
 */
- (void)lx_addActionTouchWithBlock:(void (^)(UIControl *sender))block {
    
    [self lx_addActionWithControlEvents:UIControlEventTouchUpInside block:block];
}

- (void)lx_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self lx_allUIControlBlockTargets] removeAllObjects];
}

@end

@implementation LXTargetBlockItem

@end
