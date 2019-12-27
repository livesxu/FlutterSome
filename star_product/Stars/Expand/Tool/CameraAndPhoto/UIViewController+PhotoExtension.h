//
//  UIViewController+PhotoExtension.h
//  Stars
//
//  Created by Livespro on 2016/12/6.
//  Copyright © 2016年 FZ. All rights reserved.
//添加裁剪、、、2016.12.16

#import <UIKit/UIKit.h>
#import "LGPhoto.h"
@class LGPhotoPickerViewController;
@class CameraCustomViewController;

typedef void(^PhotoAction)(UIImage *image);

@interface UIViewController (PhotoExtension)

-(void)photoAlertShowAction:(PhotoAction)photoAction IsClip:(BOOL)isClip;

-(void)cameraerShowAction:(PhotoAction)photoAction IsClip:(BOOL)isClip;

-(void)pickerShowAction:(PhotoAction)photoAction IsClip:(BOOL)isClip;


/**
 上传图片

 @param updateUrl 上传地址
 @param imgUpdate 返回结果
 */
- (void)photoUpdate:(NSString *)updateUrl Action:(void(^)(BOOL isSuccess, UIImage *img,id data))imgUpdate;

@end
