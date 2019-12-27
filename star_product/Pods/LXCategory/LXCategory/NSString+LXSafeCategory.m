//
//  NSString+LXSafeCategory.m
//  
//
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "NSString+LXSafeCategory.h"

NSString *StringValue(id value) {
    
    return [NSString stringValue:value];
};

@implementation NSString (LXSafeCategory)

+ (NSString *)stringValue:(id)value {
    
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        
        return [NSString stringWithFormat:@"%@",value];
    }
    else if (!value || [value isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else{
        return @"";
    }
}

@end
