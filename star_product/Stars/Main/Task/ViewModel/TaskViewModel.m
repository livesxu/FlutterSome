//
//  TaskViewModel.m
//  Stars
//
//  Created by livesxu on 2018/9/17.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "TaskViewModel.h"

@implementation TaskViewModel

- (NSMutableArray *)dayTaskArray {
    
    if (!_dayTaskArray) {
        
        _dayTaskArray = [NSMutableArray array];
    }
    return _dayTaskArray;
}

- (NSMutableArray *)supportTaskArray {
    
    if (!_supportTaskArray) {
        
        _supportTaskArray = [NSMutableArray array];
    }
    return _supportTaskArray;
}

//获取轮播数据
- (void)layoutRequestBackData:(LayoutData)layoutData;{
    
    NSString *imgOne = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537194405007&di=ccf9c23ed8eefe1bd11879e73fa63e78&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fd52a2834349b033b1c4bcdcf1fce36d3d439bde7.jpg";
    NSString *imgTwo = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537193987972&di=5dd3bcca74eebec0758c3cb61b044027&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F9825bc315c6034a81c94dd93c1134954092376a9.jpg";
    NSString *imgThree = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537192841531&di=b85b743311fbd3ca0a7c9866ad0adb97&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fa08b87d6277f9e2fd7e815091530e924b999f3d6.jpg";
    
    TaskScrollModel *model1 = [[TaskScrollModel alloc]init];
    model1.imgUrl = imgOne;
    
    TaskScrollModel *model2 = [[TaskScrollModel alloc]init];
    model2.imgUrl = imgTwo;
    
    TaskScrollModel *model3 = [[TaskScrollModel alloc]init];
    model3.imgUrl = imgThree;
    
    [self.dataArray addObjectsFromArray:@[model1,model2,model3]];
    
    layoutData(YES);
}

- (void)layoutDayTaskRequest:(void(^)(BOOL isSuccess))result;{
    
    DayTaskModel *model1 = [[DayTaskModel alloc]init];
    model1.imgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537510459782&di=95608c34cbddca7d8d94db10f8926758&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0141ce55c019f16ac7253f36e41171.jpg%401280w_1l_2o_100sh.jpg";
    
    model1.missionTitle = @"给优秀内容点赞数据1";//标题
    
    model1.missionRewardDesc = @"+10能量";//奖励描述 eg:+20能量
    
    model1.missionProgress = @"0/10";//进度 eg:0/10
//    link;
    
    [self.dayTaskArray addObject:model1];
    
    DayTaskModel *model2 = [[DayTaskModel alloc]init];
    model2.imgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537510459782&di=95608c34cbddca7d8d94db10f8926758&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0141ce55c019f16ac7253f36e41171.jpg%401280w_1l_2o_100sh.jpg";
    
    model2.missionTitle = @"给优秀内容点赞数据22";//标题
    
    model2.missionRewardDesc = @"+20能量";//奖励描述 eg:+20能量
    
    model2.missionProgress = @"0/20";//进度 eg:0/10
    //    link;
    
    [self.dayTaskArray addObject:model2];
    
    result(YES);
}

- (void)layoutSupportTaskRequest:(void(^)(BOOL isSuccess))result;{
    
    SupportTaskModel *model1 = [[SupportTaskModel alloc]init];
    
    model1.imgUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2186228563,3264441138&fm=200&gp=0.jpg";
    model1.supportTitle = @"开学啦开学啦数据1";
    model1.supportUnit = @"星钻";
    model1.supportTarget = @"100";//目标
    model1.supportGet = @"10";//已获得
    model1.supportEndTime = @"2019-09-01 00:00";//结束时间
    model1.supportNumbers = @"88";//参与人数
//    link
    [self.supportTaskArray addObject:model1];
    
    SupportTaskModel *model2 = [[SupportTaskModel alloc]init];
    
    model2.imgUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2186228563,3264441138&fm=200&gp=0.jpg";
    model2.supportTitle = @"开学啦开学啦数据2开学啦开学啦数据2开学啦开学啦数据2开学啦开学啦数据2";
    model2.supportUnit = @"星钻";
    model2.supportTarget = @"200";//目标
    model2.supportGet = @"40";//已获得
    model2.supportEndTime = @"2020-09-01 00:00";//结束时间
    model2.supportNumbers = @"8888";//参与人数
    //    link
    [self.supportTaskArray addObject:model2];
    
    result(YES);
}

@end
