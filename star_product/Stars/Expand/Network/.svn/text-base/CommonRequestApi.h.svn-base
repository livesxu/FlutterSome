//
//  CommonRequestApi.h
//  Stars
//
//  Created by Xu小波 on 2017/11/29.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

#import "CommonCache.h"

///  基础接口服务类型
typedef NS_ENUM(NSInteger, CommonRequestRelatedServe) {
    CommonRequestBasic = 0,//
};

typedef void(^NomalHandleRequestCompletionBlock)(BOOL isSuccess,id responseData);

@interface CommonRequestApi : YTKRequest

- (CommonRequestApi *(^)(NSString *))lxRequestURL;

- (CommonRequestApi *(^)(YTKRequestMethod))lxMethod;

- (CommonRequestApi *(^)(CommonRequestRelatedServe))lxRelatedServe;

- (CommonRequestApi *(^)(id))lxHeader;

- (CommonRequestApi *(^)(id))lxBody;

- (CommonRequestApi *(^)(NSTimeInterval))lxTimeoutInterval;

/**
 是否上传
 */
- (CommonRequestApi *(^)(bool))lxUpLoad;

/**
 是否缓存
 */
- (CommonRequestApi *(^)(CommonRequestCacheType))lxSureCacheType;
/**
 是否获取缓存之后不再请求 - 需求 - lxSureCache
 */
- (CommonRequestApi *(^)(bool))lxOnlyCacheDataEnough;

#pragma mark - 请求返回自定义处理

/**
 普通请求返回统一处理

 @param nomalHandle -
 */
- (void)startWithNomalCompletionBlock:(NomalHandleRequestCompletionBlock)nomalHandle;

@end
