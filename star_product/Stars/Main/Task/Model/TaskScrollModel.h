//
//  TaskScrollModel.h
//  Stars
//
//  Created by livesxu on 2018/9/17.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseModel.h"

@interface TaskScrollModel : BaseModel

@property (nonatomic,   copy) NSString *imgUrl;//图片地址

@property (nonatomic,   copy) NSString *link;//行为链接

@end

@interface DayTaskModel : BaseModel

@property (nonatomic,   copy) NSString *dayTaskId;

@property (nonatomic,   copy) NSString *imgUrl;
    
@property (nonatomic,   copy) NSString *missionTitle;//标题
    
@property (nonatomic,   copy) NSString *missionRewardDesc;//奖励描述 eg:+20能量
    
@property (nonatomic,   copy) NSString *missionProgress;//进度 eg:0/10
    
@property (nonatomic,   copy) NSString *link;

@end

@interface SupportTaskModel : BaseModel

@property (nonatomic,   copy) NSString *supportId;

@property (nonatomic,   copy) NSString *imgUrl;//图片

@property (nonatomic,   copy) NSString *supportUnit;//应援单位  0：星钻  1：塔可（能量）
    
@property (nonatomic,   copy) NSString *supportTitle;//标题
    
@property (nonatomic,   copy) NSString *supportTarget;//目标 eg:100
    
@property (nonatomic,   copy) NSString *supportGet;//已获得 eg:20
    
@property (nonatomic,   copy) NSString *supportEndTime;//结束时间 eg:2018-07-28 24:00
    
@property (nonatomic,   copy) NSString *supportNumbers;//参与人数 eg:80
    
//@property (nonatomic,   copy) NSString *link;

//detail add
@property (nonatomic,   copy) NSString *detailUrl;//详情页地址

@property (nonatomic,   copy) NSString *partDiamond;//一份钻石数

@property (nonatomic,   copy) NSString *partFlag;//是否已参与标记 0：未参与  1：已参与过

@property (nonatomic,   copy) NSString *partType;//参与方式 1：固定金额应援  2：非固定金额(可继续参与)

@property (nonatomic,   copy) NSString *partMaxLeft;//非固定金额 剩余次数(最大参与次数 - 已参与次数) - 对应后台应援次数

@property (nonatomic,   copy) NSString *partPayShowImgUrl;//非固定金额 参与 支付 页面图片地址

//本地操作添加 - 区分是否主要展示
@property (nonatomic, assign) BOOL isMain;//详情样式添加

@end
