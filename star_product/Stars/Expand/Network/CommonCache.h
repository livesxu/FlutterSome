//
//  CommonCache.h
//  Stars
//
//  Created by Xu小波 on 2018/1/27.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <YYCache/YYCache.h>

///  缓存类型
typedef NS_ENUM(NSInteger, CommonRequestCacheType) {
    CommonRequestCacheTypeNever = 0,//不缓存
    CommonRequestCacheTypeForever,//永久缓存 - 一定空间内
    CommonRequestCacheTypeToday,//当天缓存
};

@interface CommonCache : NSObject

/**
 *  缓存网络数据,根据请求的 URL与parameters
 *  做KEY存储数据, 这样就能缓存多级页面的数据
 *
 *  @param httpData   服务器返回的数据
 *  @param URL        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters Type:(CommonRequestCacheType)type;

/**
 *  根据请求的 URL与parameters 取出缓存数据
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *
 *  @return 缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters Type:(CommonRequestCacheType)type;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
//+ (NSInteger)getAllHttpCacheSize;


/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache;

@end

@interface CommonCacheItem : YYCache

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (instancetype)initWithName:(NSString *)cacheName;

@end
