
//

#import "NSString+PreciseDecimalCalculate.h"

BOOL Match(NSString *str1,NSString *str2){
    
    if (!str1 || !str2 || ![str1 isKindOfClass:[NSString class]] || ![str2 isKindOfClass:[NSString class]]) {
        
        return YES;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[^.[0-9]]*"];
    return [predicate evaluateWithObject:[str1 stringByAppendingString:str2]];
}

@implementation NSString (PreciseDecimalCalculate)

+ (NSString *)addCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (Match(numericalValueOne, numericalValueOther)) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberByAdding:valueOther]];
}

+(NSString *)subtractCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (Match(numericalValueOne, numericalValueOther)) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberBySubtracting:valueOther]];
}

+(NSString *)multiplyCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (Match(numericalValueOne, numericalValueOther)) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberByMultiplyingBy:valueOther]];
}

+(NSString *)divideCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (Match(numericalValueOne, numericalValueOther)) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberByDividingBy:valueOther]];
}

@end
