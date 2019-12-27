//
//  CommonWebViewController.h
//  Stars
//
//  Created by Xu小波 on 2017/11/23.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "BaseViewController.h"

@interface CommonWebViewController : BaseViewController

/**
 返回按钮点击后是否直接pop
 */
@property (nonatomic, assign) BOOL isBackToRoot;

/**
 链接
 */
@property (nonatomic,   copy) NSString *urlString;

@end
