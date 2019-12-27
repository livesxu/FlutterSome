//
//  UIButton+Custom.m

//  Copyright © 2015年 Livesxu. All rights reserved.
//

#import "UIButton+Custom.h"
#import "UIView+LXTouch.h"

@implementation UIButton (Custom)

+ (UIButton *)buttonWithNomalFrame:(CGRect)frame
                            Title:(NSString *)title
                        TitleFont:(UIFont *)font
                       TitleColor:(UIColor *)tc
                   BackgroundImage:(UIImage *)image;{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font=font;
    if (tc) {
        
       [button setTitleColor:tc forState:UIControlStateNormal];
    }
    
    if (image) {
        
       [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    return button;
}

+ (UIButton *)buttonWithNomalFrame:(CGRect)frame
                             Image:(UIImage *)image;{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=frame;

    if (image) {
        
        [button setImage:image forState:UIControlStateNormal];
    }
    
    return button;
}

+ (UIButton *)buttonWithNomalFrame:(CGRect)frame
                             Title:(NSString *)title
                         TitleFont:(UIFont *)font
                        TitleColor:(UIColor *)tc
                   BackgroundColor:(UIColor *)color{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font=font;
    if (tc) {
        
        [button setTitleColor:tc forState:UIControlStateNormal];
    }
    if (color) {
        
        button.backgroundColor=color;
    }
    
    return button;
}

/**
 TouchUpInside事件 配置
 
 @param block action
 */
- (void)configTouchUpInsideAction:(void (^)(id sender))block {
    
    [self lx_addActionWithControlEvents:UIControlEventTouchUpInside block:block];
}

- (instancetype)initWithFrame:(CGRect)frame
                       Config:(NSDictionary *)configDic {
    
    self = [super initWithFrame:frame];
    //font
    if ([configDic objectForKey:@"f"] && [[configDic objectForKey:@"f"] isKindOfClass:[UIFont class]]) {
        
        self.titleLabel.font=[configDic objectForKey:@"f"];
    }
    //textColor---normal
    if ([configDic objectForKey:@"tC_n"] && [[configDic objectForKey:@"tC_n"] isKindOfClass:[UIColor class]]) {
        
        [self setTitleColor:[configDic objectForKey:@"tC_n"] forState:UIControlStateNormal];
    }
    //textColor---selected
    if ([configDic objectForKey:@"tC_s"] && [[configDic objectForKey:@"tC_s"] isKindOfClass:[UIColor class]]) {
        
        [self setTitleColor:[configDic objectForKey:@"tC_s"] forState:UIControlStateSelected];
    }
    //backgroundColor
    if ([configDic objectForKey:@"bC"] && [[configDic objectForKey:@"bC"] isKindOfClass:[UIColor class]]) {
        
        self.backgroundColor=[configDic objectForKey:@"bC"];
    }
    //text---normal
    if ([configDic objectForKey:@"t_n"] && [[configDic objectForKey:@"t_n"] isKindOfClass:[NSString class]]) {
        
        [self setTitle:[configDic objectForKey:@"t_n"] forState:UIControlStateNormal];
    }
    //text---selected
    if ([configDic objectForKey:@"t_s"] && [[configDic objectForKey:@"t_s"] isKindOfClass:[NSString class]]) {
        
        [self setTitle:[configDic objectForKey:@"t_s"] forState:UIControlStateSelected];
    }
    //image---normal
    if ([configDic objectForKey:@"i_n"] && [[configDic objectForKey:@"i_n"] isKindOfClass:[UIImage class]]) {
        
        [self setImage:[configDic objectForKey:@"i_n"] forState:UIControlStateNormal];
    }
    //image---selected
    if ([configDic objectForKey:@"i_s"] && [[configDic objectForKey:@"i_s"] isKindOfClass:[UIImage class]]) {
        
        [self setImage:[configDic objectForKey:@"i_s"] forState:UIControlStateSelected];
    }
    
    return self;
}

@end
