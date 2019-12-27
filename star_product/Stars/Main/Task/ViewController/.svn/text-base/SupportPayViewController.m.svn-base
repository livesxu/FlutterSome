//
//  SupportPayViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/25.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "SupportPayViewController.h"

#import "TaskScrollModel.h"

@interface SupportPayViewController ()

@property (nonatomic, strong) SupportTaskModel *model;

@end

@implementation SupportPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    self.view.backgroundColor = Colorfff;
}

/**
 加载数据
 */
- (void)loadData;{
    
    _model = self.lx_stores(nil);
    
    self.title = _model.supportTitle;
    
    UIView *viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, kNaviH, kScreenWidth, Layout(1))];
    viewLine1.backgroundColor = ColorLineW;
    [self.view addSubview:viewLine1];
    
    UIImageView *payShowImg = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(viewLine1.frame) + Layout(20), Layout(130), Layout(110))];
    
    [payShowImg yy_setImageWithURL:[NSURL URLWithString:_model.partPayShowImgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    [self.view addSubview:payShowImg];
    
    UILabel *title = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(payShowImg.frame) + Layout(20), CGRectGetMinY(payShowImg.frame) + Layout(10), Layout(390/2), Layout(50)) Text:_model.supportTitle TextFont:Font(18) TextColor:Color555];
    title.numberOfLines = 2;
    
    [self.view addSubview:title];
    
    UILabel *part_lb = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(payShowImg.frame) + Layout(20), CGRectGetMaxY(title.frame) + Layout(10), Layout(390/2), Layout(20)) Text:[NSString stringWithFormat:@"%@%@",_model.partDiamond,_model.supportUnit] TextFont:Font(18) TextColor:mainColor];
    
    NSMutableAttributedString *msPart = [[NSMutableAttributedString alloc]initWithString:part_lb.text];
    [msPart addAttributes:@{NSFontAttributeName:Font(13)} range:NSMakeRange(part_lb.text.length-2, 2)];
    part_lb.attributedText = msPart;
    
    [self.view addSubview:part_lb];
    
    UIView *viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viewLine1.frame) + Layout(150), kScreenWidth, Layout(1))];
    viewLine2.backgroundColor = ColorLineN;
    [self.view addSubview:viewLine2];
    
    UILabel *numTip = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(viewLine2.frame), Layout(100), Layout(60)) Text:@"购买数量" TextFont:Font(18) TextColor:Color555];
    [self.view addSubview:numTip];
    
    UIButton *reduceBtn = [UIButton buttonWithNomalFrame:CGRectMake(kScreenWidth  - Layout(210/2), CGRectGetMaxY(viewLine2.frame) + Layout(20), Layout(20), Layout(20)) Title:@"-" TitleFont:Font(20) TitleColor:Color666 BackgroundColor:nil];
    [reduceBtn setRadius:0 borderWidth:Layout(1) borderColor:Color666];
    [self.view addSubview:reduceBtn];
    
    UIButton *addBtn = [UIButton buttonWithNomalFrame:CGRectMake(kScreenWidth  - Layout(70/2), CGRectGetMaxY(viewLine2.frame) + Layout(20), Layout(20), Layout(20)) Title:@"+" TitleFont:Font(20) TitleColor:Color666 BackgroundColor:nil];
    [addBtn setRadius:0 borderWidth:Layout(1) borderColor:Color666];
    [self.view addSubview:addBtn];
    
    UILabel *num_lb = [UILabel labelWithFrame:CGRectMake(kScreenWidth  - Layout(170/2), CGRectGetMaxY(viewLine2.frame) + Layout(20), Layout(50), Layout(20)) Text:@"1" TextFont:Font(16) TextColor:Color333];
    num_lb.textAlignment = NSTextAlignmentCenter;
    num_lb.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:num_lb];
    
    UIView *viewLine3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viewLine2.frame) + Layout(60), kScreenWidth, Layout(1))];
    viewLine3.backgroundColor = ColorLineN;
    [self.view addSubview:viewLine3];
    
    UILabel *totalTip = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(viewLine3.frame), Layout(100), Layout(60)) Text:@"总金额" TextFont:Font(18) TextColor:Color555];
    [self.view addSubview:totalTip];
    
    UILabel *totalPay = [UILabel labelWithFrame:CGRectMake(kScreenWidth - Layout(15) - Layout(200), CGRectGetMaxY(viewLine3.frame), Layout(200), Layout(60)) Text:[NSString stringWithFormat:@"%@ %@",[NSString multiplyCalculate:_model.partDiamond With:num_lb.text],_model.supportUnit] TextFont:Font(18) TextColor:Color555];
    totalPay.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:totalPay];

    UIView *viewLine4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(viewLine3.frame) + Layout(60), kScreenWidth, Layout(1))];
    viewLine4.backgroundColor = ColorLineN;
    [self.view addSubview:viewLine4];
    
    __weak UILabel *weaknum_lb = num_lb;
    __weak UILabel *weaktotalPay = totalPay;
    __weak typeof(self) weakSelf = self;
    //add
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (weaknum_lb.text.integerValue < weakSelf.model.partMaxLeft.integerValue) {
            
            weaknum_lb.text = [NSString addCalculate:weaknum_lb.text With:@"1"];
            weaktotalPay.text = [NSString stringWithFormat:@"%@ %@",[NSString multiplyCalculate:weakSelf.model.partDiamond With:weaknum_lb.text],weakSelf.model.supportUnit];
        } else {
            
            ShowMessage(@"达到最多支持值啦");
        }
    }];
    
    //reduce
    [[reduceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (weaknum_lb.text.integerValue > 1) {
            
            weaknum_lb.text = [NSString subtractCalculate:weaknum_lb.text With:@"1"];
            weaktotalPay.text = [NSString stringWithFormat:@"%@ %@",[NSString multiplyCalculate:weakSelf.model.partDiamond With:weaknum_lb.text],weakSelf.model.supportUnit];
        } else {
            
            ShowMessage(@"最少支持一份");
        }
    }];
    
    UIButton *sureBtn = [UIButton buttonWithNomalFrame:CGRectMake(Layout(15), CGRectGetMaxY(viewLine4.frame) + Layout(75), kScreenWidth - Layout(30), Layout(50)) Title:@"确认购买" TitleFont:BoldFont(16) TitleColor:Colorfff BackgroundColor:mainColor];
    [sureBtn setClearRadius:Layout(3)];
    
    [self.view addSubview:sureBtn];
    
    //sure
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        //请求 - 成功 回调
        weakSelf.lx_stores(weaknum_lb.text);
        [weakSelf back];
    }];
    
}
#pragma mark - Change Values


#pragma mark - Delegate


#pragma mark - Lazy load


@end
