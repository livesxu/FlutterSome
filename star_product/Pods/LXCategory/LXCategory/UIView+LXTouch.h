//
//  UIImageView+LXTouch.h

//  Created by Xu小波 on 2018/12/5.
//  Copyright © 2018年 Xu小波. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchBlock)(UIView *sender,CGPoint touchPoint);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LXTouch)

/**
 设置事件响应间隔 - 事件操作之前赋值
 */
@property (nonatomic, assign) NSTimeInterval callInterval;

//添加手势添加的操作方法
@property (nonatomic,   copy) TouchBlock touchAction;

/**
 点击事件 - 基于手势响应

 @param block block
 */
- (void)lx_addActionWithBlock:(TouchBlock)block;

@end

@interface UIControl (LXTouch)

/**
 间隔 - 响应式事件 添加/替换
 
 @param controlEvents controlEvents
 @param intervalTime 响应间隔时间
 @param block Action
 */
- (void)lx_addActionWithControlEvents:(UIControlEvents)controlEvents
                         callInterval:(NSTimeInterval)intervalTime
                                block:(void (^)(id sender))block;


/**
 响应式事件 添加/替换

 @param controlEvents controlEvents
 @param block Action
 */
- (void)lx_addActionWithControlEvents:(UIControlEvents)controlEvents
                                block:(void (^)(id sender))block;

/**
 移除对应事件

 @param controlEvents controlEvents
 */
- (void)lx_removeActionWithControlEvents:(UIControlEvents)controlEvents;

/**
 点击事件 - UIControlEventTouchUpInside

 @param block block
 */
- (void)lx_addActionTouchWithBlock:(void (^)(UIControl *sender))block;

/**
 移除所有事件
 */
- (void)lx_removeAllTargets;

@end


typedef void(^LXTargetBlock)(id selInfo);

@interface LXTargetBlockItem : NSObject

@property (nonatomic, assign) NSInteger tag;//>tag标记

@property (nonatomic,  copy) LXTargetBlock block;//>block回调

@property (nonatomic, assign) NSTimeInterval callInterval;//>回调间隔
@property (nonatomic, assign) NSTimeInterval lastCall;//>上次回调时间

@end

NS_ASSUME_NONNULL_END
