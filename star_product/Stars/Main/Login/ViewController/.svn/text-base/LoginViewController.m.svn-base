//
//  LoginViewController.m
//  Stars
//
//  Created by Rdvfx on 2018/9/27.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "LoginViewController.h"
#import "CountdownBtn.h"
#import "LoginViewModel.h"
@interface LoginViewController ()

@property(nonatomic, strong) UITextField *phoneTF;
@property(nonatomic, strong) UITextField *codeTF;

@property(nonatomic, strong) CountdownBtn *countDown;

@property(nonatomic, strong) UIButton *loginBtn, *registerBtn, *weChat, *sina;

@property(nonatomic, strong) LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = LoginViewModel.new;
    }
    return _viewModel;
}

- (void)staticViewsWithoutNib {
    [self initUI];
    [self bindViewModel];
}

- (void)initUI {
    // 背景
    UIImageView *bg = [UIImageView.alloc initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    bg.image = [UIImage imageNamed:@"login_bg"];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
    UIView *cover = [UIView.alloc initWithFrame:self.view.bounds];
    cover.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self.view addSubview:cover];
    // 图标
    UIImageView *name = UIImageView.new;
    name.center = CGPointMake(self.view.width / 2, Layout(204 / 2));
    name.bounds = CGRectMake(0, 0, 150 / 2.0, 150 / 2.0);
    name.image = [UIImage imageNamed:@"login_name_icon.png"];
    name.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:name];
    
    UIImageView *phoneIcon = [UIImageView.alloc initWithFrame:CGRectMake(Layout(27), name.bottomPosition + Layout( 77 / 2), 17, 17)];
    phoneIcon.image = [UIImage imageNamed:@"log_mobilenum_n"];
    [self.view addSubview:phoneIcon];
    
    UIView *phoneVerticalLine = [UIView.alloc initWithFrame:CGRectMake(phoneIcon.rightPosition + 12, phoneIcon.y,0.5 , phoneIcon.height)];
    phoneVerticalLine.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:phoneVerticalLine];
    
    // 手机
    self.phoneTF = [UITextField.alloc initWithFrame:CGRectMake(phoneVerticalLine.rightPosition + 12, phoneVerticalLine.y - 4, self.view.width - phoneVerticalLine.rightPosition - 12 - Layout(33), 25)];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.font = [UIFont systemFontOfSize:17];
    self.phoneTF.textColor = UIColor.whiteColor;
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.attributedPlaceholder = [NSAttributedString.alloc initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    [self.view addSubview:self.phoneTF];
    
    UIView *phonehorizontalLine = [UIView.alloc initWithFrame:CGRectMake(phoneIcon.x, phoneIcon.bottomPosition + 10,self.view.width - phoneIcon.x , 0.5)];
    phonehorizontalLine.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:phonehorizontalLine];
    
    
    UIImageView *codeIcon = [UIImageView.alloc initWithFrame:CGRectMake(Layout(27), phonehorizontalLine.bottomPosition + Layout( 38), 17, 17)];
    codeIcon.image = [UIImage imageNamed:@"log_password_n"];
    [self.view addSubview:codeIcon];
    
    UIView *codeVerticalLine = [UIView.alloc initWithFrame:CGRectMake(codeIcon.rightPosition + 12, codeIcon.y,0.5 , codeIcon.height)];
    codeVerticalLine.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:codeVerticalLine];
    
    // 验证码
    self.codeTF = [UITextField.alloc initWithFrame:CGRectMake(codeVerticalLine.rightPosition + 12, codeVerticalLine.y - 4, self.view.width - codeVerticalLine.rightPosition - 12 - Layout(356 / 2), 25)];
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.font = [UIFont systemFontOfSize:17];
    self.codeTF.textColor = UIColor.whiteColor;
//    self.codeTF.secureTextEntry = YES;

    self.codeTF.attributedPlaceholder = [NSAttributedString.alloc initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    [self.view addSubview:self.codeTF];
    
    UIView *codeHorizontalLine = [UIView.alloc initWithFrame:CGRectMake(codeIcon.x , codeIcon.bottomPosition + 10,self.codeTF.rightPosition - codeIcon.x , 0.5)];
    codeHorizontalLine.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:codeHorizontalLine];
    
    
    __weak typeof(self)weakSelf = self;
    // 倒计时
    self.countDown = [CountdownBtn buttonWithType:UIButtonTypeCustom];
    self.countDown.frame = CGRectMake(self.view.width - 120 -  (Layout(356 / 2) - 120) / 2, codeHorizontalLine.bottomPosition - Layout(50), 120, Layout(50));
    self.countDown.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.countDown setRadius:5 borderWidth:0 borderColor:nil];
    [self.countDown setTitle:@"发送验证码" forState:UIControlStateNormal];
    [[self.countDown rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (!weakSelf.viewModel.phone.validateMobile) {
            ShowMessage(@"您输入的手机号错误或不存在"); return ;
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认手机号" message:[NSString stringWithFormat:@"%@\n我们将发送验证码到上面的手机号",weakSelf.viewModel.phone] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.viewModel requestToSendCodeWithResult:^{
                CountdownBtn *c = x;
                [c startCountingDownWith:^(NSInteger index) {
                    
                    [c setTitle:[NSString stringWithFormat:@"%lds",index] forState:UIControlStateNormal];
                } completed:^{
                    [c setTitle:@"发送验证码" forState:UIControlStateNormal];
                }];
            }];
           
        }]];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
        
        
    }];
    [self.view addSubview:self.countDown];
    // 登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.center = CGPointMake(self.view.width / 2, self.countDown.bottomPosition + Layout(76 / 2) + Layout(100 / 2) / 2);
    [self.loginBtn setRadius:5 borderWidth:0 borderColor:nil];
    self.loginBtn.bounds = CGRectMake(0, 0, self.view.width - Layout(30) * 2, Layout(100 / 2));
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"6c00ff" alpha:0.7]] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    
     [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"faf9f3" ]] forState:UIControlStateDisabled];
     [self.loginBtn setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    
    
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self.view addSubview:self.loginBtn];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [x.rac_command execute:nil];
    }];
    
     // 注册
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(self.loginBtn.x, self.loginBtn.bottomPosition + Layout(15), 100, 20);
    [self.registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.registerBtn];
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        // TODO:
        LXRouteMap(@"s://RegisterUserVC.push");
        
    }];
    
    UILabel *tipTitle = [UILabel labelWithFrame:CGRectZero Text:@"---   第三方账号登录  ---" TextFont:[UIFont systemFontOfSize:14] TextColor:UIColor.whiteColor NumberOfLines:1 TextAlignment:NSTextAlignmentCenter BackgroundColor:nil AdjustFitWidth:YES];
    tipTitle.center = CGPointMake(self.view.width / 2, self.registerBtn.bottomPosition + Layout(25) + 10);
    tipTitle.bounds = CGRectMake(0, 0, self.view.width - Layout(30) * 2, 20);
    [self.view addSubview:tipTitle];
    
    
    
    
    // 三方
    
    self.weChat = [UIButton buttonWithType:UIButtonTypeCustom];
   
    self.weChat.center = CGPointMake(self.view.width / 4, Layout(90 / 2) + tipTitle.bottomPosition);
    self.weChat.bounds = CGRectMake(0, 0, 45, 45);
    [self.weChat setImage:[UIImage imageNamed:@"log_wechat_n"] forState:UIControlStateNormal];
    [self.view addSubview:self.weChat];
    [[self.weChat rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [x.rac_command execute:nil];
    }];
    
    
    self.sina = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.sina.center = CGPointMake(self.view.width / 2, Layout(90 / 2) + tipTitle.bottomPosition);
    self.sina.bounds = CGRectMake(0, 0, 45, 45);
    [self.sina setImage:[UIImage imageNamed:@"log_sina_n"] forState:UIControlStateNormal];
    [self.view addSubview:self.sina];
    [[self.sina rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        [x.rac_command execute:nil];
    }];
    
    
    UIButton *psw = [UIButton buttonWithType:UIButtonTypeCustom];
    psw.center = CGPointMake(self.view.width * 3 / 4, Layout(90 / 2) + tipTitle.bottomPosition);
    psw.bounds = CGRectMake(0, 0, 45, 45);
    [psw setImage:[UIImage imageNamed:@"log_captcha_n"] forState:UIControlStateNormal];
    [self.view addSubview:psw];
    [[psw rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        
    }];
    
     // back
    
//    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
//    back.center = CGPointMake(self.view.width / 2, Layout(145 / 2.0) + sina.bottomPosition);
//    back.bounds = CGRectMake(0, 0, 122 / 2, 122 / 2);
//    [back setImage:[UIImage imageNamed:@"log_back_n"] forState:UIControlStateNormal];
//    [self.view addSubview:back];
//    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//    }];
    
    
    
}

- (void)bindViewModel {
    RAC(self.viewModel,phone) = self.phoneTF.rac_textSignal;
    RAC(self.viewModel,code) = self.codeTF.rac_textSignal;
    
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    [self.loginBtn.rac_command.executionSignals.switchToLatest subscribeNext:^(RACSignal<id> * _Nullable x) {
        NSLog(@"xxx     %@",x );

    }];
  
    [self.loginBtn.rac_command.errors subscribeNext:^(NSError * _Nullable x) {
        if (x.domain.length) {
        ShowMessage(x.domain);
        }
    }];
    
    self.weChat.rac_command = self.viewModel.weChatCommand;
    
    [self.weChat.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        // TODO: 绑定手机页面
    }];
    
    self.sina.rac_command = self.viewModel.sinaCommand;
    [self.sina.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        // TODO: 绑定手机页面
    }];
}

@end
