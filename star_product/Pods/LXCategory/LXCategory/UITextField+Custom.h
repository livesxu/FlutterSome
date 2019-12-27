//
//  UITextField+Custom.h

//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Custom)

@property (nonatomic, assign) NSInteger maxLength;//>最大输入长度

/**
 common tf

 @param frame frame
 @param placeholderText placeholderText
 @param font font
 @param color color
 @param bgColor bgColor
 @return tf
 */
+ (UITextField *)tfWithFrame:(CGRect)frame
                 Placeholder:(NSString *)placeholderText
                    TextFont:(UIFont *)font
                   TextColor:(UIColor *)color
             BackgroundColor:(UIColor *)bgColor;

/**
 tf + type

 @param frame frame
 @param placeholderText placeholderText
 @param font font
 @param color color
 @param bgColor bgColor
 @param keyboardType keyboardType
 @param returnKeyType returnKeyType
 @return tf
 */
+ (UITextField *)tfWithFrame:(CGRect)frame
                 Placeholder:(NSString *)placeholderText
                    TextFont:(UIFont *)font
                   TextColor:(UIColor *)color
             BackgroundColor:(UIColor *)bgColor
                KeyboardType:(UIKeyboardType)keyboardType
               ReturnKeyType:(UIReturnKeyType)returnKeyType;

/**
 密码配置
 */
- (void)configPassWordTf;

/**
 富文本holder配置

 @param attributesDic attributes
 */
- (void)configAttributedPlaceholder:(NSDictionary *)attributesDic;

@end

NS_ASSUME_NONNULL_END
