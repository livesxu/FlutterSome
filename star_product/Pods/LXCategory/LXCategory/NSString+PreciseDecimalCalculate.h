
//数值安全计算

#import <Foundation/Foundation.h>

@interface NSString (PreciseDecimalCalculate)

/**
 * 加
 */
+(NSString *)addCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

/**
 * 减
 */
+(NSString *)subtractCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

/**
 * 乘
 */
+(NSString *)multiplyCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

/**
 * 除
 */
+(NSString *)divideCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

@end
