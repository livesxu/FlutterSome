//
//  RegisterUserViewModel.m
//  Stars
//
//  Created by CadaverousBlue on 2018/10/7.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "RegisterUserViewModel.h"

@implementation RegisterUserViewModel


- (RACSignal *)verifyInutSignal {
    
    return  [RACSignal combineLatest:@[RACObserve(self, phone),RACObserve(self, code),RACObserve(self, nickname)] reduce:^id(NSString * phoneValue, NSString *codeValue, NSString *nicknameValue){
        return @(phoneValue.length == 11 && codeValue.length > 0 && nicknameValue.length > 0);
    }];
    
}

- (RACCommand *)registerCommand {
    
    __weak typeof(self)weakSelf = self;
    
    return [RACCommand.alloc initWithEnabled:self.verifyInutSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            if (!weakSelf.phone.validateMobile) {
                
                [subscriber sendError:[NSError errorWithDomain:@"您输入的手机号错误或不存在" code:1000 userInfo:nil]];
            } else {
                
                CommonRequestApi *api = CommonRequestApi.new;
                api.lxRequestURL(COMMON_API(@"/a"));
                api.lxBody(@{@"phone":self.phone,@"code":self.code.md5.md5,@"nickname":@"a"});
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
