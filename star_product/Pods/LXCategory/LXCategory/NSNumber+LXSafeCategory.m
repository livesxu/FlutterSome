//
//  NSNumber+LXSafeCategory.m
//  
//
//  Created by Xu小波 on 2018/12/4.
//

#import "NSNumber+LXSafeCategory.h"
#import <objc/runtime.h>

NSNumber *NumberValue(id value) {
    
    return [NSNumber numberValue:value];
}

@implementation NSNumber (LXSafeCategory)

- (NSUInteger)length {

    //miss
    objc_getAssociatedObject(self, _cmd);
    
    NSString *sString = [NSString stringWithFormat:@"%@",self];
    if (sString && sString.length) {
        
        return sString.length;
    }
    return 0;
}

- (void)setLength:(NSUInteger)length {

    objc_setAssociatedObject(self, @selector(length), @(length), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isEqualToString:(NSString *)aString {
    
    NSString *sString = [NSString stringWithFormat:@"%@",self];
    
    if (sString) {
        
        return [sString isEqualToString:aString];
    }
    return NO;
}

- (BOOL)containsString:(NSString *)str {
    
    NSString *sString = [NSString stringWithFormat:@"%@",self];
    
    if (sString) {
        
        return [sString containsString:str];
    }
    return NO;
}

- (BOOL)hasPrefix:(NSString *)str {
    
    NSString *sString = [NSString stringWithFormat:@"%@",self];
    
    if (sString) {
        
        return [sString hasPrefix:str];
    }
    return NO;
}

+ (NSNumber *)numberValue:(id)value {
    
    if ([value isKindOfClass:[NSNumber class]]) {
        
        return value;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        NSScanner *scan = [NSScanner scannerWithString:value];
        
        double vd;
        long long vl;
        
        if ([scan scanLongLong:&vl] && [scan isAtEnd])
        {
            return @(((NSString *)value).longLongValue);
        }
        else if ([scan scanDouble:&vd] && [scan isAtEnd])
        {
            return @(((NSString *)value).doubleValue);
        }
        else
        {
            return @0;
        }
    }
    else if (!value || [value isKindOfClass:[NSNull class]])
    {
        return @0;
    }
    return @0;
}

@end
