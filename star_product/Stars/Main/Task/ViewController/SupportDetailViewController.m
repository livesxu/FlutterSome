//
//  SupportDetailViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/25.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "SupportDetailViewController.h"

#import "SupportDetailViewModel.h"

#import "SupportTaskTableViewCell.h"

#import "CommonWebTableViewCell.h"

@interface SupportDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SupportDetailViewModel *viewModel;

@property (nonatomic, strong) UITableView *listTable;

@property (nonatomic, strong) UIButton *supportBtn;

@property (nonatomic, assign) CGFloat detailHeight;

@end

@implementation SupportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    self.title = @"应援详情";
    [self.view addSubview:self.listTable];
    
    [self.view addSubview:self.supportBtn];
    
}

/**
 加载数据
 */
- (void)loadData;{
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel layoutRequestBackData:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            [weakSelf.listTable reloadData];
            [weakSelf judgeSupport];
            [weakSelf addShare];
            
        } else {
            
            
        }
    }];
}

#pragma mark - Change Values

- (void)addShare {
    
    UIButton *shareBtn = [UIButton buttonWithNomalFrame:CGRectMake(0, 0, 22, 22) Image:Image(@"nav_share_black_n")];
    [self.naviStand addSubview:shareBtn];
    [self.naviStand.rightButtons addObject:shareBtn];
    
    [[shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
//        [[MobManager manager] showShareActionSheetWithUrlString:@"http://xclient.info/a/?t=0b6b04c3513140c5e85f6586542dfcc748ac5e5e" title:@"XclientInfo" images:nil content:@"分享测试" shareType:@1];
    }];
}

- (void)judgeSupport {
    
    if ([_viewModel.model.partType isEqual:@"1"]) {//固定金额
        
        if ([_viewModel.model.partFlag isEqual:@"1"]) {//已参与过
            
            self.supportBtn.backgroundColor = Colorccc;
            [self.supportBtn setTitle:@"已参与" forState:UIControlStateNormal];
            self.supportBtn.userInteractionEnabled = NO;
        }
        
    } else if ([_viewModel.model.partType isEqual:@"2"]) {//非固定金额
        
        if ([_viewModel.model.partFlag isEqual:@"1"]) {//已参与过
            
            if (_viewModel.model.partMaxLeft.integerValue > 0) {
                
                [self.supportBtn setTitle:@"继续支持" forState:UIControlStateNormal];
            } else {
                self.supportBtn.backgroundColor = Colorccc;
                [self.supportBtn setTitle:@"已参与" forState:UIControlStateNormal];
                self.supportBtn.userInteractionEnabled = NO;
            }
            
        }
    }
}

- (void)supportAction {
    
    if ([_viewModel.model.partType isEqual:@"1"] && [_viewModel.model.partFlag isEqual:@"0"]) {//固定金额 && 未参与
        
        LXAlertBlockTips *alert = [[LXAlertBlockTips alloc]init];
        alert.isIgnoreClose = YES;
        __weak typeof(self) weakSelf = self;
        __weak LXAlertBlockTips *weakAlert = alert;
        [alert configWithTitle:@"请输入密码" ClickTitles:@[@"取消",@"确定"] Config:^UIView *{
            
            UIView *viewHold = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Layout(270), Layout(70))];
            
            UILabel *labelTip = [UILabel labelWithFrame:CGRectMake(0, Layout(10), Layout(270), Layout(20)) Text:[NSString stringWithFormat:@"您将花费%@%@兑换该商品",weakSelf.viewModel.model.partDiamond,weakSelf.viewModel.model.supportUnit] TextFont:Font(14) TextColor:Color333];
            labelTip.textAlignment = NSTextAlignmentCenter;
            [viewHold addSubview:labelTip];
            
            UITextField *passwordIn = [[UITextField alloc]initWithFrame:CGRectMake(Layout(35), Layout(40), Layout(200), Layout(25))];
            [passwordIn setRadius:Layout(2) borderWidth:1 borderColor:Color333];
            [viewHold addSubview:passwordIn];
            
            return viewHold;
            
        } ClickAction:^(NSInteger index) {
            
            if (index == 0) {
                
                [weakAlert dismiss];
            } else {
                
                NSLog(@"Sure");
                //请求验证 - 成功
                ShowMessage(@"应援成功");
                [weakAlert dismiss];
                weakSelf.viewModel.model.partFlag = @"1";
                [weakSelf judgeSupport];
            }
        }];
        
        [alert show];
        
    } else if ([_viewModel.model.partType isEqual:@"2"]) {//非固定金额
        
        __weak typeof(self) weakSelf = self;
        [[LXRouter shareRouter] routeStore:@"SupportPayViewController" stores:^id _Nullable(id  _Nullable backInfo) {
            
            if (backInfo) {//成功回调
                
                NSString *sureNum = backInfo;
                weakSelf.viewModel.model.partFlag = @"1";
                weakSelf.viewModel.model.partMaxLeft = [NSString subtractCalculate:weakSelf.viewModel.model.partMaxLeft With:sureNum];
                [weakSelf judgeSupport];
                
                return nil;
            }
            
            return weakSelf.viewModel.model;
        }];
        LXRouteMap(@"star://SupportPayViewController.push");
    }
}

#pragma mark - Delegate

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SupportTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SupportTaskTableViewCell class])];
        
        if (!cell) {
            
            cell = [[SupportTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SupportTaskTableViewCell class])];
        }
        //赋值
        cell.model = self.viewModel.model;
        
        return cell;
    } else {
        
        CommonWebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommonWebTableViewCell class])];
        
        if (!cell) {
            
            cell = [[CommonWebTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CommonWebTableViewCell class])];
        }
        //赋值
        cell.url = self.viewModel.model.detailUrl;
        __weak typeof(self) weakSelf = self;
        cell.webHeight = ^(CGFloat height) {
            
            weakSelf.detailHeight = height;
            
            [weakSelf.listTable reloadData];
        };
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return Layout(310);
    } else {
        
        return self.detailHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return [[UIView alloc]init];
    }
    
    UIView *viewHold = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(55))];
    viewHold.backgroundColor = Colorfff;
    
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(10))];
    viewLine.backgroundColor = pageColor;
    [viewHold addSubview:viewLine];
    
    UILabel *labelTip = [UILabel labelWithFrame:CGRectMake(Layout(15), Layout(10), kScreenWidth - Layout(15), Layout(45)) Text:@"应援详情" TextFont:Font(14) TextColor:Color333];
    [viewHold addSubview:labelTip];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Layout(54), kScreenWidth, Layout(1))];
    line.backgroundColor = ColorLineN;
    [viewHold addSubview:line];
    
    return viewHold;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return .01f;
    }
    
    return Layout(55);
}

#pragma mark - Lazy load

#pragma mark - lazy viewModel
- (SupportDetailViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel=[[SupportDetailViewModel alloc]init];
        _viewModel.supportId = _supportId;
    }
    return _viewModel;
}

#pragma mark - lazyTable
- (UITableView *)listTable{
    if (!_listTable) {
        _listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, kNaviH, kScreenWidth, kScreenHeight - kNaviH - Layout(50)) style:UITableViewStylePlain];
        
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.showsHorizontalScrollIndicator = NO;
        _listTable.showsVerticalScrollIndicator  = NO;
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTable.backgroundColor=pageColor;
        
    }
    return _listTable;
}

- (UIButton *)supportBtn {
    
    if (!_supportBtn) {
        
        _supportBtn = [UIButton buttonWithNomalFrame:CGRectMake(0, kScreenHeight - Layout(50), kScreenWidth, Layout(50)) Title:@"我要支持" TitleFont:BoldFont(14) TitleColor:Colorfff BackgroundColor:mainColor];
        
        [_supportBtn addTarget:self action:@selector(supportAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _supportBtn;
}

@end
