//
//  RuleViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/21.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "RuleViewController.h"

#import "LXPageViewController.h"

#import "CommonWebViewController.h"

#import "RuleViewModel.h"

@interface RuleViewController ()<LXPageDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LXPageViewController *topTitle;

@property (nonatomic, strong) CommonWebViewController *webView;

@property (nonatomic, strong) UITableView *starHistorys;

@property (nonatomic, strong) UIView *historyHeader;

@property (nonatomic, strong) RuleViewModel *viewModel;

@end

@implementation RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    [self addChildViewController:self.topTitle];
    [self.view addSubview:self.topTitle.view];
    
    [self addBack];
}

/**
 添加返回
 */
- (void)addBack{
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
    back.frame=CGRectMake(kNaviItemEdgeSpace, StateHeight + (Layout(44) - 22)/2, 22, 22);
    
    back.isOverStepTouch = YES;
    back.hitTestEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
}

/**
 加载数据
 */
- (void)loadData;{
    
    if (self.defIndex) {
        
        self.topTitle.currentIndex = self.defIndex.integerValue;
    } else {
        self.topTitle.currentIndex = 0;
    }
}
#pragma mark - Change Values

#pragma mark - Delegate

#pragma mark - LXPageDelegate
/**
 数据源
 
 @return 展示数据量
 */
- (NSInteger)numberOfPages;{
    
    return 2;
}
/**
 数据源
 @param index 下标
 @return page
 */
- (UIView *)lxPageIndex:(NSInteger)index;{
    
    __weak typeof(self) weakSelf = self;
    if (index == 0) {
        
        self.webView.urlString = @"http://www.baidu.com";
        
        [self addChildViewController:self.webView];
        return self.webView.view;
    } else if (index == 1) {
        
        [self.viewModel layoutRequestBackData:^(BOOL isSuccess) {
            
            [weakSelf.starHistorys reloadData];
        }];
        
        return self.starHistorys;
    }
    return nil;
}

/**
 数据头视图
 
 @param index 下标
 @param reusableCell 复用cell(基础cell)
 @return header
 */
- (PageTapCollectionCell *)lxPageTapsView:(NSInteger)index ReusableCell:(PageTapCollectionCell *)reusableCell;{
    
    reusableCell.contentView.backgroundColor = Colorfff;
    
    NSArray *titles = @[@"等级体系",@"历史星钻"];
    
    //自定义样式范例
    UILabel *label = [reusableCell.contentView viewWithTag:10002];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0,StateHeight, kScreenWidth/3, Layout(44))];
        label.textColor = Color333;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10002;
        [reusableCell.contentView addSubview:label];
    }
    label.text = titles[index];
    
    return reusableCell;
}

/**
 数据头视图大小
 
 @param index 下标
 @return size
 */
- (CGSize)lxPageTapSizeAtIndex:(NSInteger)index;{
    
    return CGSizeMake(kScreenWidth/3, StateHeight + Layout(44));
}

/**
 指示器view
 
 @return 指示器view
 */
- (UIView *)lxPageIndicator;{
    
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Layout(40), Layout(3))];
    viewLine.backgroundColor = mainColor;
    return viewLine;
}

/**
 标签栏在未超过一屏幕情况下居中排布
 
 @return 是否居中排布,默认NO
 */
- (BOOL)lxPageTapsWithinScreenAlignmentCenter;{
    
    return YES;
}

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //分割线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(1))];
        line.backgroundColor = ColorLineN;
        [cell.contentView addSubview:line];
        
        UILabel *source_lb = [UILabel labelWithFrame:CGRectMake(Layout(15), Layout(18), Layout(260), Layout(25)) Text:@"" TextFont:Font(16) TextColor:Color555];
        source_lb.tag = 1001;
        [cell.contentView addSubview:source_lb];
        
        UILabel *time_lb = [UILabel labelWithFrame:CGRectMake(Layout(15), Layout(42), Layout(260), Layout(18)) Text:@"" TextFont:Font(12) TextColor:Color999];
        time_lb.tag = 1002;
        [cell.contentView addSubview:time_lb];
        
        UILabel *change_lb = [UILabel labelWithFrame:CGRectMake(Layout(580/2), Layout(18), Layout(70), Layout(30)) Text:@"" TextFont:Font(16) TextColor:Color555];
        change_lb.tag = 1003;
        [cell.contentView addSubview:change_lb];
    }
    
    HistoryDiamondModel *model = self.viewModel.dataArray[indexPath.row];
    
    UILabel *source_lb = [cell.contentView viewWithTag:1001];
    UILabel *time_lb = [cell.contentView viewWithTag:1002];
    UILabel *change_lb = [cell.contentView viewWithTag:1003];
    source_lb.text = model.source;
    time_lb.text = model.time;
    change_lb.text = model.change;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return Layout(70);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return self.historyHeader.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.historyHeader;
}

#pragma mark - Lazy load

- (LXPageViewController *)topTitle {
    
    if (!_topTitle) {
        
        _topTitle = [[LXPageViewController alloc]initWithFrame:self.view.bounds Delegate:self];
    }
    return _topTitle;
}

- (CommonWebViewController *)webView {
    
    if (!_webView) {
        
        _webView = [[CommonWebViewController alloc]init];
        
        UIView *web = [_webView valueForKey:@"webView"];
        web.y = 0;
        UIView *progress = [_webView valueForKey:@"progressView"];
        progress.y = 0;
        
    }
    return _webView;
}

- (UITableView *)starHistorys{
    if (!_starHistorys) {
        _starHistorys=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _starHistorys.delegate = self;
        _starHistorys.dataSource = self;
        _starHistorys.showsHorizontalScrollIndicator = NO;
        _starHistorys.showsVerticalScrollIndicator  = NO;
        _starHistorys.separatorStyle = UITableViewCellSeparatorStyleNone;
        _starHistorys.backgroundColor = pageColor;
    }
    return _starHistorys;
}

- (UIView *)historyHeader {
    
    if (!_historyHeader) {
        
        _historyHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(380/2))];
        CGFloat height = _historyHeader.height;
        
        UIImageView *diamond_bg = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(15), Layout(10), kScreenWidth - Layout(30), Layout(170))];
        diamond_bg.image = Image(@"historydiamond_bg");
        [_historyHeader addSubview:diamond_bg];
        
        UILabel *starsTip = [UILabel labelWithFrame:CGRectMake(Layout(45), Layout(45), Layout(300), Layout(20)) Text:@"我的星钻总额" TextFont:BoldFont(16) TextColor:Colorfff];
        
        UILabel *starsNumber = [UILabel labelWithFrame:CGRectMake(Layout(45), Layout(95), Layout(170), Layout(30)) Text:@"0 星钻" TextFont:BoldFont(16) TextColor:Colorfff];
        starsNumber.tag = 1001;
        
        UIButton *starsChange = [UIButton buttonWithNomalFrame:CGRectMake(Layout(220), Layout(95), Layout(100), Layout(30)) Title:@"立即兑换" TitleFont:BoldFont(14) TitleColor:Colorfff BackgroundColor:[UIColor colorWithWhite:1 alpha:.3]];
        [starsChange setClearRadius:Layout(15)];
        
        [[starsChange rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            LXRouteMap(@"star://MarketViewController.push");
        }];
        
        [_historyHeader addSubview:starsTip];
        [_historyHeader addSubview:starsNumber];
        [_historyHeader addSubview:starsChange];
        
        UIView *titleHold = [[UIView alloc]initWithFrame:CGRectMake(0, Layout(190), kScreenWidth, 0)];
        titleHold.backgroundColor = Colorfff;
        
        UILabel *labelTitle1 = [UILabel labelWithFrame:CGRectMake(Layout(15), Layout(15), Layout(345), Layout(20)) Text:@"星钻：星app中的互动奖励" TextFont:Font(16) TextColor:Color484848];
        
        NSString *text1 = @"星钻产生于用户在星APP的互动，可用于兑换周边参与活动等。星钻的总量将不会超过2.7亿。星钻生成的数量成几何减少，每两年减少50%，前期参与优势更大。";
        CGFloat height1 = [text1 boundingRectWithSize:CGSizeMake(Layout(345), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)}context:nil].size.height;
        UILabel *label1 = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(labelTitle1.frame) + Layout(5), Layout(345), height1) Text:text1 TextFont:Font(14) TextColor:Color666];
        label1.numberOfLines = 0;
        
        UILabel *labelTitle2 = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(label1.frame) + Layout(15), Layout(345), Layout(20)) Text:@"塔可：获取的塔可越多，星钻奖励越高" TextFont:Font(16) TextColor:Color484848];
        
        NSString *text2 = @"用户通过完成任务、发布内容、圈内活动获取塔可。每日的星钻奖励与当日获得的塔可数直接挂钩。";
        CGFloat height2 = [text2 boundingRectWithSize:CGSizeMake(Layout(345), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)}context:nil].size.height;
        UILabel *label2 = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(labelTitle2.frame) + Layout(5), Layout(345), height2) Text:text2 TextFont:Font(14) TextColor:Color666];
        label2.numberOfLines = 0;
        
        UILabel *labelTitle3 = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(label2.frame) + Layout(15), Layout(345), Layout(20)) Text:@"计算公式：" TextFont:Font(16) TextColor:Color666];
        
        NSString *text3 = @"用户当日星钻奖励=当日星钻产量*当日赚取的塔可值/当日社区总的塔可值";
        CGFloat height3 = [text3 boundingRectWithSize:CGSizeMake(Layout(345), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)}context:nil].size.height;
        UILabel *label3 = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(labelTitle3.frame) + Layout(5), Layout(345), height3) Text:text3 TextFont:Font(14) TextColor:Color666];
        label3.numberOfLines = 0;
        
        UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label3.frame) + Layout(20), kScreenWidth, Layout(10))];
        viewLine.backgroundColor = pageColor;
        
        UILabel *historyTip = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(viewLine.frame), kScreenWidth - Layout(15), Layout(50)) Text:@"历史记录" TextFont:Font(18) TextColor:Color333];
        
        titleHold.height = CGRectGetMaxY(historyTip.frame);
        
        [titleHold addSubview:labelTitle1];
        [titleHold addSubview:label1];
        [titleHold addSubview:labelTitle2];
        [titleHold addSubview:label2];
        [titleHold addSubview:labelTitle3];
        [titleHold addSubview:label3];
        [titleHold addSubview:viewLine];
        [titleHold addSubview:historyTip];
        
        [_historyHeader addSubview:titleHold];
        
        _historyHeader.height = height + titleHold.height;
        
    }
    return _historyHeader;
}

- (RuleViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[RuleViewModel alloc]init];
    }
    return _viewModel;
}

@end
