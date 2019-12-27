//
//  RuleViewModel.m
//  Stars
//
//  Created by livesxu on 2018/9/21.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "RuleViewModel.h"

@implementation RuleViewModel

/**
 布局数据
 
 @param layoutData 成功||失败
 */
- (void)layoutRequestBackData:(LayoutData)layoutData;{
    [super layoutRequestBackData:layoutData];
    
    HistoryDiamondModel *model = [[HistoryDiamondModel alloc]init];
    model.source = @"每日发放";
    model.time = @"2018.04.20";
    model.change = @"+5";
    [self.dataArray addObject:model];
    
    HistoryDiamondModel *model2 = [[HistoryDiamondModel alloc]init];
    model2.source = @"每日发放";
    model2.time = @"2018.04.19";
    model2.change = @"+4";
    [self.dataArray addObject:model2];
    
    HistoryDiamondModel *model3 = [[HistoryDiamondModel alloc]init];
    model3.source = @"每日发放";
    model3.time = @"2018.04.18";
    model3.change = @"+3";
    [self.dataArray addObject:model3];
    
    layoutData(YES);
}

@end

@implementation HistoryDiamondModel

@end
