//
//  LXAlertBlockTips+AddConfig.m
//  Stars
//
//  Created by livesxu on 2018/9/25.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "LXAlertBlockTips+AddConfig.h"

@implementation LXAlertBlockTips (AddConfig)

/**
 类目修改配置
 
 @return 返回closeBtn
 */
- (UIButton *)configCloseStyle;{
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"publish_close_n"] forState:UIControlStateNormal];
    
    return closeBtn;
}

/**
 类目修改配置
 
 @return 放回btn样式
 */
- (UIButton *)configButtonStyle;{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:Layout(16)];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;

    [btn setTitleColor:Color333 forState:UIControlStateNormal];
    
    return btn;
}

@end
