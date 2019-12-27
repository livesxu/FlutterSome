//
//  NSNumber+LXSafeCategory.h
//  
//
//  Created by Xu小波 on 2018/12/4.
//

#import <Foundation/Foundation.h>

#define lxSafeNumber(xxx) NumberValue(xxx)

NSNumber *NumberValue(id value);

@interface NSNumber (LXSafeCategory)

@property (nonatomic,readonly) NSUInteger length;

- (BOOL)isEqualToString:(NSString *)aString;

- (BOOL)containsString:(NSString *)str;

- (BOOL)hasPrefix:(NSString *)str;

+ (NSNumber *)numberValue:(id)value;

@end
