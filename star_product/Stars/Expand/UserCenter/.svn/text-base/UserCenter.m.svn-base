//
//  UserCenter.m
//  Stars
//
//  Created by ChangB on 2017/12/6.
//  Copyright © 2017年 Livesxu. All rights reserved.
//

#import "UserCenter.h"

#import "AppDelegate+Assist.h"

@interface UserCenter ()

@end

@implementation UserCenter

+ (UserCenter *)center {
    static UserCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[UserCenter alloc] init];
    });
    return center;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self loadLocalStoreInfo];
    }
    return self;
}

- (SupportStoreInfo *)storeInfo {
    
    if (!_storeInfo) {
        
        _storeInfo = [[SupportStoreInfo alloc]init];
    }
    return _storeInfo;
}

#pragma mark - public

- (void)saveStoreInfo {
    
    if (self.storeInfo) {

        [NSKeyedArchiver archiveRootObject:self.storeInfo toFile:self.storeInfo.localPath];
    }
}

- (void)loadLocalStoreInfo {
    NSString *path = self.storeInfo.localPath;
    self.storeInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    [self performSelector:@selector(judgeAlias) withObject:nil afterDelay:3];//自动登录之后
}

- (void)clearStoreInfo {

    [self.storeInfo clearLocalData];
    
    [self jpushAliasReSet];
}


/**
 重置推送别名
 */
- (void)jpushAliasReSet {
    
    self.storeInfo.aliasString = nil;//清除别名
    
    [self performSelector:@selector(judgeAlias) withObject:nil afterDelay:3];
}


/**
 判断设置别名
 */
- (void)judgeAlias{
    
    self.storeInfo.deviceTokenString = self.storeInfo.deviceTokenString;//请求别名，设置别名
}

#pragma mark - 家族信息


@end

@implementation SupportStoreInfo

#pragma mark - nscoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.deviceTokenString forKey:@"deviceToken"];
    [aCoder encodeObject:self.aliasString forKey:@"alias"];
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        
        _aliasString = [aDecoder decodeObjectForKey:@"alias"];
        _deviceTokenString = [aDecoder decodeObjectForKey:@"deviceToken"];
    }
    return self;
}

- (BOOL)clearCacheWithFilePath:(NSString *)path {
    
    NSError *error = nil;
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (error) {
        return NO;
    }
    
    return YES;
}

#pragma mark - public

- (void)clearLocalData {
    [self clearCacheWithFilePath:self.localPath];
}

- (NSString *)localPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:kLocalStoragePath]) {
        [manager createDirectoryAtPath:kLocalStoragePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [kLocalStoragePath stringByAppendingFormat:@"/%@.plist", @"SupportStoreInfo"];
}

@end
