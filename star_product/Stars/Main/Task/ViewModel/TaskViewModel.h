//
//  TaskViewModel.h
//  Stars
//
//  Created by livesxu on 2018/9/17.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseViewModel.h"

#import "TaskScrollModel.h"

@interface TaskViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *dayTaskArray;

@property (nonatomic, strong) NSMutableArray *supportTaskArray;

- (void)layoutDayTaskRequest:(void(^)(BOOL isSuccess))result;

- (void)layoutSupportTaskRequest:(void(^)(BOOL isSuccess))result;

@end
