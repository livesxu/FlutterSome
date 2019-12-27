//
//  LoginViewModel.h
//  Stars
//
//  Created by Rdvfx on 2018/9/28.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *code;

//- (RACSignal *)verifyInutSignal;
- (RACCommand *)loginCommand;
- (RACCommand *)weChatCommand;
- (RACCommand *)sinaCommand;
- (void)requestToSendCodeWithResult:(void(^)(void))done;
@end
