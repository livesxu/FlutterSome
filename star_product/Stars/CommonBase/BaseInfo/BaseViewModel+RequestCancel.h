//
//  BaseViewModel+RequestCancel.h
//  Stars
//
//  Created by Xu小波 on 2017/11/23.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel (RequestCancel)

- (void)autoCancelRequestWith:(id)requestId;

@end
