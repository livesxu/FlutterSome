//
//  NSObject+LXObserver.h
//
//  Created by Livesxu on 2018/12/26.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LXObserver)

#pragma mark - kvo -
- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(__weak id obj, id oldVal, id newVal))block;

- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath;

- (void)removeKVOObserverBlocks;

#pragma mark - notification -
- (void)addNotificationObserverBlockForName:(NSNotificationName)name block:(void (^)(NSNotification *notification))block;

- (void)removeNotificationObserverBlocksForName:(NSNotificationName)name;

- (void)removeNotificationObserverBlocks;

@end

typedef void(^NotiObserverBlock)(NSNotification *notification);

typedef void(^KVOBlock)(__weak id obj, id oldVal, id newVal);

@interface LXObserverTargetBlockItem : NSObject

@property (nonatomic,   copy) NotiObserverBlock notiBlock;

- (void)notiAction:(NSNotification *)noti;


@property (nonatomic,   copy) KVOBlock kvoBlock;

@end
