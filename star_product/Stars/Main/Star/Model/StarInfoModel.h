//
//  StarInfoModel.h
//  Stars
//
//  Created by livesxu on 2018/10/8.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "BaseModel.h"

@class StarActiveModel;

@interface StarInfoModel : BaseModel

@property (nonatomic,   copy) NSString *infoId;//发布id

@property (nonatomic,   copy) NSString *name;//昵称

@property (nonatomic,   copy) NSString *imgUrl;//头像

@property (nonatomic,   copy) NSString *level;//等级

@property (nonatomic,   copy) NSString *time;//发布时间

@property (nonatomic,   copy) NSString *textContent;//发布文字

@property (nonatomic, strong) NSArray *imgContent;//发布图片

@property (nonatomic,   copy) NSString *infoType;//内容类型 0:无类型(话题无) 1:星动态 2:星愿设计

@property (nonatomic,   copy) NSString *talkNum;//评论数

@property (nonatomic,   copy) NSString *isLike;//是否喜欢  -1:无相关操作  0:不喜欢  1:喜欢

//星动态添加
@property (nonatomic, strong) StarActiveModel *activeTags;

@property (nonatomic, assign) CGFloat textHeight;//文本高度 - 本地计算添加

@property (nonatomic, assign) CGFloat cellHeight;

@end

@interface StarActiveModel : BaseModel

@property (nonatomic,   copy) NSString *starName;//发生明星

@property (nonatomic,   copy) NSString *happenTime;//发生时间

@property (nonatomic,   copy) NSString *happenAdress;//地点

@end
