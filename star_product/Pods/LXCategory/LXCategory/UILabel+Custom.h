//
//  UILabel+Custom.h
//  XiaoLiuRetail
//
//  Created by MacBook pro on 16/4/20.
//  Copyright © 2016年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

/**
 simpleLabel

 @param frame frame
 @param text text
 @param font font
 @param color color
 @return label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame
                       Text:(NSString *)text
                   TextFont:(UIFont *)font
                  TextColor:(UIColor *)color;

/**
 complexLabel

 @param frame frame
 @param text text
 @param font font
 @param color TextColor
 @param line NumberOfLines
 @param ali TextAlignment
 @param bColor BackgroundColor
 @param isAdjustFit isAdjustFit
 @return label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame
                       Text:(NSString *)text
                   TextFont:(UIFont *)font
                  TextColor:(UIColor *)color
              NumberOfLines:(NSInteger)line
              TextAlignment:(NSTextAlignment)ali
            BackgroundColor:(UIColor *)bColor
             AdjustFitWidth:(BOOL)isAdjustFit;

/**
 qk config label

 @param frame frame
 @param configDic configDic
 @return label
 */
- (instancetype)initWithFrame:(CGRect)frame
                       Config:(NSDictionary *)configDic;

@end
