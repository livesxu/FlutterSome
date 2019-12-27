//
//  MobManager.h
//  Stars
//
//  Created by Xu小波 on 2017/11/24.
//  Copyright © 2017年 FZ. All rights reserved.
// 三方登录、分享 -
//
//#import <Foundation/Foundation.h>
//
//#import <ShareSDK/ShareSDK.h>
//
//@interface MobManager : NSObject
//
///**
// 初始化分享平台
// */
//+ (instancetype)manager;
//
///**
// 平台登录
// 
// @param platformType 平台类型
// @param result 返回结果
// */
//- (void)loginWithPlatform:(SSDKPlatformType)platformType Result:(void(^)(BOOL isSuccess,SSDKUser *user))result;
//
///**
// 弹出分享界面
// 
// @param urlString 分享链接
// @param title 标题
// @param images 图片数组,图片类型为网络则元素为字符串,否则为UIImage对象
// @param content 内容
// @param shareType 分享类型
// */
//- (void)showShareActionSheetWithUrlString:(NSString *)urlString
//                                    title:(NSString *)title
//                                   images:(NSArray *)images
//                                  content:(NSString *)content
//                                shareType:(id)shareType;
//
//@end
//
//typedef NS_ENUM(NSInteger, ShareActionViewType) {
//    ShareActionViewTypeCancel,      //取消
//    ShareActionViewTypeWX,          //微信好友
//    ShareActionViewTypeWXFriends,   //微信朋友圈
//    ShareActionViewTypeQQ,          //qq
//    ShareActionViewTypeQQZone,      //qq空间
//    ShareActionViewTypeSina         //新浪
//};
//
//@protocol ShareActionViewDelegate <NSObject>
//
//- (void)ShareActionViewDidSelectWithType:(ShareActionViewType)type;
//
//@end
//
//@interface ShareActionView : UIView
//
//@property (nonatomic, weak) id<ShareActionViewDelegate> delegate;
//
//@end
//
//@interface ShareActionCollectionCell : UICollectionViewCell
//
//@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) UILabel *textLabel;
//
//@end
//
//@interface ShareButton : UIButton
//
//
//
//@end
//
//@interface ShareModel : NSObject
//
//@property (nonatomic,   copy)  NSString *title;
//
//@property (nonatomic,   copy)  NSString *desc;
//
//@property (nonatomic,   copy)  NSString *picPath;//分享的图片过大会导致QQ无法调起。
//
//@property (nonatomic,   copy)  NSString *wapPath;
//
//@end
