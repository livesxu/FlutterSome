//
//  UIView+LayerAction.m
//  Shuzan
//
//  Created by Livespro on 2016/12/2.
//  Copyright © 2016年 Livesxu. All rights reserved.
//

#import "UIView+LayerAction.h"

#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) CAShapeLayer *lxCornLayer;

@end

@implementation UIView (LayerAction)

- (void)setLxCornLayer:(CAShapeLayer *)lxCornLayer {
    
    objc_setAssociatedObject(self, @selector(lxCornLayer), lxCornLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)lxCornLayer {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRadius:(CGFloat)radius
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor
{
    [self setRoundedCorners:UIRectCornerAllCorners radius:radius borderWidth:borderWidth borderColor:borderColor];
}

- (void)setClearRadius:(CGFloat)radius{
    
    [self setRadius:radius borderWidth:0 borderColor:nil];
}

- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    if (borderWidth && borderColor) {
        
        self.layer.mask = nil;
        
        CGRect rect = self.bounds;
        
        // Create the path
        UIBezierPath *cornPath = [UIBezierPath bezierPathWithRect:rect];
        
        if (!self.lxCornLayer) {
            
            self.lxCornLayer = [CAShapeLayer layer];
            self.lxCornLayer.frame = rect;
            self.lxCornLayer.path = cornPath.CGPath;
            self.lxCornLayer.fillColor = [UIColor clearColor].CGColor;
        }
        
        self.lxCornLayer.strokeColor = borderColor.CGColor;
        self.lxCornLayer.lineWidth = borderWidth;
        
        [self.layer addSublayer:self.lxCornLayer];
    } else {
        
        if (self.lxCornLayer) {
            
            self.lxCornLayer.lineWidth = 0;
        }
    }
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    
    [self setRoundedCorners:corners radius:radius borderWidth:0 borderColor:nil];
}

- (void)setRoundedCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor *)borderColor
{
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
    
    if (borderWidth && borderColor) {
        
        if (!self.lxCornLayer) {
            
            self.lxCornLayer = [CAShapeLayer layer];
            self.lxCornLayer.frame = rect;
            self.lxCornLayer.path = maskPath.CGPath;
            self.lxCornLayer.fillColor = [UIColor clearColor].CGColor;
        }
        
        self.lxCornLayer.strokeColor = borderColor.CGColor;
        self.lxCornLayer.lineWidth = borderWidth;
        
        [self.layer addSublayer:self.lxCornLayer];
        
    } else {
        
        if (self.lxCornLayer) {
            
            self.lxCornLayer.lineWidth = 0;
        }
    }
}

- (void)setRectShadowColor:(UIColor *)shadowColor
                   opacity:(CGFloat)opacity
                    offset:(CGSize)offset {
    
    self.layer.shadowColor = shadowColor.CGColor;//设置阴影的颜色
    self.layer.shadowOpacity = opacity;//阴影的透明度
    self.layer.shadowOffset = offset;//设置阴影的偏移量
    
    CGRect rect = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    self.layer.shadowPath = path.CGPath;
}

- (void)setRasterizeShadowColor:(UIColor *)shadowColor
                         offset:(CGSize)offset
                         radius:(CGFloat)radius {
    
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)removeAllSubviews {
    
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (void)bringToFront {
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
    [self.superview sendSubviewToBack:self];
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
