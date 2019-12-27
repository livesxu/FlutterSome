//
//  MobManager.m
//  Stars
//
//  Created by Xu小波 on 2017/11/24.
//  Copyright © 2017年 FZ. All rights reserved.
//

//#import "MobManager.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
////#import <TencentOpenAPI/TencentOAuth.h>
////#import <TencentOpenAPI/QQApiInterface.h>
//
////微信SDK头文件
//
//#import "WXApi.h"
//
////新浪微博SDK头文件
//#import "WeiboSDK.h"
//// TODO:
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//
//#pragma mark - 微信
//NSString *const LXWXAppID = @"wxd0abe46a4b8b16a4";
//NSString *const LXWXSecret = @"9c24110ebd8e8885f137e60cb15a69e3";
//
//#pragma mark - QQ
//NSString *const LXQQAPPKey = @"zPUETHpdObVw92VQ";
//NSString *const LXQQAPPID = @"1106556800";
//
////#pragma mark - 微博
////NSString *const LXWBAppKey = @"1488853733";
////NSString *const LXWBSecret = @"aa947c80da9025abb44adb1987e0c04b";
//
//#define ShareManagerItemWidth 57
//#define ShareManagerItemHeight 73
//
//@interface MobManager() <ShareActionViewDelegate> {
//    NSString *_urlString;
//    NSString *_title;
//    NSArray *_images;
//    NSString *_content;
//    id _shareType;//分享类型 - 成功回复
//}
//
///**
// 背景
// */
//@property (nonatomic, strong) UIView *backgroundView;
///**
// 分享界面
// */
//@property (nonatomic, strong) ShareActionView *shareActionView;
//
//
//@end
//
//@implementation MobManager
//
//+ (instancetype)manager {
//    static MobManager *manager;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[MobManager alloc] init];
//    });
//    return manager;
//}
//
//- (instancetype)init {
//    if (self = [super init]) {
//        [self registerAppAndPlatforms];
//    }
//    return self;
//}
//
//
///**
// 平台登录
//
// @param platformType 平台类型
// @param result 返回结果
// */
//- (void)loginWithPlatform:(SSDKPlatformType)platformType Result:(void(^)(BOOL isSuccess,SSDKUser *user))result;{
//
//    [ShareSDK getUserInfo:platformType
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess)
//         {
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//
//             result(YES,user);
//         }
//         else
//         {
//             NSLog(@"%@",error);
//
//             result(NO,nil);
//         }
//     }];
//}
//
//#pragma mark 设置ShareSDK的AppKey
//- (void)registerAppAndPlatforms
//{
//    [ShareSDK registerActivePlatforms:@[
//                                        @(SSDKPlatformTypeQQ),
//                                        @(SSDKPlatformTypeSinaWeibo),
//                                        @(SSDKPlatformTypeWechat),
//                                        ]
//                             onImport:^(SSDKPlatformType platformType) {
//                                 switch (platformType)
//                                 {
//                                     case SSDKPlatformTypeWechat:
//                                         [ShareSDKConnector connectWeChat:[WXApi class]];
//                                         break;
////                                     case SSDKPlatformTypeQQ:
////                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
////                                         break;
//                                     case SSDKPlatformTypeSinaWeibo:
//                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                                         break;
//                                     default:
//                                         break;
//                                 }
//                             }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//
//                          switch (platformType)
//                          {
////                              case SSDKPlatformTypeSinaWeibo:
////                                  //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
////                                  [appInfo SSDKSetupSinaWeiboByAppKey:LXWBAppKey
////                                                            appSecret:LXWBSecret
////                                                          redirectUri:@"http://www.sharesdk.cn"
////                                                             authType:SSDKAuthTypeBoth];
////                                                         break;
//                              case SSDKPlatformTypeWechat:
//                                  [appInfo SSDKSetupWeChatByAppId:LXWXAppID
//                                                        appSecret:LXWXSecret];
//                                  break;
//                              case SSDKPlatformTypeQQ:
//                                  [appInfo SSDKSetupQQByAppId:LXQQAPPID
//                                                       appKey:LXQQAPPKey
//                                                     authType:SSDKAuthTypeBoth];
//                                  break;
//                              default:
//                                  break;
//                          }
//                      }];
//}
//
//- (void)showShareActionSheetWithUrlString:(NSString *)urlString title:(NSString *)title images:(NSArray *)images content:(NSString *)content shareType:(id)shareType {
//
//    _urlString = urlString;
//    _title = title;
//    _images = [images copy];
//    _content = content;
//    _shareType = shareType;
//    [self p_showShareActionView];
//}
//
//- (void)p_showShareActionView {
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    [keyWindow addSubview:self.backgroundView];
//    [keyWindow addSubview:self.shareActionView];
//    [UIView animateWithDuration:0.5 animations:^{
//        _shareActionView.y = kScreenHeight - 203;
//        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    }];
//}
//
//- (void)p_hideShareActionView {
//    [UIView animateWithDuration:0.5 animations:^{
//        _shareActionView.y = kScreenHeight;
//        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
//    } completion:^(BOOL finished) {
//        [self.shareActionView removeFromSuperview];
//        [self.backgroundView removeFromSuperview];
//        _urlString = nil;
//        _title = nil;
//        _images = nil;
//        _content = nil;
//    }];
//}
//
//- (void)activeShare:(ShareActionViewType)type {
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:_content
//                                     images:_images
//                                        url:[NSURL URLWithString:_urlString]
//                                      title:_title
//                                       type:SSDKContentTypeWebPage];
//
//    SSDKPlatformType shareType = SSDKPlatformTypeUnknown;
//    switch (type) {
//        case ShareActionViewTypeCancel:
//            [self p_hideShareActionView];
//            break;
//        case ShareActionViewTypeSina:
//            shareType = SSDKPlatformTypeSinaWeibo;
//            break;
//        case ShareActionViewTypeQQZone:
//            shareType = SSDKPlatformSubTypeQZone;
//            break;
//        case ShareActionViewTypeQQ:
//            shareType = SSDKPlatformSubTypeQQFriend;
//            break;
//        case ShareActionViewTypeWXFriends:
//            shareType = SSDKPlatformSubTypeWechatTimeline;
//            break;
//        case ShareActionViewTypeWX:
//            shareType = SSDKPlatformSubTypeWechatSession;
//            break;
//    }
//    if (shareType == SSDKPlatformTypeUnknown) {
//        return;
//    }
//
//    [ShareSDK share:shareType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//        if (error) {
//
//            switch (type) {
//
//                case ShareActionViewTypeQQZone:
//                    ShowMessage(@"您未安装qq或者版本太旧，无法进行分享");
//                    break;
//                case ShareActionViewTypeQQ:
//                    ShowMessage(@"您未安装qq或者版本太旧，无法进行分享");
//                    break;
//                case ShareActionViewTypeWXFriends:
//                    ShowMessage(@"您未安装微信或者版本太旧，无法进行分享");
//                    break;
//                case ShareActionViewTypeWX:
//                    ShowMessage(@"您未安装微信或者版本太旧，无法进行分享");
//                    break;
//                default:
//                    ShowMessage(@"分享失败");
//                    break;
//            }
//
//            return;
//        }
//        switch (state) {
//            case SSDKResponseStateFail:
//                ShowMessage(@"分享失败");
//                break;
//            case SSDKResponseStateCancel:
//                ShowMessage(@"取消分享");
//                break;
//            case SSDKResponseStateSuccess:
//                ShowMessage(@"分享成功");
//                [self p_hideShareActionView];
//                break;
//            default:
//                break;
//        }
//    }];
//}
//
//#pragma mark - delegate
//
//- (void)ShareActionViewDidSelectWithType:(ShareActionViewType)type {
//    [self activeShare:type];
//}
//
//#pragma marl - lazy
//
//- (ShareActionView *)shareActionView {
//    if (!_shareActionView) {
//        _shareActionView = [[ShareActionView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 203)];
//        _shareActionView.delegate = self;
//    }
//    return _shareActionView;
//}
//
//- (UIView *)backgroundView {
//    if (!_backgroundView) {
//        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
//        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_hideShareActionView)];
//        [_backgroundView addGestureRecognizer:tapG];
//    }
//    return _backgroundView;
//}
//
//@end
//
//@interface ShareActionView() <UICollectionViewDelegate, UICollectionViewDataSource> {
//    NSArray *_titles;
//    NSArray *_images;
//}
//
//@property (nonatomic, strong) UICollectionView *collectView;
//
//@end
//
//@implementation ShareActionView
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self initUIWithFrame:frame];
//    }
//    return self;
//}
//
//- (void)initUIWithFrame:(CGRect)frame {
//    self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
//    _titles = @[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"];
//    _images = @[@"icon_wechat", @"icon_pyq", @"icon_qq", @"icon_qzone"];
//
//    //标题
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, frame.size.width - 30, 13)];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.font = [UIFont systemFontOfSize:12];
//    titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    titleLabel.text = @"分享到";
//    [self addSubview:titleLabel];
//
//    [self addSubview:self.collectView];
//
//    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    cancelBtn.frame = CGRectMake(0, frame.size.height - 43, frame.size.width, 43);
//    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
//    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:(UIControlStateNormal)];
//    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    cancelBtn.backgroundColor = [UIColor whiteColor];
//    @weakify(self);
//    [[cancelBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//        if ([self.delegate respondsToSelector:@selector(ShareActionViewDidSelectWithType:)]) {
//            [self.delegate ShareActionViewDidSelectWithType:(ShareActionViewTypeCancel)];
//        }
//    }];
//    [self addSubview:cancelBtn];
//}
//
//#pragma mark - delegate
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _images.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    ShareActionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShareActionCollectionCell class]) forIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
//    cell.textLabel.text = _titles[indexPath.row];
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self.delegate respondsToSelector:@selector(ShareActionViewDidSelectWithType:)]) {
//        switch (indexPath.row) {
//            case 0:
//                [self.delegate ShareActionViewDidSelectWithType:(ShareActionViewTypeWX)];
//                break;
//            case 1:
//                [self.delegate ShareActionViewDidSelectWithType:(ShareActionViewTypeWXFriends)];
//                break;
//            case 2:
//                [self.delegate ShareActionViewDidSelectWithType:(ShareActionViewTypeQQ)];
//                break;
//            case 3:
//                [self.delegate ShareActionViewDidSelectWithType:(ShareActionViewTypeQQZone)];
//                break;
//            case 4:
//                [self.delegate ShareActionViewDidSelectWithType:(ShareActionViewTypeSina)];
//                break;
//            default:
//                break;
//        }
//    }
//}
//
//#pragma mark - lazy
//
//- (UICollectionView *)collectView {
//    if (!_collectView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(ShareManagerItemWidth, ShareManagerItemHeight);
//        layout.minimumLineSpacing = 15;
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30 + 13, kScreenWidth, 80) collectionViewLayout:layout];
//        [_collectView registerClass:[ShareActionCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([ShareActionCollectionCell class])];
//        _collectView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
//        _collectView.delegate = self;
//        _collectView.dataSource = self;
//        _collectView.showsHorizontalScrollIndicator = NO;
//    }
//    return _collectView;
//}
//
//@end
//
//@implementation ShareActionCollectionCell
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self initUI:frame];
//    }
//    return self;
//}
//
//- (void)initUI:(CGRect)frame {
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ShareManagerItemWidth, ShareManagerItemWidth)];
//    [self addSubview:_imageView];
//    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ShareManagerItemWidth + 10, ShareManagerItemWidth, 10)];
//    _textLabel.font = [UIFont systemFontOfSize:10];
//    _textLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _textLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_textLabel];
//}
//
//@end
//
//
///**
// 分享按钮
// */
//@interface ShareButton ()
//
//@property (nonatomic,   copy)  NSString *linkContent;
//
//@property (nonatomic, strong)  ShareModel *model;
//
//@end
//
//@implementation ShareButton
//
//+ (instancetype)shareLinkContent:(NSString *)content;{
//
//    ShareButton *shareAdd=[[ShareButton alloc]initWithFrame:CGRectMake(0,0, 22, 22)];
//
//    [shareAdd setImage:[UIImage imageNamed:@"icon_share_gray"] forState:UIControlStateNormal];
//
//    [shareAdd addTarget:shareAdd action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    return shareAdd;
//}
//
///**
// *  分享
// @param shareBtn 分享按钮
// */
//- (void)shareAction:(UIButton *)shareBtn;{
//
//    NSString *urlStr = [_model.wapPath containsString:@"%@"] ? [NSString stringWithFormat:_model.wapPath,_linkContent] : _model.wapPath;
//
//    if (!urlStr) return;
//
//    if (_model.picPath && [_model.picPath containsString:@".png"]) {
//        if (![_model.picPath containsString:@"_s"]) {//防止图片太大，取服务器_s的小图 - 改压缩 -
//
//            _model.picPath = [_model.picPath stringByReplacingOccurrencesOfString:@".png" withString:@"_s.png"];
//        }
//    }
//
//    if (!_model.picPath ||!_model.picPath.length) {
//
//        _model.picPath = @"http://10.108.26.242:8080/img/20170831/null/8512620831175539014.png";
//    }
//
//    [[MobManager manager] showShareActionSheetWithUrlString:urlStr title:_model.title images:@[ _model.picPath ] content:_model.desc shareType:nil];
//}
//
//@end
//
//@implementation ShareModel
//
//@end


