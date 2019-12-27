//
//  Copyright © 2019年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Chain_lx)

/**
 类调用注册链式(对customChainDictionary注册) - UIView,UIImageView,UITextField,UITextView,UILabel,UIButton 已注册
 */
+ (void)LXChainList;

/**
 类调用注册链式方法

 @param dic 需要注册的数据映射
 */
+ (void)LXChainWithDic:(NSDictionary *)dic;

/**
 自定义链

 @return @{@"lx_<#property#>":@"<#type#>"} - type:  id -> id
                                            int -> NSInteger
                                            CGFloat -> CGFloat
                                            double -> double
                                            bool -> BOOL
                                            size -> eg:CGSize,CGPoint--- 结构体样式 - struct .. {CGFloat xxx;CGFloat xxx;}
                                            rect -> eg:CGRect        --- 结构体样式 - struct .. {CGSize xxx;CGSize xxx;}
                                            inset -> eg:UIEdgeInsets --- 结构体样式 - struct .. {CGFloat xxx, xxx, xxx, xxx;}
 */
+ (NSDictionary *)customChainDictionary;

@end


@interface UIView (Chain_lx)

- (UIView * _Nonnull (^)(BOOL ))lx_userInteractionEnabled;

- (UIView * _Nonnull (^)(NSInteger ))lx_tag;

- (UIView * _Nonnull (^)(CGRect ))lx_frame;

- (UIView * _Nonnull (^)(CGRect ))lx_bounds;

- (UIView * _Nonnull (^)(CGPoint ))lx_center;

- (UIView * _Nonnull (^)(UIColor * ))lx_backgroundColor;

- (UIView * _Nonnull (^)(CGFloat ))lx_alpha;

- (UIView * _Nonnull (^)(BOOL ))lx_hidden;

- (UIView * _Nonnull (^)(UIViewContentMode ))lx_contentMode;

- (UIView * _Nonnull (^)(UIColor * ))lx_tintColor;

@end

@interface UIImageView (Chain_lx)

- (UIImageView * _Nonnull (^)(UIImage * ))lx_image;

- (UIImageView * _Nonnull (^)(UIImage * ))lx_highlightedImage;

- (UIImageView * _Nonnull (^)(BOOL ))lx_highlighted;

- (UIImageView * _Nonnull (^)(NSArray<UIImage *> * ))lx_animationImages;

- (UIImageView * _Nonnull (^)(NSArray<UIImage *> * ))lx_highlightedAnimationImages;

- (UIImageView * _Nonnull (^)(NSTimeInterval ))lx_animationDuration;

- (UIImageView * _Nonnull (^)(NSInteger ))lx_animationRepeatCount;


//UIView - on
- (UIImageView * _Nonnull (^)(BOOL ))lx_userInteractionEnabled;

- (UIImageView * _Nonnull (^)(NSInteger ))lx_tag;

- (UIImageView * _Nonnull (^)(CGRect ))lx_frame;

- (UIImageView * _Nonnull (^)(CGRect ))lx_bounds;

- (UIImageView * _Nonnull (^)(CGPoint ))lx_center;

- (UIImageView * _Nonnull (^)(UIColor * ))lx_backgroundColor;

- (UIImageView * _Nonnull (^)(CGFloat ))lx_alpha;

- (UIImageView * _Nonnull (^)(BOOL ))lx_hidden;

- (UIImageView * _Nonnull (^)(UIViewContentMode ))lx_contentMode;

- (UIImageView * _Nonnull (^)(UIColor * ))lx_tintColor;

@end

@interface UITextField (Chain_lx)

- (UITextField * _Nonnull (^)(NSString * ))lx_text;

- (UITextField * _Nonnull (^)(NSAttributedString * ))lx_attributedText;

- (UITextField * _Nonnull (^)(UIColor * ))lx_textColor;

- (UITextField * _Nonnull (^)(UIFont * ))lx_font;

- (UITextField * _Nonnull (^)(NSTextAlignment ))lx_textAlignment;

- (UITextField * _Nonnull (^)(UITextBorderStyle ))lx_borderStyle;

- (UITextField * _Nonnull (^)(NSDictionary<NSAttributedStringKey,id> * ))lx_defaultTextAttributes;

- (UITextField * _Nonnull (^)(NSString * ))lx_placeholder;

- (UITextField * _Nonnull (^)(NSAttributedString * ))lx_attributedPlaceholder;

- (UITextField * _Nonnull (^)(BOOL ))lx_clearsOnBeginEditing;

- (UITextField * _Nonnull (^)(BOOL ))lx_adjustsFontSizeToFitWidth;

- (UITextField * _Nonnull (^)(CGFloat ))lx_minimumFontSize;

- (UITextField * _Nonnull (^)(UIImage * ))lx_background;

- (UITextField * _Nonnull (^)(UIImage * ))lx_disabledBackground;


//UIView - on
- (UITextField * _Nonnull (^)(BOOL ))lx_userInteractionEnabled;

- (UITextField * _Nonnull (^)(NSInteger ))lx_tag;

- (UITextField * _Nonnull (^)(CGRect ))lx_frame;

- (UITextField * _Nonnull (^)(CGRect ))lx_bounds;

- (UITextField * _Nonnull (^)(CGPoint ))lx_center;

- (UITextField * _Nonnull (^)(UIColor * ))lx_backgroundColor;

- (UITextField * _Nonnull (^)(CGFloat ))lx_alpha;

- (UITextField * _Nonnull (^)(BOOL ))lx_hidden;

- (UITextField * _Nonnull (^)(UIViewContentMode ))lx_contentMode;

- (UITextField * _Nonnull (^)(UIColor * ))lx_tintColor;

@end

@interface UITextView (Chain_lx)

- (UITextView * _Nonnull (^)(NSString * ))lx_text;

- (UITextView * _Nonnull (^)(UIColor * ))lx_textColor;

- (UITextView * _Nonnull (^)(UIFont * ))lx_font;

- (UITextView * _Nonnull (^)(NSTextAlignment ))lx_textAlignment;

- (UITextView * _Nonnull (^)(BOOL ))lx_editable;

- (UITextView * _Nonnull (^)(NSAttributedString * ))lx_attributedText;

- (UITextView * _Nonnull (^)(BOOL ))lx_allowsEditingTextAttributes;


//UIView - on
- (UITextView * _Nonnull (^)(BOOL ))lx_userInteractionEnabled;

- (UITextView * _Nonnull (^)(NSInteger ))lx_tag;

- (UITextView * _Nonnull (^)(CGRect ))lx_frame;

- (UITextView * _Nonnull (^)(CGRect ))lx_bounds;

- (UITextView * _Nonnull (^)(CGPoint ))lx_center;

- (UITextView * _Nonnull (^)(UIColor * ))lx_backgroundColor;

- (UITextView * _Nonnull (^)(CGFloat ))lx_alpha;

- (UITextView * _Nonnull (^)(BOOL ))lx_hidden;

- (UITextView * _Nonnull (^)(UIViewContentMode ))lx_contentMode;

- (UITextView * _Nonnull (^)(UIColor * ))lx_tintColor;

@end

@interface UILabel (Chain_lx)

- (UILabel * _Nonnull (^)(NSString * _Nonnull))lx_text;

- (UILabel * _Nonnull (^)(UIFont * _Nonnull))lx_font;

- (UILabel * _Nonnull (^)(UIColor * _Nonnull ))lx_textColor;

- (UILabel * _Nonnull (^)(UIColor * _Nonnull ))lx_shadowColor;

- (UILabel * _Nonnull (^)(CGSize ))lx_shadowOffset;

- (UILabel * _Nonnull (^)(NSTextAlignment ))lx_textAlignment;

- (UILabel * _Nonnull (^)(NSLineBreakMode ))lx_lineBreakMode;

- (UILabel * _Nonnull (^)(NSAttributedString * _Nonnull ))lx_attributedText;

- (UILabel * _Nonnull (^)(UIColor * _Nonnull ))lx_highlightedTextColor;

- (UILabel * _Nonnull (^)(BOOL ))lx_highlighted;

- (UILabel * _Nonnull (^)(BOOL ))lx_enabled;

- (UILabel * _Nonnull (^)(NSInteger ))lx_numberOfLines;

- (UILabel * _Nonnull (^)(BOOL ))lx_adjustsFontSizeToFitWidth;

- (UILabel * _Nonnull (^)(UIBaselineAdjustment ))lx_baselineAdjustment;


//UIView - on
- (UILabel * _Nonnull (^)(BOOL ))lx_userInteractionEnabled;

- (UILabel * _Nonnull (^)(NSInteger ))lx_tag;

- (UILabel * _Nonnull (^)(CGRect ))lx_frame;

- (UILabel * _Nonnull (^)(CGRect ))lx_bounds;

- (UILabel * _Nonnull (^)(CGPoint ))lx_center;

- (UILabel * _Nonnull (^)(UIColor * ))lx_backgroundColor;

- (UILabel * _Nonnull (^)(CGFloat ))lx_alpha;

- (UILabel * _Nonnull (^)(BOOL ))lx_hidden;

- (UILabel * _Nonnull (^)(UIViewContentMode ))lx_contentMode;

- (UILabel * _Nonnull (^)(UIColor * ))lx_tintColor;

@end

@interface UIButton (Chain_lx)

- (UIButton * _Nonnull (^)(UIEdgeInsets ))lx_contentEdgeInsets;

- (UIButton * _Nonnull (^)(UIEdgeInsets ))lx_titleEdgeInsets;

- (UIButton * _Nonnull (^)(UIEdgeInsets ))lx_imageEdgeInsets;

- (UIButton * _Nonnull (^)(NSString * ,UIControlState ))lx_title;

- (UIButton * _Nonnull (^)(UIColor * ,UIControlState ))lx_titleColor;

- (UIButton * _Nonnull (^)(UIColor * ,UIControlState ))lx_titleShadowColor;

- (UIButton * _Nonnull (^)(UIImage * ,UIControlState ))lx_image;

- (UIButton * _Nonnull (^)(UIImage * ,UIControlState ))lx_backgroundImage;

- (UIButton * _Nonnull (^)(NSAttributedString * ,UIControlState ))lx_attributedTitle;

//UIView - on
- (UIButton * _Nonnull (^)(BOOL ))lx_userInteractionEnabled;

- (UIButton * _Nonnull (^)(NSInteger ))lx_tag;

- (UIButton * _Nonnull (^)(CGRect ))lx_frame;

- (UIButton * _Nonnull (^)(CGRect ))lx_bounds;

- (UIButton * _Nonnull (^)(CGPoint ))lx_center;

- (UIButton * _Nonnull (^)(UIColor * ))lx_backgroundColor;

- (UIButton * _Nonnull (^)(CGFloat ))lx_alpha;

- (UIButton * _Nonnull (^)(BOOL ))lx_hidden;

- (UIButton * _Nonnull (^)(UIViewContentMode ))lx_contentMode;

- (UIButton * _Nonnull (^)(UIColor * ))lx_tintColor;

@end
