//
//  NSString+LXSafeCategory.h
//  
//
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define lxSafeString(xxx) StringValue(xxx)

NSString *StringValue(id value);

@interface NSString (LXSafeCategory)

+ (NSString *)stringValue:(id)value;

@end
