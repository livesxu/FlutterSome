//
//  NSObject+LXObserver.m
//
//  Created by Livesxu on 2018/12/26.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "NSObject+LXObserver.h"
#import <objc/runtime.h>

static const int kvo_observer_targets_key;
static const int noti_observer_targets_key;

@implementation NSObject (LXObserver)

#pragma mark - kvo -
- (NSMutableDictionary *)lx_allKVOObserverBlocks {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &kvo_observer_targets_key);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &kvo_observer_targets_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(__weak id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) return;
    LXObserverTargetBlockItem *target = [[LXObserverTargetBlockItem alloc] init];
    target.kvoBlock = block;
    NSMutableDictionary *dic = [self lx_allKVOObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *dic = [self lx_allKVOObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    
    [dic removeObjectForKey:keyPath];
}

- (void)removeKVOObserverBlocks {
    NSMutableDictionary *dic = [self lx_allKVOObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
            
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    
    [dic removeAllObjects];
}

#pragma mark - notification -
- (NSMutableDictionary *)lx_allNotiObserverBlocks {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &noti_observer_targets_key);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &noti_observer_targets_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

- (void)addNotificationObserverBlockForName:(NSNotificationName)name block:(void (^)(NSNotification *notification))block {
    if (!name || !block) return;
    LXObserverTargetBlockItem *target = [[LXObserverTargetBlockItem alloc] init];
    target.notiBlock = block;
    NSMutableDictionary *dic = [self lx_allNotiObserverBlocks];
    NSMutableArray *arr = dic[name];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[name] = arr;
    }
    [arr addObject:target];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(notiAction:) name:name object:nil];
}

- (void)removeNotificationObserverBlocksForName:(NSNotificationName)name {
    if (!name) return;
    NSMutableDictionary *dic = [self lx_allNotiObserverBlocks];
    NSMutableArray *arr = dic[name];
    [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:obj name:name object:nil];
    }];
    
    [dic removeObjectForKey:name];
}

- (void)removeNotificationObserverBlocks {
    NSMutableDictionary *dic = [self lx_allNotiObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:obj name:key object:nil];
        }];
    }];
    
    [dic removeAllObjects];
}

@end

@interface LXObserverTargetBlockItem ()

@end

@implementation LXObserverTargetBlockItem

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notiAction:(NSNotification *)noti {
    
    if (!self.notiBlock) return;
    
    self.notiBlock(noti);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.kvoBlock) return;
    
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    
    self.kvoBlock(object, oldVal, newVal);
}

@end
