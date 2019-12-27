//
//  RegisterUserViewModel.h
//  Stars
//
//  Created by CadaverousBlue on 2018/10/7.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseViewModel.h"

@interface RegisterUserViewModel : BaseViewModel
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *nickname;
- (RACCommand *)registerCommand;
- (void)requestToSendCodeWithResult:(void(^)(void))done;
@end
