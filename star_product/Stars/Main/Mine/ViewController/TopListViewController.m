//
//  TopListViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/27.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "TopListViewController.h"

#import "TopListViewModel.h"

#import "StarsListModel.h"

@interface TopListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TopListViewModel *viewModel;

@property (nonatomic, strong) UIImageView *topShow;

@property (nonatomic, strong) UITableView *listTable;

@end

@implementation TopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    self.title = @"星榜单";
    
    [self.view insertSubview:self.topShow belowSubview:self.naviStand];
    [self.view addSubview:self.listTable];
    
    [self addShareAndChange];
}

/**
 加载数据
 */
- (void)loadData;{
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel layoutRequestBackData:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            [weakSelf layoutTop];
            [weakSelf.listTable reloadData];
            
        } else {
            
            
        }
    }];
}

- (void)layoutTop {
    
    for (StarsListModel *model in self.viewModel.topRankArray) {
        
        [self topRank:model];
    }
}

#pragma mark - Change Values
- (void)addShareAndChange {
    
    self.naviStand.backgroundColor = ColorClear;
    
    UIButton *back = [self.naviStand viewWithTag:1002];
    [back setImage:[UIImage imageNamed:@"nav_back_white_n"] forState:UIControlStateNormal];
    UILabel *titleLabel = [self.naviStand viewWithTag:1001];
    titleLabel.textColor = Colorfff;
    
    UIButton *shareBtn = [UIButton buttonWithNomalFrame:CGRectMake(0, 0, 22, 22) Image:Image(@"nav_share_white_n")];
    [self.naviStand addSubview:shareBtn];
    [self.naviStand.rightButtons addObject:shareBtn];
    
    [[shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        
//        [[MobManager manager] showShareActionSheetWithUrlString:@"http://xclient.info/a/?t=0b6b04c3513140c5e85f6586542dfcc748ac5e5e" title:@"XclientInfo" images:nil content:@"分享测试" shareType:@1];
    }];
}

- (void)topRank:(StarsListModel *)model {
    
    UIImageViewTouch *hold = [[UIImageViewTouch alloc]initWithFrame:CGRectMake(0, 0, Layout(172/2), Layout(300/2))];
    
    
    
    UIImageView *headerImg = [[UIImageView alloc]init];
    [headerImg yy_setImageWithURL:[NSURL URLWithString:model.starImgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    [hold addSubview:headerImg];
    
    UIImageView *rankImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"list_star_%@_n",model.starRank]]];
    rankImg.frame = CGRectMake((hold.width - Layout(30))/2, Layout(140/2), Layout(30), Layout(30));
    [hold addSubview:rankImg];
    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, Layout(216/2), Layout(172/2), Layout(20)) Text:model.starName TextFont:BoldFont(16) TextColor:Colorfff NumberOfLines:1 TextAlignment:NSTextAlignmentCenter BackgroundColor:ColorClear AdjustFitWidth:YES];
    
    [hold addSubview:nameLabel];
    
    UILabel *standingLabel = [UILabel labelWithFrame:CGRectMake(0, nameLabel.bottomPosition + Layout(5), Layout(172/2), Layout(15)) Text:[NSString stringWithFormat:@"积分：%@",model.starStanding] TextFont:Font(12) TextColor:Colorfff NumberOfLines:1 TextAlignment:NSTextAlignmentCenter BackgroundColor:ColorClear AdjustFitWidth:YES];
    
    [hold addSubview:standingLabel];
    
    switch (model.starRank.integerValue) {
        case 1:
            hold.frame = CGRectMake((kScreenWidth - hold.width)/2, Layout(110/2), hold.width, hold.height);
            headerImg.frame = CGRectMake(0, 0, hold.width, hold.width);
            break;
        case 2:
            hold.frame = CGRectMake(Layout(536/2), Layout(186/2), hold.width, hold.height);
            headerImg.frame = CGRectMake(Layout(8), Layout(16), Layout(70), Layout(70));
            break;
        case 3:
            hold.frame = CGRectMake(Layout(30), Layout(186/2), hold.width, hold.height);
            headerImg.frame = CGRectMake(Layout(8), Layout(16), Layout(70), Layout(70));
            break;
            
        default:
            break;
    }
    
    [headerImg setRadius:headerImg.width/2 borderWidth:Layout(2) borderColor:Colorfff];
    
    [self.topShow addSubview:hold];
}

#pragma mark - Delegate

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *rank_lb = [UILabel labelWithFrame:CGRectMake(Layout(10), Layout(20), Layout(20), Layout(40)) Text:@"" TextFont:Font(16) TextColor:Color555];
        rank_lb.tag = 1001;
        [cell.contentView addSubview:rank_lb];
        
        UIImageView *headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(rank_lb.rightPosition + Layout(10), Layout(20), Layout(40), Layout(40))];
        [headerImg setClearRadius:Layout(20)];
        headerImg.tag = 1002;
        [cell.contentView addSubview:headerImg];
        
        UILabel *name_lb = [UILabel labelWithFrame:CGRectMake(headerImg.rightPosition + Layout(10), Layout(20), Layout(180), Layout(40)) Text:@"" TextFont:Font(16) TextColor:Color555];
        name_lb.tag = 1003;
        [cell.contentView addSubview:name_lb];
        
        UILabel *standing_lb = [UILabel labelWithFrame:CGRectMake(kScreenWidth - Layout(15) - Layout(90), Layout(20), Layout(90), Layout(40)) Text:@"" TextFont:Font(12) TextColor:Color777];
        standing_lb.textAlignment = NSTextAlignmentRight;
        standing_lb.adjustsFontSizeToFitWidth = YES;
        standing_lb.tag = 1004;
        [cell.contentView addSubview:standing_lb];
    }
    //赋值
    StarsListModel *model = self.viewModel.dataArray[indexPath.row];
    
    UILabel *rank_lb = [cell.contentView viewWithTag:1001];
    UIImageView *headerImg = [cell.contentView viewWithTag:1002];
    UILabel *name_lb = [cell.contentView viewWithTag:1003];
    UILabel *standing_lb = [cell.contentView viewWithTag:1004];
    
    rank_lb.text = model.starRank;
    [headerImg yy_setImageWithURL:[NSURL URLWithString:model.starImgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    name_lb.text = model.starName;
    standing_lb.text = [NSString stringWithFormat:@"%@ 积分",model.starStanding];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Layout(60);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - Lazy load

#pragma mark - lazy viewModel
- (TopListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel=[[TopListViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - lazyTable
- (UITableView *)listTable{
    if (!_listTable) {
        _listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, self.topShow.bottomPosition, kScreenWidth, kScreenHeight - self.topShow.bottomPosition) style:UITableViewStylePlain];
        
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.showsHorizontalScrollIndicator = NO;
        _listTable.showsVerticalScrollIndicator  = NO;
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTable.backgroundColor=pageColor;
        
    }
    return _listTable;
}

- (UIImageView *)topShow {
    
    if (!_topShow) {
        
        UIImageView *stateImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -StateHeight, kScreenWidth, StateHeight)];
        stateImg.image = Image(@"list_status_bg");
        
        _topShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, StateHeight, kScreenWidth, Layout(510/2))];
        _topShow.image = Image(@"list_bg");
        _topShow.userInteractionEnabled = YES;
        
        [_topShow addSubview:stateImg];
    }
    return _topShow;
}

@end
