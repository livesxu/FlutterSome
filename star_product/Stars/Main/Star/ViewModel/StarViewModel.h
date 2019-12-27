//
//  StarViewModel.h
//  Stars
//
//  Created by livesxu on 2018/9/28.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseViewModel.h"

@interface StarViewModel : BaseViewModel

@property (nonatomic,   copy) NSString *starId;

@property (nonatomic, strong) NSMutableArray *latestArray;

@property (nonatomic, strong) NSMutableArray *hotArray;

- (void)newListRequest:(void(^)(BOOL isSuccess))result;

- (void)hotListRequest:(void(^)(BOOL isSuccess))result;

@end
