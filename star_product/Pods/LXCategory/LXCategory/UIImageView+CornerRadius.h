
// 图片设置圆角 边框

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)

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

@end
