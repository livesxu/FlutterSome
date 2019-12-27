//
//  TopListViewModel.m
//  Stars
//
//  Created by livesxu on 2018/9/27.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "TopListViewModel.h"

#import "StarsListModel.h"

@implementation TopListViewModel

- (NSMutableArray *)topRankArray {
    
    if (!_topRankArray) {
        
        _topRankArray = [NSMutableArray array];
    }
    return _topRankArray;
}

/**
 布局数据
 
 @param layoutData 成功||失败
 */
- (void)layoutRequestBackData:(LayoutData)layoutData;{
    [super layoutRequestBackData:layoutData];
    
    StarsListModel *model = [[StarsListModel alloc]init];
    model.starId = @"1";
    model.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    model.starRank = @"1";
    model.starName = @"测试1名字";
    model.starStanding = @"11000";
    
    [self.dataArray addObject:model];
    
    StarsListModel *model2 = [[StarsListModel alloc]init];
    model2.starId = @"2";
    model2.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    model2.starRank = @"2";
    model2.starName = @"测试2名字";
    model2.starStanding = @"10000";
    
    [self.dataArray addObject:model2];
    
    StarsListModel *model3 = [[StarsListModel alloc]init];
    model3.starId = @"3";
    model3.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    model3.starRank = @"3";
    model3.starName = @"测试3";
    model3.starStanding = @"9000";
    
    [self.dataArray addObject:model3];
    
    StarsListModel *model4 = [[StarsListModel alloc]init];
    model4.starId = @"4";
    model4.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    model4.starRank = @"4";
    model4.starName = @"测试4";
    model4.starStanding = @"5000";
    
    [self.dataArray addObject:model4];
    
    StarsListModel *model5 = [[StarsListModel alloc]init];
    model5.starId = @"5";
    model5.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    model5.starRank = @"5";
    model5.starName = @"测试5";
    model5.starStanding = @"3000";
    
    [self.dataArray addObject:model5];
    
    StarsListModel *model6 = [[StarsListModel alloc]init];
    model6.starId = @"6";
    model6.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    model6.starRank = @"6";
    model6.starName = @"测试6";
    model6.starStanding = @"1000";
    
    [self.dataArray addObject:model6];
    
    
    for (NSInteger i = 0; i < 3; i++) {
        
        if (self.dataArray.firstObject) {
            
            [self.topRankArray addObject:self.dataArray.firstObject];
            [self.dataArray removeObjectAtIndex:0];
        }
    }
    
    layoutData(YES);
}

@end
