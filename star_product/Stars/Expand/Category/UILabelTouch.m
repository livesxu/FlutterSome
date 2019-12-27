//
//  UILabelTouch.m
//  Stars
//
//  Created by livesxu on 2018/8/30.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "UILabelTouch.h"

@implementation UILabelTouch

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
