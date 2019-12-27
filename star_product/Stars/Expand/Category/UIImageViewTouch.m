//
//  UIImageViewTouch.m
//  Stars
//
//  Created by Xu小波 on 2018/4/19.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "UIImageViewTouch.h"

@implementation UIImageViewTouch

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

@end
