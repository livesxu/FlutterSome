//
//  MineViewModel.m
//  Stars
//
//  Created by livesxu on 2018/9/27.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "MineViewModel.h"

#import "StarsListModel.h"

@implementation MineViewModel

- (NSMutableArray *)starsList {
    if (!_starsList) {
        
        _starsList = [NSMutableArray array];
    }
    return _starsList;
}

/**
 布局数据
 
 @param layoutData 成功||失败
 */
- (void)layoutRequestBackData:(LayoutData)layoutData;{
    [super layoutRequestBackData:layoutData];
    
    
    _containDiamonds = @"520";
    _agoDiamonds = @"500";
    _totalDiamonds = @"5000";
    _todayDiamonds = @"500";
    _totalTodayPowers = @"500";
    _myTodayPower = @"50";
    layoutData(YES);
}

/**
 获取关注明星列表
 
 @param result result
 */
- (void)mineStarsList:(void(^)(BOOL isSuccess))result;{
    
    //插入 添加明星
    StarsListModel *model = [[StarsListModel alloc]init];
    model.starId = @"-1";
    model.starNoTitle = @"添加明星";
    [self.starsList addObject:model];
    
    StarsListModel *model1 = [[StarsListModel alloc]init];
    model1.starId = @"1";
    model1.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043698663&di=a8f4550e51dad363d4c8770f5a8aa0b1&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170405%2F8292281491383770.jpg";
    
    [self.starsList addObject:model1];
    
    StarsListModel *model2 = [[StarsListModel alloc]init];
    model2.starId = @"2";
    model2.starImgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538043731936&di=6549ee0e2faca24bced0e8347914d6de&imgtype=0&src=http%3A%2F%2Fs4.sinaimg.cn%2Fbmiddle%2F004dtQs0zy6L9KypJib73%26690";
    
    [self.starsList addObject:model2];
    
    StarsListModel *model3 = [[StarsListModel alloc]init];
    model3.starId = @"3";
    model3.starImgUrl = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4158757258,2483569628&fm=26&gp=0.jpg";
    
    [self.starsList addObject:model3];
}

@end
