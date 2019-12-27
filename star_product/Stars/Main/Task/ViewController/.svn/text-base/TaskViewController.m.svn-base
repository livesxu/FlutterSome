//
//  TaskViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "TaskViewController.h"

#import "LXScrollLoopViewController.h"

#import "LXPageViewController.h"

#import "TaskViewModel.h"

#import "DayTaskTableViewCell.h"
#import "SupportTaskTableViewCell.h"

@interface TaskViewController ()<LXScrollDelegate,LXPageDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LXScrollLoopViewController *topScroll;

@property (nonatomic, strong) LXPageViewController *topTitle;

@property (nonatomic, strong) TaskViewModel *viewModel;

@property (nonatomic, strong) UITableView *dayTaskTable;

@property (nonatomic, strong) UITableView *supportTaskTable;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    self.title = @"任务";
    
    [self addChildViewController:self.topScroll];
    [self.view addSubview:self.topScroll.view];
    
    [self addChildViewController:self.topTitle];
    [self.view addSubview:self.topTitle.view];
    
    
}

/**
 加载数据
 */
- (void)loadData;{
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel layoutRequestBackData:^(BOOL isSuccess) {
        
        [weakSelf.topScroll reloadData];
    }];
    
    if (self.defIndex) {
        
        self.topTitle.currentIndex = self.defIndex.integerValue;
    } else {
        self.topTitle.currentIndex = 0;
    }
}

#pragma mark - Change Values

#pragma mark - Delegate

#pragma mark - LXScrollDelegate
/**
 数据源
 
 @return 展示数据量
 */
- (NSInteger)numberOfItemWithScroll;{
    
    return self.viewModel.dataArray.count;
}
/**
 数据源
 
 @param index 下标
 @param reusableCell 复用cell(基础cell)
 @return 使用cell
 */
- (ScrollCollectionCell *)lxScrollIndex:(NSInteger)index ReusableCell:(ScrollCollectionCell *)reusableCell;{
    
    TaskScrollModel *model = self.viewModel.dataArray[index];
    
    [reusableCell.imageView yy_setImageWithURL:[NSURL URLWithString:model.imgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    //自定义样式范例
    UILabel *label = [reusableCell.contentView viewWithTag:10001];
    if (!label) {
        label= [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];
        label.tag = 10001;
        [reusableCell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"第%ld张图片",index];
    
    return reusableCell;
}

/**
 滚动到index
 
 @param index 下标
 */
- (void)lxScrollDidScrollIndex:(NSInteger)index;{
    
}
/**
 点击事件
 
 @param index 下标
 */
- (void)lxScrollSelectIndex:(NSInteger)index;{
    
}
/**
 轮播间隔时间
 
 @return 间隔时间
 */
- (NSTimeInterval)timeIntervalWithLoop;{
    
    return 5;
}

#pragma mark - LXPageDelegate
/**
 数据源
 
 @return 展示数据量
 */
- (NSInteger)numberOfPages;{
    
    return 4;
}
/**
 数据源
 @param index 下标
 @return page
 */
- (UIView *)lxPageIndex:(NSInteger)index;{
    
    __weak typeof(self) weakSelf = self;
    if (index == 0) {
        
        [self.viewModel layoutDayTaskRequest:^(BOOL isSuccess) {
            
            [weakSelf.dayTaskTable reloadData];
        }];
        return self.dayTaskTable;
    } else if (index == 1) {
        
        [self.viewModel layoutSupportTaskRequest:^(BOOL isSuccess) {
            
            [weakSelf.supportTaskTable reloadData];
        }];
        return self.supportTaskTable;
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
    
    NSArray *titles = @[@"做每日",@"跑应援",@"兑周边",@"看规则"];
    NSArray *imgs = @[@"task_dailytask_n",@"task_support_n",@"task_market_n",@"task_rule_n"];
    
    UIImageView *imgView = [reusableCell.contentView viewWithTag:10001];
    if (!imgView) {
        
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/4 - Layout(30))/2, Layout(15), Layout(30), Layout(30))];
        imgView.tag = 10001;
        [reusableCell.contentView addSubview:imgView];
    }
    
    //自定义样式范例
    UILabel *label = [reusableCell.contentView viewWithTag:10002];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, Layout(55), kScreenWidth/4, Layout(25))];
        label.textColor = Color333;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10002;
        [reusableCell.contentView addSubview:label];
    }
    imgView.image = Image(imgs[index]);
    label.text = titles[index];
    
    return reusableCell;
}

/**
 数据头视图大小
 
 @param index 下标
 @return size
 */
- (CGSize)lxPageTapSizeAtIndex:(NSInteger)index;{
    
    return CGSizeMake(kScreenWidth/4, Layout(85));
}

/**
 指示器view
 
 @return 指示器view
 */
- (UIView *)lxPageIndicator;{
    
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Layout(30), Layout(3))];
    viewLine.backgroundColor = mainColor;
    return viewLine;
}

/**
 是否可滚动到index - 默认YES
 @param index index
 @return 是否可滚动到index
 */
- (BOOL)lxPageShouldScrollIndex:(NSInteger)index;{
    
    if (index == 2 || index == 3) {
        
        if (index == 2) {
            
            LXRouteMap(@"star://MarketViewController.push");
        }
        if (index == 3) {
            
            LXRouteMap(@"star://RuleViewController.push");
        }
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.dayTaskTable) {
        
        return self.viewModel.dayTaskArray.count;
    } else if (tableView == self.supportTaskTable) {
        
        return self.viewModel.supportTaskArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.dayTaskTable) {
        
        DayTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DayTaskTableViewCell class])];
        
        if (!cell) {
            
            cell = [[DayTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([DayTaskTableViewCell class])];
        }
        //赋值
        cell.model = self.viewModel.dayTaskArray[indexPath.section];
        
        return cell;
        
    } else if (tableView == self.supportTaskTable) {
        
        SupportTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SupportTaskTableViewCell class])];
        
        if (!cell) {
            
            cell = [[SupportTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SupportTaskTableViewCell class])];
        }
        //赋值
        cell.model = self.viewModel.supportTaskArray[indexPath.section];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.dayTaskTable) {
        
        return Layout(70);
    } else if (tableView == self.supportTaskTable) {
        
        return Layout(310);
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.dayTaskTable) {
        
        DayTaskModel *model = self.viewModel.dayTaskArray[indexPath.section];
        
        LXRouteMap(model.link);
        
    } else if (tableView == self.supportTaskTable) {
        
        SupportTaskModel *model = self.viewModel.supportTaskArray[indexPath.section];
        
        LXRouteMap([NSString stringWithFormat:@"star://SupportDetailViewController.push?supportId=%@",model.supportId]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return Layout(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc]init];
}


#pragma mark - Lazy load

- (LXScrollLoopViewController *)topScroll {
    
    if (!_topScroll) {
        
        _topScroll = [[LXScrollLoopViewController alloc]initWithFrame:CGRectMake(0, kNaviH, kScreenWidth, Layout(170)) Delegate:self];
    }
    return _topScroll;
}

- (TaskViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[TaskViewModel alloc]init];
    }
    return _viewModel;
}

- (LXPageViewController *)topTitle {
    
    if (!_topTitle) {
        
        _topTitle = [[LXPageViewController alloc]initWithFrame:CGRectMake(0, self.topScroll.view.bottomPosition, kScreenWidth, kScreenHeight - self.topScroll.view.bottomPosition - self.tabBarController.tabBar.height) Delegate:self];
    }
    return _topTitle;
}

#pragma mark - lazyTable
- (UITableView *)dayTaskTable{
    if (!_dayTaskTable) {
        _dayTaskTable=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _dayTaskTable.delegate = self;
        _dayTaskTable.dataSource = self;
        _dayTaskTable.showsHorizontalScrollIndicator = NO;
        _dayTaskTable.showsVerticalScrollIndicator  = NO;
        _dayTaskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dayTaskTable.backgroundColor = pageColor;
    }
    return _dayTaskTable;
}

- (UITableView *)supportTaskTable{
    if (!_supportTaskTable) {
        _supportTaskTable=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _supportTaskTable.delegate = self;
        _supportTaskTable.dataSource = self;
        _supportTaskTable.showsHorizontalScrollIndicator = NO;
        _supportTaskTable.showsVerticalScrollIndicator  = NO;
        _supportTaskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _supportTaskTable.backgroundColor = pageColor;
    }
    return _supportTaskTable;
}


@end
