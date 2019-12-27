//
//  MineViewController.m
//  Stars
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "MineViewController.h"

#import "StarItemsCollectionViewCell.h"

#import "MineViewModel.h"

@interface MineViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *starItemsCollectionView;

@property (nonatomic, strong) MineViewModel *viewModel;

@property (nonatomic, strong) UILabelTouch *containDiamonds;//我的钻石

@property (nonatomic, strong) UILabel *containChange;//钻石变化

@property (nonatomic, strong) UILabel *totalDiamonds;//星钻总产量

@property (nonatomic, strong) UILabel *todayDiamonds;//今日产量

@property (nonatomic, strong) UILabel *totalTodayPowers;//今日塔可

@property (nonatomic, strong) UILabel *myTodayPower;//我的塔可

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 界面加载
- (void)staticViewsWithoutNib{
    
    [self initViews];
    [self initTopItems];
}

- (void)initViews {
    
    UIImageView *topBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(326.5))];
    topBg.userInteractionEnabled = YES;
    topBg.image = Image(@"home_bg");
    [self.view addSubview:topBg];
    
    _containDiamonds = [[UILabelTouch alloc]initWithFrame:CGRectMake(0, Layout(110), kScreenWidth, Layout(40))];
    _containDiamonds.text = @"0";
    _containDiamonds.font = BoldFont(40);
    _containDiamonds.textAlignment = NSTextAlignmentCenter;
    [topBg addSubview:_containDiamonds];
    
    [_containDiamonds aspect_hookSelector:@selector(touchesBegan:withEvent:) withOptions:AspectPositionAfter usingBlock:^(){
        
        LXRouteMap(@"star://RuleViewController.push?defIndex=1");
    } error:nil];
    
    //插入钻石
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:_containDiamonds.text];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = [UIImage imageNamed:@"home_diamond_n"];
    attchImage.bounds = CGRectMake(Layout(-5), 0, Layout(18), Layout(18));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];

    NSRange range = NSMakeRange(0, 1);
    [mStr insertAttributedString:stringImage atIndex:range.location];
    _containDiamonds.attributedText = mStr;
    
    _containChange = [UILabel labelWithFrame:CGRectMake(0, _containDiamonds.bottomPosition + Layout(15), kScreenWidth, Layout(23)) Text:@"+ 0.0    ↑0.00%" TextFont:Font(16) TextColor:mainColor];
    _containChange.textAlignment = NSTextAlignmentCenter;
    [topBg addSubview:_containChange];
    
    UIView *midHold1 = [[UIView alloc]initWithFrame:CGRectMake(Layout(15), topBg.bottomPosition - Layout(55), kScreenWidth - Layout(30), LayoutHy(100))];
    midHold1.backgroundColor = Colorfff;
    midHold1.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    midHold1.layer.shadowOpacity = .2f;//阴影的透明度
    midHold1.layer.shadowOffset = CGSizeMake(0, 2);//设置阴影的偏移量
    [self.view addSubview:midHold1];
    
    UIView *midHold2 = [[UIView alloc]initWithFrame:CGRectMake(Layout(15), midHold1.bottomPosition + LayoutHy(10), kScreenWidth - Layout(30), LayoutHy(100))];
    midHold2.backgroundColor = Colorfff;
    midHold2.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    midHold2.layer.shadowOpacity = .2f;//阴影的透明度
    midHold2.layer.shadowOffset = CGSizeMake(0, 2);//设置阴影的偏移量
    [self.view addSubview:midHold2];
    
    _totalDiamonds = [self midItemsLoaction:midHold1 Frame:CGRectMake(Layout(35),(midHold1.height - Layout(44))/2, Layout(100), Layout(40)) Icon:@"home_totaldiamond_n" Title:@"星钻总产量"];
    
    _todayDiamonds = [self midItemsLoaction:midHold1 Frame:CGRectMake(Layout(212),(midHold1.height - Layout(44))/2, Layout(100), Layout(40)) Icon:@"home_mydiamond_n" Title:@"今日产量"];
    
    _totalTodayPowers = [self midItemsLoaction:midHold2 Frame:CGRectMake(Layout(35),(midHold2.height - Layout(44))/2, Layout(100), Layout(40)) Icon:@"home_taco_n" Title:@"今日塔可"];
    
    _myTodayPower = [self midItemsLoaction:midHold2 Frame:CGRectMake(Layout(212),(midHold2.height - Layout(44))/2, Layout(100), Layout(40)) Icon:@"home_mytaco_n" Title:@"我的塔可"];
    
    self.starItemsCollectionView.frame = CGRectMake(Layout(15), midHold2.bottomPosition, kScreenWidth - Layout(15), kScreenHeight - midHold2.bottomPosition - self.tabBarController.tabBar.height);
    [self.view addSubview:self.starItemsCollectionView];
}

- (UILabel *)midItemsLoaction:(UIView *)viewHold
                        Frame:(CGRect)frame
                         Icon:(NSString *)img
                        Title:(NSString *)title;{
    
    UIView *itemView = [[UIView alloc]initWithFrame:frame];
    [viewHold addSubview:itemView];
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Layout(25), Layout(25))];
    icon.image = Image(img);
    [itemView addSubview:icon];
    
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(Layout(35), 0, Layout(100), Layout(20)) Text:title TextFont:Font(18) TextColor:Color555];
    [itemView addSubview:titleLabel];
    
    UILabel *numLabel = [UILabel labelWithFrame:CGRectMake(Layout(35), Layout(25), Layout(100), Layout(15)) Text:@"0" TextFont:Font(14) TextColor:Color999];
    numLabel.adjustsFontSizeToFitWidth = YES;
    [itemView addSubview:numLabel];
    
    return numLabel;
}

- (void)initTopItems {
    
    [self.naviStand removeFromSuperview];
    
    CGFloat itemTop = StateHeight + LayoutHy(7);
    
    //我的相关查看
    UIButton *iBtn = [UIButton buttonWithNomalFrame:CGRectMake(Layout(15), itemTop, Layout(30), Layout(30)) Image:Image(@"home_nav_profile_n")];
    [self.view addSubview:iBtn];
    
    [[iBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
//        [CommonRequestApi.alloc.init.lxRequestURL(@"http://172.20.10.2:8080/user").lxBody(@{@"nick_name":@"bobo3",@"password":@"123456",@"id":@(11)}).lxMethod(YTKRequestMethodPOST) startWithNomalCompletionBlock:^(BOOL isSuccess, id responseData) {
//            NSLog(@"%@",responseData);
//        }];
        
        [CommonRequestApi.alloc.init.lxRequestURL(@"http://172.20.10.2:8080/user/0").lxMethod(YTKRequestMethodGET) startWithNomalCompletionBlock:^(BOOL isSuccess, id responseData) {
            NSLog(@"%@",responseData);
        }];
    }];
    
//    //切换明星
//    UIButton *changeBtn = [UIButton buttonWithNomalFrame:CGRectMake(Layout(50), itemTop + Layout(10), Layout(40), Layout(20)) Title:@"切换" TitleFont:Font(16) TitleColor:mainColor BackgroundColor:ColorClear];
//    [self.view addSubview:changeBtn];
//
//    [[changeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//    }];
    
    //历史推送
    UIButton *historyBtn = [UIButton buttonWithNomalFrame:CGRectMake(kScreenWidth - Layout(90), itemTop, Layout(30), Layout(30)) Image:Image(@"home_nav_history_n")];
    [self.view addSubview:historyBtn];
    
    [[historyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    //榜单
    UIButton *topListBtn = [UIButton buttonWithNomalFrame:CGRectMake(kScreenWidth - Layout(45), itemTop, Layout(30), Layout(30)) Image:Image(@"home_nav_list_n")];
    [self.view addSubview:topListBtn];
    
    [[topListBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        LXRouteMap(@"star://TopListViewController.push");
    }];
    
}

/**
 加载数据
 */
- (void)loadData;{
    
    __weak typeof(self) weakSelf = self;
    [self.viewModel layoutRequestBackData:^(BOOL isSuccess) {
        
        weakSelf.containDiamonds.text = weakSelf.viewModel.containDiamonds.integerValue > 10000 ?
        [NSString stringWithFormat:@"%ld",(NSInteger)weakSelf.viewModel.containDiamonds.integerValue] :
        [NSString stringWithFormat:@"%.2f",(CGFloat)weakSelf.viewModel.containDiamonds.floatValue];
        
        //插入钻石
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:weakSelf.containDiamonds.text];
        NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
        attchImage.image = [UIImage imageNamed:@"home_diamond_n"];
        attchImage.bounds = CGRectMake(Layout(-5), 0, Layout(18), Layout(18));
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
        
        NSRange range = NSMakeRange(0, 1);
        [mStr insertAttributedString:stringImage atIndex:range.location];
        weakSelf.containDiamonds.attributedText = mStr;
        
        NSString *changeNum = [NSString subtractCalculate:weakSelf.viewModel.containDiamonds With:weakSelf.viewModel.agoDiamonds];
        BOOL isUp = weakSelf.viewModel.containDiamonds.floatValue >= weakSelf.viewModel.agoDiamonds.floatValue ? YES : NO;
        weakSelf.containChange.text = [NSString stringWithFormat:@"%@ %@    %@%.2f%%",isUp ? @"+" : @"-",changeNum,isUp ? @"↑" : @"↓",changeNum.floatValue/weakSelf.viewModel.agoDiamonds.floatValue *100];
        
        weakSelf.totalDiamonds.text = weakSelf.viewModel.totalDiamonds;
        weakSelf.todayDiamonds.text = weakSelf.viewModel.todayDiamonds;
        weakSelf.totalTodayPowers.text = weakSelf.viewModel.totalTodayPowers;
        weakSelf.myTodayPower.text = weakSelf.viewModel.myTodayPower;
    }];
    
    //获取明星列表
    [self.viewModel mineStarsList:^(BOOL isSuccess) {
        
        [weakSelf.starItemsCollectionView reloadData];
    }];
}
#pragma mark - Change Values


#pragma mark - Delegate

#pragma mark - UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewModel.starsList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StarItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StarItemsCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.model = self.viewModel.starsList[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
#pragma mark -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item!");
}

#pragma mark - Lazy load
- (UICollectionView *)starItemsCollectionView {
    
    if (!_starItemsCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(LayoutHy(80), LayoutHy(80));
        flowLayout.minimumLineSpacing = Layout(15);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _starItemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _starItemsCollectionView.backgroundColor = [UIColor clearColor];
        _starItemsCollectionView.showsHorizontalScrollIndicator = NO;
        _starItemsCollectionView.showsVerticalScrollIndicator = NO;
        [_starItemsCollectionView registerClass:[StarItemsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([StarItemsCollectionViewCell class])];
        _starItemsCollectionView.dataSource = self;
        _starItemsCollectionView.delegate = self;
        
    }
    return _starItemsCollectionView;
}

- (MineViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[MineViewModel alloc]init];
    }
    return _viewModel;
}

@end
