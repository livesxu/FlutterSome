//
//  UITextField+Custom.m

//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "UITextField+Custom.h"
#import <objc/runtime.h>
#import "UIView+LXTouch.h"

static const int maxLength_key;

@implementation UITextField (Custom)

- (NSInteger)maxLength {
    
    return ((NSNumber *)objc_getAssociatedObject(self, &maxLength_key)).integerValue;
}

- (void)setMaxLength:(NSInteger)maxLength {
    
    objc_setAssociatedObject(self, &maxLength_key, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self lx_addActionWithControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
        
        if (((UITextField *)sender).text.length > maxLength) {
            
            ((UITextField *)sender).text = [((UITextField *)sender).text substringToIndex:maxLength];
        }
    }];
}

+ (UITextField *)tfWithFrame:(CGRect)frame
                 Placeholder:(NSString *)placeholderText
                    TextFont:(UIFont *)font
                   TextColor:(UIColor *)color
             BackgroundColor:(UIColor *)bgColor {
    
    UITextField *tf=[[UITextField alloc]initWithFrame:frame];
    
    if (placeholderText) {
        
        tf.placeholder = placeholderText;
    }
    if (font) {
        
        tf.font = font;
    }
    if (color) {
        
        tf.textColor = color;
    }
    if (bgColor) {
        
        tf.backgroundColor = bgColor;
    }
    
    return tf;
}

+ (UITextField *)tfWithFrame:(CGRect)frame
                 Placeholder:(NSString *)placeholderText
                    TextFont:(UIFont *)font
                   TextColor:(UIColor *)color
             BackgroundColor:(UIColor *)bgColor
                KeyboardType:(UIKeyboardType)keyboardType
               ReturnKeyType:(UIReturnKeyType)returnKeyType {
    
    UITextField *tf=[UITextField tfWithFrame:frame
                                    Placeholder:placeholderText
                                       TextFont:font
                                      TextColor:color
                                BackgroundColor:bgColor];
    
    tf.keyboardType = keyboardType;
    
    tf.returnKeyType = returnKeyType;
    
    return tf;
}

- (void)configPassWordTf {
    
    self.returnKeyType = UIReturnKeyDone;
    self.secureTextEntry = YES;
}

- (void)configAttributedPlaceholder:(NSDictionary *)attributesDic {
    
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attributesDic];
    
}

@end
