//
//  UILabel+Custom.m
//  XiaoLiuRetail
//
//  Created by MacBook pro on 16/4/20.
//  Copyright © 2016年 Livesxu. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

+ (UILabel *)labelWithFrame:(CGRect)frame
                       Text:(NSString *)text
                   TextFont:(UIFont *)font
                  TextColor:(UIColor *)color;{
    
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    if (text) {
        
       label.text = text;
    }
    if (font) {
        
       label.font = font;
    }
    if (color) {
        
      label.textColor = color;
    }
    
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame
                       Text:(NSString *)text
                   TextFont:(UIFont *)font
                  TextColor:(UIColor *)color
              NumberOfLines:(NSInteger)line
              TextAlignment:(NSTextAlignment)ali
            BackgroundColor:(UIColor *)bColor
             AdjustFitWidth:(BOOL)isAdjustFit;{
    
    UILabel *label=[UILabel labelWithFrame:frame Text:text TextFont:font TextColor:color];
    
    label.numberOfLines = line;
    
    label.textAlignment=ali;
    
    if (bColor) {
        
        label.backgroundColor=bColor;
    }
    label.adjustsFontSizeToFitWidth = isAdjustFit;
    
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame
                       Config:(NSDictionary *)configDic {
    
    self = [super initWithFrame:frame];
    
    //font
    if ([configDic objectForKey:@"f"] && [[configDic objectForKey:@"f"] isKindOfClass:[UIFont class]]) {
        
        self.font=[configDic objectForKey:@"f"];
    }
    //textColor
    if ([configDic objectForKey:@"tC"] && [[configDic objectForKey:@"tC"] isKindOfClass:[UIColor class]]) {
        
        self.textColor=[configDic objectForKey:@"tC"];
    }
    //backgroundColor
    if ([configDic objectForKey:@"bC"] && [[configDic objectForKey:@"bC"] isKindOfClass:[UIColor class]]) {
        
        self.backgroundColor=[configDic objectForKey:@"bC"];
    }
    //text
    if ([configDic objectForKey:@"t"] && [[configDic objectForKey:@"t"] isKindOfClass:[NSString class]]) {
        
        self.text=[configDic objectForKey:@"t"];
    }
    //numberOfLines
    if ([configDic objectForKey:@"l"] && [[configDic objectForKey:@"l"] isKindOfClass:[NSNumber class]]) {
        
        NSNumber *numberLine=[configDic objectForKey:@"l"];
        self.numberOfLines=numberLine.integerValue;
    }
    //textAlignment
    if ([configDic objectForKey:@"tA"] && [[configDic objectForKey:@"tA"] isKindOfClass:[NSNumber class]]) {
        
        NSNumber *numberLine=[configDic objectForKey:@"tA"];
        self.textAlignment=numberLine.integerValue;
    }
    
    return self;
}


@end
