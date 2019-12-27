//
//  UIView+LayerAction.h
//  Shuzan
//
//  Created by Livespro on 2016/12/2.
//  Copyright © 2016年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerAction)
/**
 设置圆角(包含边线)

 @param radius 圆角
 @param borderWidth 边宽
 @param borderColor 边色
 */
- (void)setRadius:(CGFloat)radius
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor;

/**
 设置圆角(不含边线)

 @param radius 圆角
 */
- (void)setClearRadius:(CGFloat)radius;

/**
 设置边线(无圆角)

 @param borderWidth 边宽
 @param borderColor 边色
 */
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 设置圆角(可非四周圆角)

 @param corners UIRectCorner
 @param radius 圆角
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 设置圆角+边线(可非四周圆角)
 
 @param corners UIRectCorner
 @param radius 圆角
 @param borderWidth 边宽
 @param borderColor 边色
 */
- (void)setRoundedCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor *)borderColor;


/**
 设置阴影 - 几何图形

 @param shadowColor 阴影颜色
 @param opacity 透明度
 @param offset 偏移
 */
- (void)setRectShadowColor:(UIColor *)shadowColor
               opacity:(CGFloat)opacity
                offset:(CGSize)offset;

/**
 设置阴影 - 缓存阴影，降低渲染
 
 @param shadowColor 阴影颜色
 @param offset 偏移
 @param radius 圆角
 */
- (void)setRasterizeShadowColor:(UIColor *)shadowColor
                         offset:(CGSize)offset
                         radius:(CGFloat)radius;

/**
 真实有效Alpha
 */
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**
 转换图片

 @return img
 */
- (nullable UIImage *)snapshotImage;

/**
 所处控制器
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;

/**
 移除所有子视图
 */
- (void)removeAllSubviews;

/**
 将自身的某个rect转换成相对view的

 @param rect 相对自身的rect
 @param view 对象view
 @return 对象view上表达的rect
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 将view的某个rect转成相对自身的

 @param rect 相对view的rect
 @param view view
 @return 相对自身表达的rect
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

- (void)bringToFront;
- (void)sendToBack;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;      
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;    

@end
