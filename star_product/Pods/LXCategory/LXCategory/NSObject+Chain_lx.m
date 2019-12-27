//
//  Copyright © 2019年 Livesxu. All rights reserved.
//

#import "NSObject+Chain_lx.h"

#import <objc/runtime.h>

typedef id (^LinkId)(id property);

typedef id (^LinkInt)(NSInteger inter);//use int
typedef id (^LinkCGFloat)(CGFloat cgfloater);// use CGFloat
typedef id (^LinkDouble)(double doubler);//
typedef id (^LinkBOOL)(bool booler);

typedef id (^LinkSize)(CGSize sizer);
typedef id (^LinkRect)(CGRect recter);
typedef id (^LinkInset)(UIEdgeInsets inseter);

@implementation NSObject (Chain_lx)

+ (void)load {
    
    [UIView LXChainList];
    [UIImageView LXChainList];
    [UITextField LXChainList];
    [UITextView LXChainList];
    [UILabel LXChainList];
    [UIButton LXChainList];
    
}

+ (void)LXChainList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSDictionary *nomalDic = [self chainDictionary];
    NSDictionary *customDic = [self customChainDictionary];
    
    [dic addEntriesFromDictionary:nomalDic];
    [dic addEntriesFromDictionary:customDic];
    
    [self LXChainWithDic:dic];
}

+ (void)LXChainWithDic:(NSDictionary *)dic {
    
    if (!dic.allKeys.count) return ;
    
    for (NSString *key in dic.allKeys) {
        
        NSString *value = dic[key];
        
        NSString *selString = [@"lx_" stringByAppendingString:value];
        
        SEL sel = NSSelectorFromString(selString);
        
        Method lx_method = class_getInstanceMethod([NSObject class],sel);
        
        if (!lx_method) {
            NSAssert(lx_method == nil,([NSString stringWithFormat:@"TODO|FIXME - Chain Error -> %@ chainType not be %@",key,value]));
            continue;
        }
        class_addMethod(self, NSSelectorFromString(key), method_getImplementation(lx_method), method_getTypeEncoding(lx_method));
    }
}


// id -
- (id _Nonnull (^)(id _Nonnull ))lx_id {
    
    return lx_link_id(self, _cmd);
}

LinkId lx_link_id(id ins,SEL sel) {
    
    return ^id (id property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:property forKey:propertyName];
        
        return ins;
    };
}

// int -
- (id _Nonnull (^)(NSInteger ))lx_int {
    
    return lx_link_int(self, _cmd);
}

LinkInt lx_link_int(id ins,SEL sel) {
    
    return ^(NSInteger property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:@(property) forKey:propertyName];
        
        return ins;
    };
}

// CGFloat -
- (id _Nonnull (^)(CGFloat ))lx_CGFloat {
    
    return lx_link_CGFloat(self, _cmd);
}

LinkCGFloat lx_link_CGFloat(id ins,SEL sel) {
    
    return ^(CGFloat property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:@(property) forKey:propertyName];
        
        return ins;
    };
}

// double -
- (id _Nonnull (^)(double ))lx_double {
    
    return lx_link_double(self, _cmd);
}

LinkDouble lx_link_double(id ins,SEL sel) {
    
    return ^(double property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:@(property) forKey:propertyName];
        
        return ins;
    };
}

// bool -
- (id _Nonnull (^)(bool ))lx_bool {
    
    return lx_link_bool(self, _cmd);
}

LinkBOOL lx_link_bool(id ins,SEL sel) {
    
    return ^(bool property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:@(property) forKey:propertyName];
        
        return ins;
    };
}

// size -
- (id _Nonnull (^)(CGSize ))lx_size {
    
    return lx_link_size(self, _cmd);
}

LinkSize lx_link_size(id ins,SEL sel) {
    
    return ^(CGSize property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:@(property) forKey:propertyName];
        
        return ins;
    };
}

// rect -
- (id _Nonnull (^)(CGRect ))lx_rect {
    
    return lx_link_rect(self, _cmd);
}

LinkRect lx_link_rect(id ins,SEL sel) {
    
    return ^(CGRect property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:@(property) forKey:propertyName];
        
        return ins;
    };
}

// inset -
- (id _Nonnull (^)(UIEdgeInsets ))lx_inset {
    
    return lx_link_inset(self, _cmd);
}

LinkInset lx_link_inset(id ins,SEL sel) {
    
    return ^(UIEdgeInsets property) {
        
        NSString *propertyName = [NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"lx_" withString:@""];
        
        [ins setValue:[NSValue valueWithUIEdgeInsets:property] forKey:propertyName];
        
        return ins;
    };
}

// - 默认链
+ (NSDictionary *)chainDictionary {
    
    return [NSDictionary dictionary];
}

// - 自定义链
+ (NSDictionary *)customChainDictionary {
    
    return [NSDictionary dictionary];
}

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation UIView (Chain_lx)

+ (NSDictionary *)chainDictionary {
    
    return @{@"lx_userInteractionEnabled":@"bool",
             @"lx_tag":@"int",
             @"lx_frame":@"rect",
             @"lx_bounds":@"rect",
             @"lx_center":@"size",
             @"lx_backgroundColor":@"id",
             @"lx_alpha":@"CGFloat",
             @"lx_hidden":@"bool",
             @"lx_contentMode":@"int",
             @"lx_tintColor":@"id",
             };
}

//- (UIView * _Nonnull (^)(CGRect ))lx_frame {
//    
//    return ^(CGRect frame) {
//        
//        self.frame = frame;
//        
//        return self;
//    };
//}

@end

@implementation UIImageView (Chain_lx)

+ (NSDictionary *)chainDictionary {
    
    return @{@"lx_image":@"id",
             @"lx_highlightedImage":@"id",
             @"lx_highlighted":@"bool",
             @"lx_animationImages":@"id",
             @"lx_highlightedAnimationImages":@"id",
             @"lx_animationDuration":@"double",
             @"lx_animationRepeatCount":@"int",
             };
}

@end

@implementation UITextField (Chain_lx)

+ (NSDictionary *)chainDictionary {
    
    return @{@"lx_text":@"id",
             @"lx_attributedText":@"id",
             @"lx_textColor":@"id",
             @"lx_font":@"id",
             @"lx_textAlignment":@"int",
             @"lx_borderStyle":@"int",
             @"lx_defaultTextAttributes":@"id",
             @"lx_placeholder":@"id",
             @"lx_attributedPlaceholder":@"id",
             @"lx_clearsOnBeginEditing":@"bool",
             @"lx_adjustsFontSizeToFitWidth":@"bool",
             @"lx_minimumFontSize":@"CGFloat",
             @"lx_background":@"id",
             @"lx_disabledBackground":@"id",
             };
}

@end

@implementation UITextView (Chain_lx)

+ (NSDictionary *)chainDictionary {
    
    return @{@"lx_text":@"id",
             @"lx_textColor":@"id",
             @"lx_font":@"id",
             @"lx_textAlignment":@"int",
             @"lx_editable":@"bool",
             @"lx_attributedText":@"id",
             @"lx_allowsEditingTextAttributes":@"bool",
             };
}

@end

@implementation UILabel (Chain_lx)

+ (NSDictionary *)chainDictionary {
    
    return @{@"lx_text":@"id",
             @"lx_font":@"id",
             @"lx_textColor":@"id",
             @"lx_shadowColor":@"id",
             @"lx_shadowOffset":@"size",
             @"lx_textAlignment":@"int",
             @"lx_lineBreakMode":@"int",
             @"lx_attributedText":@"id",
             @"lx_highlightedTextColor":@"id",
             @"lx_highlighted":@"bool",
             @"lx_enabled":@"bool",
             @"lx_numberOfLines":@"int",
             @"lx_adjustsFontSizeToFitWidth":@"bool",
             @"lx_baselineAdjustment":@"int",
             
             };
}

@end

@implementation UIButton (Chain_lx)

+ (NSDictionary *)chainDictionary {
    
    return @{@"lx_contentEdgeInsets":@"inset",
             @"lx_titleEdgeInsets":@"inset",
             @"lx_imageEdgeInsets":@"inset",
             };
}

- (UIButton * _Nonnull (^)(NSString * ,UIControlState ))lx_title {

    return ^(NSString *title ,UIControlState state ) {

        [self setTitle:title forState:state];

        return self;
    };
}

- (UIButton * _Nonnull (^)(UIColor * ,UIControlState ))lx_titleColor {
    
    return ^(UIColor *color ,UIControlState state ) {
        
        [self setTitleColor:color forState:state];
        
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIColor * ,UIControlState ))lx_titleShadowColor {
    
    return ^(UIColor *color ,UIControlState state ) {
        
        [self setTitleShadowColor:color forState:state];
        
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIImage * ,UIControlState ))lx_image {
    
    return ^(UIImage *image ,UIControlState state ) {
        
        [self setImage:image forState:state];
        
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIImage * ,UIControlState ))lx_backgroundImage {
    
    return ^(UIImage *bgImage ,UIControlState state ) {
        
        [self setBackgroundImage:bgImage forState:state];
        
        return self;
    };
}

- (UIButton * _Nonnull (^)(NSAttributedString * ,UIControlState ))lx_attributedTitle {
    
    return ^(NSAttributedString *attributedTitle ,UIControlState state ) {
        
        [self setAttributedTitle:attributedTitle forState:state];
        
        return self;
    };
}

@end

#pragma clang diagnostic pop
