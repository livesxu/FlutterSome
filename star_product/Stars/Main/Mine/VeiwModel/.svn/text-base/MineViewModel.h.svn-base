//
//  MineViewModel.h
//  Stars
//
//  Created by livesxu on 2018/9/27.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseViewModel.h"

@interface MineViewModel : BaseViewModel

@property (nonatomic,   copy) NSString *containDiamonds;

@property (nonatomic,   copy) NSString *agoDiamonds;

@property (nonatomic,   copy) NSString *totalDiamonds;

@property (nonatomic,   copy) NSString *todayDiamonds;

@property (nonatomic,   copy) NSString *totalTodayPowers;

@property (nonatomic,   copy) NSString *myTodayPower;


@property (nonatomic, strong) NSMutableArray *starsList;
/**
 获取关注明星列表

 @param result result
 */
- (void)mineStarsList:(void(^)(BOOL isSuccess))result;

@end
