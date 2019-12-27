//
//  CommonCache.m
//  Stars
//
//  Created by Xu小波 on 2018/1/27.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "CommonCache.h"

@interface CommonCache ()

@property (nonatomic, strong) YYCache *todayCache;

@end

@implementation CommonCache

static NSString *const ApiResponseCacheToday = @"ApiResponseCacheToday";
static CommonCacheItem *_todayCache;

static NSString *const ApiResponseCacheForever = @"ApiResponseCacheForever";
static CommonCacheItem *_foreverCache;

+ (void)initialize
{
    _todayCache = [[CommonCacheItem alloc]initWithName:ApiResponseCacheToday];
    _foreverCache = [[CommonCacheItem alloc]initWithName:ApiResponseCacheForever];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters Type:(CommonRequestCacheType)type;
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters Type:type];
    //异步缓存,不会阻塞主线程
    [[self typeCache:type] setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters Type:(CommonRequestCacheType)type;
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters Type:type];
    
    return [[self typeCache:type] objectForKey:cacheKey];
}

//+ (NSInteger)getAllHttpCacheSize
//{
//    return [_dataCache.diskCache totalCost];
//}

+ (void)removeAllHttpCache
{
    [_todayCache.diskCache removeAllObjects];
    [_foreverCache.diskCache removeAllObjects];
}

+ (CommonCacheItem *)typeCache:(CommonRequestCacheType)type{
    
    if (type == CommonRequestCacheTypeToday) {
        
        return _todayCache;
    }
    return _foreverCache;
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters Type:(CommonRequestCacheType)type;
{
    NSMutableString *cacheKey = [NSMutableString stringWithString:URL];
    
    if (type == CommonRequestCacheTypeToday) {
        
        [cacheKey appendString:[[self typeCache:type].dateFormatter stringFromDate:[NSDate date]]];
    }
    
    if (parameters) {
        
        // 将参数字典转换成字符串
        NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
        NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
        
        [cacheKey appendString:paraString];
        
    }
    
    return cacheKey;
}

@end

@implementation CommonCacheItem

- (instancetype)initWithName:(NSString *)cacheName {
    
    self = [super initWithName:cacheName];
    if (self) {
        
        self.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        self.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
        [self.memoryCache setCountLimit:25];//内存最大缓存数据个数
        [self.memoryCache setCostLimit:1*1024];//内存最大缓存开销 目前这个毫无用处
        [self.diskCache setCostLimit:10*1024];//磁盘最大缓存开销
        [self.diskCache setCountLimit:50];//磁盘最大缓存数据个数
        //        [self.diskCache setAutoTrimInterval:60];//设置磁盘lru动态清理频率 默认 60秒
        //        [self.diskCache setAgeLimit:DBL_MAX];
    }
    return self;
}

- (NSDateFormatter *)dateFormatter{
    
    if (!_dateFormatter) {
        
        _dateFormatter = [[NSDateFormatter alloc]init];
        
        _dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
        
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
        
    }
    return _dateFormatter;
}

@end
