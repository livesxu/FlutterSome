//
//  CommonRequestApi.m
//  Stars
//
//  Created by Xu小波 on 2017/11/29.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "CommonRequestApi.h"
#import "YTKNetworkConfig.h"
#import "YTKNetworkAgent.h"

@interface CommonRequestApi ()

@property (nonatomic,   copy) NSString *URL;

@property (nonatomic, strong) id requestBody;

@property (nonatomic, strong) id requestHeader;

@property (nonatomic, assign) YTKRequestMethod lxRequestMethod;

@property (nonatomic, assign) CommonRequestRelatedServe lxRequestServe;

@property (nonatomic, assign) NSTimeInterval lxRequestTimeoutInterval;

@property (nonatomic, assign) BOOL isUpload;

@property (nonatomic, assign) CommonRequestCacheType currentCacheType;

@property (nonatomic, assign) BOOL isOnlyCacheDataEnough;

@end

@implementation CommonRequestApi

#pragma mark - public

- (CommonRequestApi *(^)(NSString *))lxRequestURL {
    return ^(NSString *requestURL){
        self.URL = requestURL;
        return self;
    };
}

- (CommonRequestApi *(^)(YTKRequestMethod))lxMethod {
    return ^(YTKRequestMethod method){
        self.lxRequestMethod = method;
        return self;
    };
}

- (CommonRequestApi *(^)(CommonRequestRelatedServe))lxRelatedServe {
    return ^(CommonRequestRelatedServe serve){
        self.lxRequestServe = serve;
        return self;
    };
}


- (CommonRequestApi *(^)(id))lxHeader {
    return ^(id header) {
        self.requestHeader = header;
        return self;
    };
}

- (CommonRequestApi *(^)(id))lxBody {
    return ^(id body) {
        self.requestBody = body;
        return self;
    };
}

- (CommonRequestApi *(^)(NSTimeInterval))lxTimeoutInterval {
    return ^(NSTimeInterval timeout) {
        self.lxRequestTimeoutInterval = timeout;
        return self;
    };
}

/**
 是否上传
 */
- (CommonRequestApi *(^)(bool))lxUpLoad {
    return ^(bool upload) {
        self.isUpload = upload;
        return self;
    };
}

/**
 是否缓存
 */
- (CommonRequestApi *(^)(CommonRequestCacheType))lxSureCacheType {
    return ^(CommonRequestCacheType type){
        self.currentCacheType = type;
        return self;
    };
}
/**
 是否获取缓存之后不再请求 - 需求 - lxSureCache
 */
- (CommonRequestApi *(^)(bool))lxOnlyCacheDataEnough {
    return ^(bool onlyCacheDataEnough) {
        self.isOnlyCacheDataEnough = onlyCacheDataEnough;
        return self;
    };
}

#pragma mark - private

- (BOOL)useCDN {
    return YES;
}

//请求url
- (NSString *)requestUrl {
    return self.URL;
}

//请求方式
- (YTKRequestMethod)requestMethod {
    
    if (!_lxRequestMethod) {
        return YTKRequestMethodGET;
    }
    
    return self.lxRequestMethod;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

//请求参数
- (id)requestArgument {
    
    if ([self.requestBody isKindOfClass:[NSDictionary class]]) {
        return self.requestBody;
    }
    
    if (![self.requestBody isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (![self.requestBody isValid]) {
        return nil;
    }
    
    NSLog(@"requestBody规范使用dic，请修改%@",_URL);
    
    NSString *jsonString = self.requestBody;
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"请求地址:%@，请求参数转换出错:%@", self.URL, error);
        return nil;
    }
    return dic;
}

- (NSTimeInterval)requestTimeoutInterval {
    if (self.lxRequestTimeoutInterval > 0) {
        return self.lxRequestTimeoutInterval;
    }
    return 15.0f;
}

//上传 - 
- (AFConstructingBlock)constructingBodyBlock {
    
    if (!self.isUpload) return nil;
    
    return ^(id<AFMultipartFormData> formData) {
        
        NSString *name = @"file";
        NSString *fileName = @"file";
        NSString *type = @"gzip";
        [formData appendPartWithFileData:_requestBody name:name fileName:fileName mimeType:type];
    };
}

#pragma mark - 请求返回自定义处理
/**
 普通请求返回统一处理
 
 @param nomalHandle -
 */
- (void)startWithNomalCompletionBlock:(NomalHandleRequestCompletionBlock)nomalHandle {
    
    __weak typeof(self) weakSelf = self;
    self.successCompletionBlock = ^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (!weakSelf.lxRequestServe || weakSelf.lxRequestServe == CommonRequestBasic) {
                
            nomalHandle(YES,request.responseJSONObject);
            return ;
        }
        nomalHandle(NO,nil);
    };
    
    self.failureCompletionBlock = ^(__kindof YTKBaseRequest * _Nonnull request) {
        
        ShowMessage(@"请求失败");
        NSLog(@" 请求失败 statusCode: %ld 错误是：%@",(long)request.responseStatusCode,request.error);
        
        nomalHandle(NO,nil);
    };
    
    [self startWithCompletionBlockWithSuccess:self.successCompletionBlock failure:self.failureCompletionBlock];
}

- (void)cacheResponseAction:(id)response{
    
    if (_currentCacheType) {
        
        [CommonCache setHttpCache:response URL:_URL parameters:_requestBody Type:_currentCacheType];
    }
}

- (id)cacheResponse{
    
    if (_currentCacheType) {
        
        return [CommonCache httpCacheForURL:_URL parameters:_requestBody Type:_currentCacheType];
    }
    return nil;
}

@end
