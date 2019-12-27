//
//  CountdownBtn.m
//  Shuzan
//
//  Created by ChangB on 2017/12/6.
//  Copyright © 2017年 Shujin. All rights reserved.
//

#import "CountdownBtn.h"
@interface CountdownBtn()

@property(nonatomic,assign) BOOL isCounting;
@property(nonatomic,assign) UIBackgroundTaskIdentifier backgroundTaskFlag;
@end

@implementation CountdownBtn

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    CountdownBtn *btn = [super buttonWithType:buttonType];
    if (!btn) {
       btn = CountdownBtn.new;
    }
    btn.isCounting = NO;
    btn.backgroundColor = [UIColor colorWithHexString:@"6c00ff" alpha:0.7];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    return  btn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isCounting = NO;
    }
    return self;
}

- (void)startCountingDownWith:(void(^)(NSInteger))hander completed:(void(^)(void))done {
    [self stopCount];
     self.isCounting = YES;
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 60; i > 0; i--) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf.isCounting) {
                    done();
                    return ;
                }
                hander(i);
            });
            sleep(1);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf stopCount];
            done();
        });
    });
    [self beginBackgroundTask];
}

- (void)stopCount {
    self.isCounting = NO;
    [self endBackgroundTask];
}
- (void)dealloc {
    [self stopCount];
    NSLog(@"dealloc %@",self);
}

- (void)beginBackgroundTask {
    self.backgroundTaskFlag = [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler:^{
        
    }];
}

- (void)endBackgroundTask {
    [UIApplication.sharedApplication endBackgroundTask:self.backgroundTaskFlag];
    self.backgroundTaskFlag = UIBackgroundTaskInvalid;
}

- (void)setBtnDisableWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor backgroundImg:(UIImage *)bgImg {
    if (title) {
    [self setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
       [self setTitleColor:color forState:UIControlStateNormal];
    }
    if (bgColor) {
        [self setBackgroundColor:bgColor];
    }
    if (bgImg) {
        [self setBackgroundImage:bgImg forState:UIControlStateNormal];
    }
    self.userInteractionEnabled = NO;
}
- (void)setBtnEnableWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor backgroundImg:(UIImage *)bgImg {
    if (title) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    if (bgColor) {
        [self setBackgroundColor:bgColor];
    }
    if (bgImg) {
        [self setBackgroundImage:bgImg forState:UIControlStateNormal];
    }
    self.userInteractionEnabled = YES;
}




@end
