//
//  StarViewModel.m
//  Stars
//
//  Created by livesxu on 2018/9/28.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "StarViewModel.h"

#import "StarInfoModel.h"

@interface StarViewModel ()

@property (nonatomic, assign) CGFloat tempHeight;

@end

@implementation StarViewModel

- (NSMutableArray *)latestArray {
    
    if (!_latestArray) {
        
        _latestArray = [NSMutableArray array];
    }
    return _latestArray;
}

- (NSMutableArray *)hotArray {
    
    if (!_hotArray) {
        
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

/**
 布局数据
 
 @param layoutData 成功||失败
 */
- (void)layoutRequestBackData:(LayoutData)layoutData;{
    [super layoutRequestBackData:layoutData];
    
    
}

- (void)newListRequest:(void(^)(BOOL isSuccess))result;{
    
    NSString *tempString = @"1\n1\n1";
    _tempHeight = [tempString boundingRectWithSize:CGSizeMake(kScreenWidth - Layout(30), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Layout(14)]}context:nil].size.height;
    
    
    StarInfoModel *model = [[StarInfoModel alloc]init];
    model.infoId = @"1";//发布id
    model.name = @"波波";//昵称
    model.imgUrl = @"http://5b0988e595225.cdn.sohucs.com/images/20171216/a72351d45dee4e6fa270985fb5394f1e.jpeg";//头像
    model.level = @"8";//等级
    model.time = @"2018-10-09 00:00:00";//发布时间
    model.textContent = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";//发布文字
    model.imgContent = @[@"http://pic1.win4000.com/tj/2017-12-07/5a28b54584b99.jpg",@"http://img.mp.itc.cn/upload/20170511/309bba9704a3446a833c0d1a45c18d56_th.jpg",@"http://5b0988e595225.cdn.sohucs.com/images/20171216/a72351d45dee4e6fa270985fb5394f1e.jpeg",@"http://img5.duitang.com/uploads/item/201603/26/20160326105840_UvMCs.jpeg"];//发布图片
    model.infoType = @"2";//内容类型 0:无类型(话题无) 1:星动态 2:星愿设计
    model.talkNum = @"888";//评论数
    model.isLike = @"-1";//是否喜欢  -1:无相关操作  0:不喜欢  1:喜欢
    
    [self planModel:model];
    
    [self.latestArray addObject:model];
    
    StarInfoModel *model1 = [[StarInfoModel alloc]init];
    model1.infoId = @"2";//发布id
    model1.name = @"波波ceshi2";//昵称
    model1.imgUrl = @"http://5b0988e595225.cdn.sohucs.com/images/20171216/a72351d45dee4e6fa270985fb5394f1e.jpeg";//头像
    model1.level = @"10";//等级
    model1.time = @"2018-10-08 00:00:00";//发布时间
    model1.textContent = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长测试很长";//发布文字
    model1.imgContent = @[@"http://pic1.win4000.com/tj/2017-12-07/5a28b54584b99.jpg",@"http://img.mp.itc.cn/upload/20170511/309bba9704a3446a833c0d1a45c18d56_th.jpg",@"http://5b0988e595225.cdn.sohucs.com/images/20171216/a72351d45dee4e6fa270985fb5394f1e.jpeg",@"http://img5.duitang.com/uploads/item/201603/26/20160326105840_UvMCs.jpeg"];//发布图片
    model1.infoType = @"1";//内容类型 0:无类型(话题无) 1:星动态 2:星愿设计
    model1.talkNum = @"88888";//评论数
    model1.isLike = @"0";//是否喜欢  -1:无相关操作  0:不喜欢  1:喜欢
    
    [self planModel:model1];
    
    [self.latestArray addObject:model1];
    
    StarInfoModel *model2 = [[StarInfoModel alloc]init];
    model2.infoId = @"1";//发布id
    model2.name = @"波波测试3";//昵称
    model2.imgUrl = @"http://5b0988e595225.cdn.sohucs.com/images/20171216/a72351d45dee4e6fa270985fb5394f1e.jpeg";//头像
    model2.level = @"12";//等级
    model2.time = @"2018-10-06 00:00:00";//发布时间
    model2.textContent = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";//发布文字
    model2.imgContent = @[@"http://pic1.win4000.com/tj/2017-12-07/5a28b54584b99.jpg",@"http://img.mp.itc.cn/upload/20170511/309bba9704a3446a833c0d1a45c18d56_th.jpg"];//发布图片
    model2.infoType = @"0";//内容类型 0:无类型(话题无) 1:星动态 2:星愿设计
    model2.talkNum = @"8";//评论数
    model2.isLike = @"1";//是否喜欢  -1:无相关操作  0:不喜欢  1:喜欢
    
    [self planModel:model2];
    
    [self.latestArray addObject:model2];
    
    result(YES);
}

- (void)planModel:(StarInfoModel *)model {
    
    //
    model.cellHeight = Layout(70) + Layout(44);
    
    if (model.textContent && model.textContent.length) {
        
        model.textHeight = [model.textContent boundingRectWithSize:CGSizeMake(kScreenWidth - Layout(30), _tempHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Layout(14)]}context:nil].size.height;
        
        model.cellHeight += (model.textHeight + Layout(10));
    }
    
    if (model.activeTags) {
        
        model.cellHeight += Layout(20);
    }
    if (model.imgContent && model.imgContent.count) {
        
        model.cellHeight += (Layout(100) + Layout(10));
    }
}

- (void)hotListRequest:(void(^)(BOOL isSuccess))result;{
    
}

@end
