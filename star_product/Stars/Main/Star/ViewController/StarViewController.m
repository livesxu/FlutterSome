//
//  StarViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "StarViewController.h"

#import "LXPageViewController.h"

#import "StarViewModel.h"

#import "StarInfoTableViewCell.h"

@interface StarViewController ()<LXPageDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *baseScroll;

@property (nonatomic, strong) UIImageView *topStar;

@property (nonatomic, strong) UIImageView *topItems;

@property (nonatomic, strong) LXPageViewController *topTitle;

@property (nonatomic, strong) StarViewModel *viewModel;

@property (nonatomic, strong) UITableView *newTable;

@property (nonatomic, strong) UITableView *hotTable;

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    [self.view addSubview:self.baseScroll];
    
    [self.baseScroll addSubview:self.topStar];
    [self.baseScroll addSubview:self.topItems];
    self.topItems.y = Layout(460/2);
    
    [self addChildViewController:self.topTitle];
    [self.baseScroll addSubview:self.topTitle.view];
    self.topTitle.view.y = self.topItems.bottomPosition;
    
    //
    self.naviStand.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    
    UIButton *toTopBtn = [UIButton buttonWithNomalFrame:CGRectMake(0, 0, Layout(40), Layout(18)) Title:@"打榜" TitleFont:BoldFont(14) TitleColor:Colorfff BackgroundColor:ColorClear];
    [self.naviStand addSubview:toTopBtn];
    [self.naviStand.rightButtons addObject:toTopBtn];
    
    [[toTopBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
    }];
    
    [self.naviStand bringToFront];
    self.naviStand.hidden = YES;
}

/**
 加载数据
 */
- (void)loadData;{
    
    if (!self.starId) {
        
        self.starId = @"0";
    }
    //    http://pic1.win4000.com/tj/2017-12-07/5a28b54584b99.jpg
    //    http://img.mp.itc.cn/upload/20170511/309bba9704a3446a833c0d1a45c18d56_th.jpg
    
    __weak typeof(self) weakSelf = self;
    [self.topStar yy_setImageWithURL:[NSURL URLWithString:@"http://img.mp.itc.cn/upload/20170511/309bba9704a3446a833c0d1a45c18d56_th.jpg"] placeholder:nil options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
        if (image) {
            weakSelf.topStar.height = kScreenWidth * image.size.height/image.size.width;
        }
    }];

}

#pragma mark - Change Values
- (void)setStarId:(NSString *)starId {
    
    if ([_starId isEqual:starId]) return;
    
    self.topTitle.currentIndex = 0;
}

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
        
        [self.viewModel newListRequest:^(BOOL isSuccess) {
            
            [weakSelf.newTable reloadData];
        }];

        return self.newTable;
    } else if (index == 1) {

        [self.viewModel hotListRequest:^(BOOL isSuccess) {

            [weakSelf.hotTable reloadData];
        }];
        return self.hotTable;
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
    
    NSArray *titles = @[@"最新发布",@"最热发布"];
    
    //自定义样式范例
    UILabel *label = [reusableCell.contentView viewWithTag:10002];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kScreenWidth/2, Layout(90/2))];
        label.textColor = Color333;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10002;
        [reusableCell.contentView addSubview:label];
    }
    label.text = titles[index];
    
    if (self.topTitle.currentIndex == index) {
        
        label.textColor = Color333;
    } else {
        label.textColor = Color777;
    }
    
    //分割线
    UIView *line = [reusableCell.contentView viewWithTag:10003];
    if (!line) {
        line = [[UIView alloc]initWithFrame:CGRectMake(0,Layout(90/2) - Layout(1), kScreenWidth/2, Layout(1))];
        line.backgroundColor = ColorLineN;
        line.tag = 10003;
        [reusableCell.contentView addSubview:line];
    }
    
    return reusableCell;
}

/**
 数据头视图大小
 
 @param index 下标
 @return size
 */
- (CGSize)lxPageTapSizeAtIndex:(NSInteger)index;{
    
    return CGSizeMake(kScreenWidth/2, Layout(90/2));
}

/**
 滚动到index
 @param index 下标
 */
- (void)lxPageDidScrollIndex:(NSInteger)index;{
    
    [self.topTitle reloadData];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.newTable) {
        
        return self.viewModel.latestArray.count;
    } else {
        return self.viewModel.hotArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StarInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StarInfoTableViewCell class])];
    if (!cell) {
        
        cell = [[StarInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([StarInfoTableViewCell class])];
    }
    StarInfoModel *model;
    if (tableView == self.newTable) {
        
        model = self.viewModel.latestArray[indexPath.row];
    } else {
        model = self.viewModel.hotArray[indexPath.row];
    }
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StarInfoModel *model;
    if (tableView == self.newTable) {
        
        model = self.viewModel.latestArray[indexPath.row];
    } else {
        model = self.viewModel.hotArray[indexPath.row];
    }
    return model.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.baseScroll) {
        
        if (scrollView.contentOffset.y <= self.topStar.height) {
            
            self.topStar.y = scrollView.contentOffset.y/2;
            
            self.topItems.hidden = self.topStar.bottomPosition > self.topItems.bottomPosition ? YES : NO;
        }
        self.naviStand.hidden = scrollView.contentOffset.y >= (self.topItems.bottomPosition - kNaviH) ? NO : YES;
        
    } else {
        
    }
}

#pragma mark - Lazy load

- (UIScrollView *)baseScroll {
    
    if (!_baseScroll) {
        
        _baseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.tabBarController.tabBar.height)];
        _baseScroll.contentSize=CGSizeMake(kScreenWidth, Layout(740/2) + self.topTitle.view.height);
        _baseScroll.delegate=self;
        _baseScroll.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _baseScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _baseScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    return _baseScroll;
}

- (UIImageView *)topStar {
    
    if (!_topStar) {
        
        _topStar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(500/2))];
        
    }
    return _topStar;
}

- (UIImageView *)topItems {
    
    if (!_topItems) {
        
        _topItems = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(140))];
        _topItems.userInteractionEnabled = YES;
        
        [_topItems setRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:Layout(6)];
        
        _topItems.image = [UIImage imageWithColor:Colorfff];
        
        UIImageViewTouch *item1 = [self touchItemWithImageName:@"star_support_n" Title:@"打榜" Desc:@"为你的idol攻城拔寨" Frame:CGRectMake(Layout(25), Layout(13), Layout(160), Layout(50))];
        
        UIImageViewTouch *item2 = [self touchItemWithImageName:@"star_market_n" Title:@"周边" Desc:@"创造更能代表你的爱" Frame:CGRectMake(Layout(410/2), Layout(13), Layout(160), Layout(50))];
        
        UIImageViewTouch *item3 = [self touchItemWithImageName:@"star_news_n" Title:@"动态" Desc:@"明星动态等你来发现" Frame:CGRectMake(Layout(25), Layout(70), Layout(160), Layout(50))];
        
        UIImageViewTouch *item4 = [self touchItemWithImageName:@"star_treehole_n" Title:@"树洞" Desc:@"畅所欲言成为可能" Frame:CGRectMake(Layout(410/2), Layout(70), Layout(160), Layout(50))];
        
        [_topItems addSubview:item1];
        [_topItems addSubview:item2];
        [_topItems addSubview:item3];
        [_topItems addSubview:item4];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Layout(130), kScreenWidth, Layout(10))];
        line.backgroundColor = pageColor;
        
        [_topItems addSubview:line];
        
    }
    return _topItems;
}

- (UIImageViewTouch *)touchItemWithImageName:(NSString *)img
                                       Title:(NSString *)title
                                        Desc:(NSString *)desc
                                       Frame:(CGRect)frame;{
    
    UIImageViewTouch *item = [[UIImageViewTouch alloc]initWithFrame:frame];
    
    UIImageView *itemImg = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(5), Layout(10), Layout(30), Layout(30))];
    itemImg.image = Image(img);
    [item addSubview:itemImg];
    
    UILabel *itemTitle = [UILabel labelWithFrame:CGRectMake(Layout(50), Layout(5), frame.size.width - Layout(50), Layout(20)) Text:title TextFont:Font(16) TextColor:Color333];
    [item addSubview:itemTitle];
    
    UILabel *itemDesc = [UILabel labelWithFrame:CGRectMake(Layout(50), Layout(25), frame.size.width - Layout(50), Layout(20)) Text:desc TextFont:Font(12) TextColor:Color999];
    itemDesc.adjustsFontSizeToFitWidth = YES;
    [item addSubview:itemDesc];
    
    return item;
}

- (LXPageViewController *)topTitle {
    
    if (!_topTitle) {
        
        _topTitle = [[LXPageViewController alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.tabBarController.tabBar.height - kNaviH) Delegate:self];
    }
    return _topTitle;
}

- (StarViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[StarViewModel alloc]init];
    }
    return _viewModel;
}

- (UITableView *)newTable{
    if (!_newTable) {
        _newTable=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _newTable.delegate = self;
        _newTable.dataSource = self;
        _newTable.showsHorizontalScrollIndicator = NO;
        _newTable.showsVerticalScrollIndicator  = NO;
        _newTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _newTable.backgroundColor = pageColor;
    }
    return _newTable;
}

- (UITableView *)hotTable{
    if (!_hotTable) {
        _hotTable=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _hotTable.delegate = self;
        _hotTable.dataSource = self;
        _hotTable.showsHorizontalScrollIndicator = NO;
        _hotTable.showsVerticalScrollIndicator  = NO;
        _hotTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotTable.backgroundColor = pageColor;
    }
    return _hotTable;
}

@end
