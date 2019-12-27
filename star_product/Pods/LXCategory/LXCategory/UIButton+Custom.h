//
//  UIButton+Custom.h

//  Copyright © 2015年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)

/**
 bgImage + title btn

 @param frame frame
 @param title title
 @param font font
 @param tc TitleColor
 @param image BackgroundImage
 @return btn
 */
+ (UIButton *)buttonWithNomalFrame:(CGRect)frame
                             Title:(NSString *)title
                         TitleFont:(UIFont *)font
                        TitleColor:(UIColor *)tc
                   BackgroundImage:(UIImage *)image;

/**
 image btn

 @param frame frame
 @param image image
 @return btn
 */
+ (UIButton *)buttonWithNomalFrame:(CGRect)frame
                             Image:(UIImage *)image;

/**
 title btn

 @param frame frame
 @param title title
 @param font font
 @param tc TitleColor
 @param color BackgroundColor
 @return btn
 */
+ (UIButton *)buttonWithNomalFrame:(CGRect)frame
                             Title:(NSString *)title
                         TitleFont:(UIFont *)font
                        TitleColor:(UIColor *)tc
                   BackgroundColor:(UIColor *)color;

/**
 TouchUpInside事件 配置

 @param block action
 */
- (void)configTouchUpInsideAction:(void (^)(id sender))block;

/**
 qk config btn

 @param frame frame
 @param configDic configs
 @return btn
 */
- (instancetype)initWithFrame:(CGRect)frame
                       Config:(NSDictionary *)configDic;

@end
