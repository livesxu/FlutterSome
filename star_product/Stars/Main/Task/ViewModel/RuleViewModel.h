//
//  RuleViewModel.h
//  Stars
//
//  Created by livesxu on 2018/9/21.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseViewModel.h"

@interface RuleViewModel : BaseViewModel

@end

@interface HistoryDiamondModel : BaseModel

@property (nonatomic,   copy) NSString *source; //eg：每日发放

@property (nonatomic,   copy) NSString *time; //eg：2018.04.20

@property (nonatomic,   copy) NSString *change; //eg: +5

@end
