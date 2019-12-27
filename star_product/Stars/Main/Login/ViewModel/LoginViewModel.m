//
//  LoginViewModel.m
//  Stars
//
//  Created by Rdvfx on 2018/9/28.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "LoginViewModel.h"
@interface LoginViewModel()
@property(nonatomic, strong) RACSignal *phoneSingal;
@property(nonatomic, copy) NSString *openId;
@end
@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phoneSingal = RACObserve(self, phone);
    }
    return self;
}

- (RACSignal *)verifyInutSignal {

   return  [RACSignal combineLatest:@[self.phoneSingal,RACObserve(self, code)] reduce:^id(NSString * phoneValue, NSString *codeValue){
        return @(phoneValue.length == 11 && codeValue.length > 0 );
    }];
 
}


- (RACCommand *)loginCommand {
    
    __weak typeof(self)weakSelf = self;
    
   return [RACCommand.alloc initWithEnabled:self.verifyInutSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            if (!weakSelf.phone.validateMobile) {
               
                [subscriber sendError:[NSError errorWithDomain:@"您输入的手机号错误或不存在" code:1000 userInfo:nil]];
            } else {
                
                CommonRequestApi *api = CommonRequestApi.new;
                api.lxRequestURL(COMMON_API(@"/a"));
                api.lxBody(@{@"phone":self.phone,@"code":self.code.md5.md5});
                [api startWithNomalCompletionBlock:^(BOOL isSuccess, id responseData) {
                    if (isSuccess) {
                        
                        [subscriber sendNext:responseData];
                        
                        
                    }
                    [subscriber sendCompleted];
                }];
            }
            
            return  nil;
        }];
    }];
}


- (RACCommand *)weChatCommand {
    
    __weak typeof(self)weakSelf = self;
    
    return [RACCommand.alloc initWithEnabled:self.verifyInutSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            
//            if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]) {
//                [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
//            }
//
//            [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//                if (state == SSDKResponseStateSuccess) {
//                    NSLog(@"uid=%@",user.uid);
//                    NSLog(@"%@",user.credential);
//                    NSLog(@"token=%@",user.credential.token);
//                    NSLog(@"nickname=%@",user.nickname);
//
//                    [self requestToLoginWithOtherPlatformData:@{@"headImg":user.icon,@"nickName":user.nickname} platformType:@"1" openId:user.uid result:^(NSString *r) {
//                        if (r.length) {
//                             // error
//                        } else if ([r isEqualToString:@"openId"]) {
//                            [subscriber sendNext:self.openId];
//                        } else if([r isEqualToString:@"OK"]) {
//                            // TODO: login
//
//                        }
//                        [subscriber sendCompleted];
//                    }];
//                } else {
//                     [subscriber sendError:error];
//
//                }
//            }];
            
            return  nil;
        }];
    }];
}
- (RACCommand *)sinaCommand {
    
    __weak typeof(self)weakSelf = self;
    
    return [RACCommand.alloc initWithEnabled:self.verifyInutSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            
//            if ([ShareSDK hasAuthorized:SSDKPlatformTypeSinaWeibo]) {
//                [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
//            }
//            
//            [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//                if (state == SSDKResponseStateSuccess) {
//                    NSLog(@"uid=%@",user.uid);
//                    NSLog(@"%@",user.credential);
//                    NSLog(@"token=%@",user.credential.token);
//                    NSLog(@"nickname=%@",user.nickname);
//                    
//                    [self requestToLoginWithOtherPlatformData:@{@"headImg":user.icon,@"nickName":user.nickname} platformType:@"1" openId:user.uid result:^(NSString *r) {
//                        if (r.length) {
//                            // error
//                        } else if ([r isEqualToString:@"openId"]) {
//                            [subscriber sendNext:self.openId];
//                        } else if([r isEqualToString:@"OK"]) {
//                            // TODO: login
//                            
//                        }
//                        [subscriber sendCompleted];
//                    }];
//                } else {
//                    [subscriber sendError:error];
//                    
//                }
//            }];
            
            return  nil;
        }];
    }];
}
- (void)requestToLoginWithOtherPlatformData:(NSDictionary<NSString *, NSString *> *)data platformType:(NSString *)type openId:(NSString *)openId result:(void(^)(NSString *))done {
    
    NSData *temp = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    NSString *mark = [[NSString.alloc initWithData:temp encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    //    // 传递remark 参数
    //    [LXRouter.shareRouter routeStore:@"BindPhoneVC" stores:^id _Nullable{
    //        return mark;
    //    }];
    
    //    [LXRouter.shareRouter routeMap:[NSString stringWithFormat:@"hcz://BindPhoneVC.push?openId=%@",openId] isInContain:YES RouteBlock:nil animated:YES completion:nil];
    //    return;
    CommonRequestApi *login = CommonRequestApi.alloc.init;
    login.lxRequestURL(COMMON_API(@"/app/account/thirdPartyLogin"))
    .lxMethod(YTKRequestMethodPOST)
    .lxBody(@{@"phone":self.phone,@"loginType":type,@"openId":openId,@"remark":mark});
    
    BeginLoading();
    
    [login startWithNomalCompletionBlock:^(BOOL isSuccess, id responseData) {
        EndLoading();
        if (isSuccess) {
            if ([responseData[@"status"] isEqualToString:@"PHONE_NO"]) {

                self.openId = openId;
                done(@"opendId");
               
            } else if ([responseData[@"status"] isEqualToString:@"OK"]) {
                done(@"OK");
               
            }
        } else {
            done(@"");

        }
    }];
}


- (void)requestToSendCodeWithResult:(void(^)(void))done {
    CommonRequestApi *verifyCode = CommonRequestApi.alloc.init;
    verifyCode.lxRequestURL(COMMON_API(@""))
    .lxMethod(YTKRequestMethodPOST)
    .lxHeader(self.phone)
    .lxBody(@{@"phone":self.phone,@"codeType":@"1"});
    
    __weak typeof(self)weakSelf = self;
    //     __weak typeof(btn)weakBtn = btn;
    BeginLoading();
    [verifyCode startWithNomalCompletionBlock:^(BOOL isSuccess, id responseData) {
        EndLoading();
        if (isSuccess) {
            done();
        }
    }];
}


@end
