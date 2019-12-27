//
//  UIImage+MissPrompt.m
//  Shuzan
//
//  Created by Livespro on 2016/12/9.
//  Copyright © 2016年 Livesxu. All rights reserved.
//

#import "UIImage+MissPrompt.h"

#import <objc/runtime.h>

@implementation UIImage (MissPrompt)

#if DEBUG

// 加载分类到内存的时候调用
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 交换方法
        // 获取imageWithName方法地址
        Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
        
        // 获取imageWithName方法地址
        Method imageName = class_getClassMethod(self, @selector(imageNamed:));
        
        // 交换方法地址，相当于交换实现方式
        method_exchangeImplementations(imageWithName, imageName);
        
    });
}

#endif

// 既能加载图片又能打印
+ (instancetype)imageWithName:(NSString *)name
{
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [self imageWithName:name];
    
    if (image == nil) {
        NSLog(@"/n/n ToFix:-- No Exit Image Named ——> %@ /n/n",name);
    }
    
    return image;
}


@end
