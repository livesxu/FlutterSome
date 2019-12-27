//
//  UserCenter.h
//  Stars
//
//  Created by ChangB on 2017/12/6.
//  Copyright © 2017年 Livesxu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLocalStoragePath [NSString stringWithFormat:@"%@%@",NSHomeDirectory(),@"/Documents/LocalStorage"]

@class SupportStoreInfo;

@interface UserCenter : NSObject

+ (UserCenter *)center;

@property (nonatomic, strong) SupportStoreInfo *storeInfo;

/**
 保存用户信息
 */
- (void)saveStoreInfo;

/**
 加载本地用户信息
 */
- (void)loadLocalStoreInfo;

/**
 清除本地数据
 */
- (void)clearStoreInfo;

@end

@interface SupportStoreInfo : BaseModel

@property (nonatomic,   copy) NSString *deviceTokenString;

@property (nonatomic,   copy) NSString *aliasString;//推送别名

/**
 本地保存地址
 
 @return 地址
 */
- (NSString *)localPath;

/**
 清除本地用户数据
 */
- (void)clearLocalData;

@end
