//
//  CommonWebTableViewCell.h
//  Stars
//
//  Created by livesxu on 2018/9/25.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebHeight)(CGFloat height);

@interface CommonWebTableViewCell : UITableViewCell

@property (nonatomic,   copy) NSString *url;

@property (nonatomic,   copy) WebHeight webHeight;

@end
