//
//  UIView+ShowStatus.m
//  Stars
//
//  Created by Xu小波 on 2017/12/16.
//  Copyright © 2017年 Livesxu. All rights reserved.
//

#import "UIView+ShowStatus.h"

@interface UIView ()

@property (nonatomic, strong) UIView *commonStatusView;

@property (nonatomic, strong) UIButton *commonErrorView;

@end

@implementation UIView (ShowStatus)

- (CGRect)statusRect{
    NSValue *rectValue = objc_getAssociatedObject(self, _cmd);
    return rectValue.CGRectValue;
}

- (void)setStatusRect:(CGRect)statusRect{
    
    objc_setAssociatedObject(self, @selector(statusRect), [NSValue valueWithCGRect:statusRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RetryAction)retryAction{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRetryAction:(RetryAction)retryAction{
    
    objc_setAssociatedObject(self, @selector(retryAction), retryAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//状态标识 0:正常状态 1:error
- (void)setStatusFlag:(CommonShowStatus)statusFlag{
    objc_setAssociatedObject(self, @selector(statusFlag), @(statusFlag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    for (UIView *view in self.commonStatusView.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:self.commonStatusView];
    
    switch (statusFlag) {
        case 0:
            [self.commonStatusView removeFromSuperview];
            break;
        case 1:
            [self.commonStatusView addSubview:self.commonErrorView];
            break;
            
        default:
            break;
    }
}

- (CommonShowStatus)statusFlag{
    NSNumber *flag = objc_getAssociatedObject(self, @selector(statusFlag));
    if (!flag) {
        
        flag = @(0);
    }
    return flag.integerValue;
}

- (UIView *)commonStatusView {
    UIView *view = objc_getAssociatedObject(self, @selector(commonStatusView));
    if (!view) {
        
        view = [[UIView alloc]initWithFrame:self.bounds];
        view.backgroundColor = pageColor;
        if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
            
            CGFloat vcHeaderHeight = (self.height/kScreenHeight > .8f) ? Layout(44) :Layout(30);
            view.frame = CGRectMake(0, vcHeaderHeight, self.width, self.height - vcHeaderHeight);
        }
        if (self.statusRect.size.width && self.statusRect.size.height) {
            
            view.frame = self.statusRect;
        }
        
        objc_setAssociatedObject(self, @selector(commonStatusView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (UIButton *)commonErrorView {
    UIButton *view = objc_getAssociatedObject(self, @selector(commonErrorView));
    if (!view) {
        
        view = [[UIButton alloc]initWithFrame:self.commonStatusView.bounds];
        
        [view setImage:[UIImage imageNamed:@"baocuo"] forState:UIControlStateNormal];
        
        [view setImageEdgeInsets:UIEdgeInsetsMake(-Layout(30), 0, 0, 0)];
        
        CGRect imgRect = view.imageView.frame;
        
        UIButton *retryBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(imgRect) + (CGRectGetWidth(imgRect) - Layout(90))/2, CGRectGetMaxY(imgRect) + Layout(10), Layout(90), Layout(30))];
        [retryBtn setBackgroundImage:[UIImage imageNamed:@"baseClick"] forState:UIControlStateNormal];
        [retryBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        retryBtn.titleLabel.font = Font(14);
        
        [view addSubview:retryBtn];
        
        __weak typeof(self) weakSelf = self;
        [[retryBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (weakSelf.retryAction) {
                
                weakSelf.statusFlag = 0;
                
                weakSelf.retryAction();
            }
        }];
        
        objc_setAssociatedObject(self, @selector(commonErrorView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

/**
 显示error界面
 
 @param retry 重试操作
 */
- (void)showErrorRetry:(RetryAction)retry;{
    
    self.statusFlag = 1;
    self.retryAction = retry;
    
}

@end
